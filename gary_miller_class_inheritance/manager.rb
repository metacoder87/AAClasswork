


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

david = Employee.new("David", "TA", 10000, "Darren")
shawna = Employee.new("Shawna", "TA", 12000, "Darren")
darren = Manager.new("Darren", "TA Manager", 78000, "Ned", [shawna, david])
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren, shawna, david])

puts ned.bonus(5) # => 500_000
puts darren.bonus(4) # => 88_000
puts david.bonus(3) # => 30_000