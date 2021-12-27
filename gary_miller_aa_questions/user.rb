require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'

class User

    def self.all
        user = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                users
            SQL
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless user.length > 0

        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        hashed = { fname: fname, lname: lname }
        user = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                users
            WHERE
                users.fname = :fname AND users.lname = :lname
        SQL
        return nil unless user.length > 0

        User.new(user.first)
    end

    attr_reader :id
    attr_accessor :fname, :lname

    def initialize(options = {})
        @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
    end

    def authored_questions
        Question.find_by_author_id(id)
    end
    
end