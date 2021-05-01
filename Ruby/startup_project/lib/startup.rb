require "employee"
require "byebug"
class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return @salaries.keys.any?(title)
    end

    def >(rhs)
        return @funding > rhs.funding
    end

    def <(rhs)
        return @funding < rhs.funding
    end

    def hire(employee_name, title)
        if !valid_title?(title)
            raise "Invalid title"
        else
            @employees << Employee.new(employee_name, title)
        end
    end

    def size
        @employees.size
    end

    def pay_employee(employee)
        salary = @salaries[employee.title]
        if salary <= @funding
            employee.pay(salary)
            @funding -= salary
            return true
        end
        raise "Not enough funding"
        return false
    end

    def payday
        @employees.each {|e| pay_employee(e)}
    end
    def average_salary
        return employees.inject(0){|a, e| a += @salaries[e.title]} / (@employees.size * 1.0)
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        @employees += startup.employees
        startup.salaries.each {|k, v| @salaries[k] = v if !@salaries[k]}
        startup.close
    end

end
