require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    clmns = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT 0
    SQL
    clmns.map!(&:to_sym)
    @columns = clmns
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end
      define_method("#{column}=") do |value|
        self.attributes[column] = value
      end
    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name || self.name.underscore.pluralize
  end

  def self.all
    # ...
    everything = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    parse_all(everything)
  end

  def self.parse_all(results)
    # ...
    results.map { |result| self.new(result) }
  end

  def self.find(id)
    # ...
    results = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{table_name}
      WHERE id = ?
    SQL
    
    parse_all(results).first
  end

  def initialize(params = {})
    # ...
    params.each do |name, val|
      name = name.to_sym
      if self.class.columns.include?(name)
        self.send("#{name}=", val)
      else
        raise "unknown attribute '#{name}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map { |attr| self.send(attr) }
  end

  def insert
    # ...
    columns = self.class.columns.drop(1)
    names = columns.map(&:to_s).join(", ")
    question_marks = (["?"] * columns.count).join(", ")

    DBConnection.execute(<<-SQL, *attribute_values.drop(1))
      INSERT INTO
        #{self.class.table_name} (#{names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    # ...
    set_line = self.class.columns
      .map { |attr| "#{attr}= ?" }.join(", ")

    DBConnection.execute(<<-SQL, *attribute_values, id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        #{self.class.table_name}.id = ?
    SQL
  end

  def save
    # ...
    id.nil? ? insert : update
  end
end
