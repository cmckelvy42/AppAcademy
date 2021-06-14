require 'sqlite3'
require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
class User
    attr_accessor :fname, :lname
    attr_reader :id
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM users")
        data.map{|e| User.new(e)}
    end
    
    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM users
        WHERE id = ?
        SQL
        return nil if user.empty?
        return User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT * FROM users
        WHERE fname = ? AND lname = ?
        SQL
        return nil if users.empty?
        users.map{|e| User.new(e)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create
        raise "#{self} already in the database!" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname)
        INSERT INTO users(fname, lname)
        VALUES (?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in the database!" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @fname, @lname, @id)
        UPDATE users
        SET fname = ?, lname = ?
        WHERE id = ?
        SQL
    end

    def authored_questions
        return Question.find_by_author_id(@id)
    end

    def authored_replies
        return Reply.find_by_user_id(@id)
    end

    def followed_questions
        return QuestionFollow.followed_questions_for_user_id(@id)
    end

    def liked_questions
        return QuestionLike.liked_questions_for_user_id(@id)
    end

    def average_karma
        counts = QuestionsDatabase.instance.execute(<<-SQL, 1)
        SELECT COUNT(distinct questions.id) as num_questions, COUNT(user_id) as num_likes
        FROM questions LEFT OUTER JOIN question_likes ON questions.id = question_likes.question_id
        WHERE author_id = ?;
        SQL
        counts = counts.first
        num_questions = counts['num_questions'] * 1.0
        num_likes = counts['num_likes']
        num_likes / num_questions
    end
    
    

end