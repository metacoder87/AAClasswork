require_relative 'questions_database'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'user'
require_relative 'reply'

class Question

    def self.all
        question = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                questions
            SQL
    end

    def self.find_by_id(id)
        question = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question.first)
    end

    def self.find_by_questioner_id(questioner_id)
        hashed = { questioner_id: questioner_id }
        questioner = QuestionsDatabase.instance.execute(<<-SQL, hashed)
        SELECT
            *
        FROM
            questions
        WHERE
            questions.questioner_id = :questioner_id
        SQL
        
        questioner.map { |data| Question.new(data) }
    end

    def self.find_by_title(title)
        titled = { title: title }
        question = QuestionsDatabase.instance.execute(<<-SQL, titled)
        SELECT
            *
        FROM
            questions
        WHERE
            questions.title = :title
        SQL
       question.map { |data| Question.new(data) }
    end

    attr_reader :id, :questioner_id
    attr_accessor :title, :body

    def initialize(options)
        @id, @questioner_id, @title, @body = 
        options.values_at('id', 'questioner_id', 'title', 'body')
    end
    
end