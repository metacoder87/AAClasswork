


require_relative 'employee'

class Manager < Employee

    attr_reader :employees

    def initialize(name, title, salary, boss, employees)
        @employees = employees
        super(name, title, salary, boss)
    end

    def bonus(multiplier)
        return @employees.map { |worker| worker.salary }.inject(:+) * multiplier
    end

end