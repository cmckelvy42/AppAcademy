require 'sqlite3'
require_relative 'questions_database'
class QuestionLike
    attr_accessor :title, :body, :author_id
    attr_reader :id
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
        data.map{|e| QuestionLike.new(e)}
    end
    
    def self.find_by_id(id)
        question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM question_likes
        WHERE id = ?
        SQL
        return nil if question_like.empty?
        return QuestionLike.new(question_like.first)
    end

    def self.likers_for_question_id(question_id)
        likeers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT users.id, fname, lname 
        FROM users JOIN question_likes ON user_id = users.id 
        WHERE question_id = ?;
        SQL
        return nil if likeers.empty?
        likeers.map{|e| User.new(e)}
    end

    def self.num_likes_for_question_id(question_id)
        num = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT count(user_id) as 'count'
        FROM questions JOIN question_likes ON questions.id = question_id
        WHERE question_id = ?
        GROUP BY question_id
        SQL
        return nil if num.empty?
        return num.first["count"]
    end

    def self.liked_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT questions.id, title, body, author_id 
        FROM questions JOIN question_likes ON question_id = questions.id 
        WHERE user_id = ?;
        SQL
        return nil if questions.empty?
        questions.map{|e| Question.new(e)}
    end

    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT questions.id, title, body, author_id
        FROM questions JOIN question_likes ON questions.id = question_id
        GROUP BY question_id
        ORDER BY count(user_id) desc
        limit ?
        SQL
        return nil if questions.empty?
        questions.map{|e| Question.new(e)}
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def create
        raise "#{self} already in the database!" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
        INSERT INTO question_likes(user_id, question_id)
        VALUES (?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not already in the database!" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
        UPDATE question_likes
        SET user_id = ?, question_id = ?
        WHERE id = ?
        SQL
    end
end