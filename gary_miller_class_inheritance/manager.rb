


require_relative 'employee'

class Manager < Employee

    def initialize(name, title, salary, boss, employees)
        @employees = employees
        super(name, title, salary, boss)
    end

end