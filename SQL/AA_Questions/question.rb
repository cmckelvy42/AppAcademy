require 'sqlite3'
require_relative 'questions_database'
require_relative 'user'
require_relative 'reply'
require_relative 'question_follow'
require_relative 'question_like'
class Question
    attr_accessor :title, :body, :author_id
    attr_reader :id
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
        data.map{|e| Question.new(e)}
    end
    
    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM questions
        WHERE id = ?
        SQL
        return nil if question.empty?
        return Question.new(question.first)
    end

    def self.find_by_author_id(author_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT * FROM questions
        WHERE author_id = ?
        SQL
        return nil if questions.empty?
        questions.map{|e| Reply.new(e)}
    end

    def self.most_followed(n)
        return QuestionFollow.most_followed_questions(n)
    end

    def self.most_liked(n)
        return QuestionLike.most_liked_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def create
        raise "#{self} already in the database!" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id)
        INSERT INTO questions(title, body, author_id)
        VALUES (?,?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not already in the database!" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @title, @body, @author_id, @id)
        UPDATE questions
        SET title = ?, body = ?, @author_id = ?
        WHERE id = ?
        SQL
    end

    
    def author
        return User.find_by_id(@author_id)
    end

    def questions
        return Reply.find_by_question_id(@id)
    end

    def followers
        return QuestionFollow.followers_for_question_id(@id)
    end
    
    def num_likes
        return QuestionLike.num_likes_for_question_id(@id)
    end

    def likers
        return QuestionLike.likers_for_question_id(@id)
    end


end