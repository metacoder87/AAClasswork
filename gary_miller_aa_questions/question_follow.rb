require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow

    def self.all
        follow = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                question_follows
            SQL
    end

    def self.find_by_id(id)
        hashed = { id: id }
        follow = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                question_follows
            WHERE
                question_follows.id = :id
        SQL
        follow.map { |data| QuestionFollow.new(data) }
    end

    def self.find_by_follower_id(follower_id)
        hashed = { follower_id: follower_id }

        follow = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                question_follows
            WHERE
                question_follows.follower_id = :follower_id
            SQL

        follow.map { |data| QuestionFollow.new(data) }
    end

    def self.find_by_question_id(question_id)
        hashed = { question_id: question_id }

        follow = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                question_follows
            WHERE
                question_follows.question_id = :question_id
            SQL

        follow.map { |data| QuestionFollow.new(data) }
    end

    def initialize(options)
        @id, @follower_id, @question_id =
            options.values_at('id', 'follower_id', 'question_id')
    end

end