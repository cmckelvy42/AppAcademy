class Bootcamp
    @name 
    @student_capacity 
    @slogan
    @teachers 
    @students 
    @grades

    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new {|h, k| h[k] = []}
    end

    def name
        @name
    end
    def slogan
        @slogan 
    end
    def teachers 
        @teachers
    end
    def students
        @students 
    end
    def hire(teacher)
        @teachers << teacher
    end
    def enroll(student)
        return false unless @students.size < @student_capacity
        @students << student
        true 
    end
    def enrolled?(student)
        @students.each {|s| return true if s.downcase == student.downcase}
        return false
    end
    def student_to_teacher_ratio
        return @students.size / @teachers.size
    end
    def add_grade(student, grade)
        if enrolled?(student)
            @grades[student] << grade
            return true
        end
        return false
    end
    def num_grades(student)
        if (enrolled?(student))
            return @grades[student].size
        end
        return 0
    end
    def average_grade(student)
        if !enrolled?(student) || num_grades(student) == 0
            return nil
        end
        return @grades[student].sum / num_grades(student)
    end

end
