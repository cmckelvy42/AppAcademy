require "singleton"
require "sqlite3"
class QuestionsDatabase < SQLite3::Database
    #In a real scenario, would use a factory or a connection pool, but this is what they want for the lesson
    include Singleton
    
    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end