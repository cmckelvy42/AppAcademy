require 'sqlite3'
require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
class Reply
    attr_accessor :question_id, :parent_reply_id, :author_id, :body
    attr_reader :id
    
    def self.all
        data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
        data.map{|e| Reply.new(e)}
    end
    
    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
        SELECT * FROM replies
        WHERE id = ?
        SQL
        return nil if reply.empty?
        return Reply.new(reply.first)
    end

    def self.find_by_author_id(author_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT * FROM replies
        WHERE author_id = ?
        SQL
        return nil if replies.empty?
        replies.map{|e| Reply.new(e)}
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT * FROM replies
        WHERE question_id = ?
        SQL
        return nil if replies.empty?
        replies.map{|e| Reply.new(e)}
    end

    def self.find_by_parent_id(parent_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
        SELECT * FROM replies
        WHERE parent_reply_id = ?
        SQL
        return nil if replies.empty?
        replies.map{|e| Reply.new(e)}
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end

    def create
        raise "#{self} already in the database!" if @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @author_id, @body)
        INSERT INTO replies(question_id, parent_reply_id, author_id, body)
        VALUES (?,?,?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not already in the database!" unless @id
        QuestionsDatabase.instance.execute(<<-SQL, @question_id, @parent_reply_id, @author_id, @body, @id)
        UPDATE replies
        SET question_id = ?, parent_reply_id = ?, author_id = ?, body = ?
        WHERE id = ?
        SQL
    end

    def author
        return User.find_by_id(@author_id)
    end

    def question
        return Question.find_by_id(@question_id)
    end

    def parent_reply
        return Reply.find_by_id(@parent_reply_id)
    end

    def child_replies
        return Reply.find_by_parent_id(@id)
    end


end