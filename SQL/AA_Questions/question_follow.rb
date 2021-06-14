require 'sqlite3'
require_relative 'questions_database'
class QuestionFollow
    attr_accessor :title, :body, :author_id
    attr_reader :id
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
        data.map{|e| QuestionFollow.new(e)}
    end
    
    def self.find_by_id(id)
        question_follow = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM question_follows
        WHERE id = ?
        SQL
        return nil if question_follow.empty?
        return QuestionFollow.new(question_follow.first)
    end

    def self.followers_for_question_id(question_id)
        followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT users.id, fname, lname 
        FROM users JOIN question_follows ON user_id = users.id 
        WHERE question_id = ?;
        SQL
        return nil if followers.empty?
        followers.map{|e| User.new(e)}
    end

    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT questions.id, title, body, author_id 
        FROM questions JOIN question_follows ON question_id = questions.id 
        WHERE user_id = ?;
        SQL
        return nil if questions.empty?
        questions.map{|e| Question.new(e)}
    end

    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT questions.id, title, body, author_id
        FROM questions JOIN question_follows ON questions.id = question_id
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
        INSERT INTO question_follows(user_id, question_id)
        VALUES (?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not already in the database!" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
        UPDATE question_follows
        SET user_id = ?, question_id = ?
        WHERE id = ?
        SQL
    end
    



end