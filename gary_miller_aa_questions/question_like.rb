require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionLike

    def self.all
        like = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                question_likes
            SQL
    end

    def self.likers_for_question_id(question_id)
        hashed = { question_id: question_id }
        likers = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                users
            JOIN
                question_likes
            ON
                users.id = question_likes.liker_id
            WHERE
                question_likes.question_id = :question_id
            SQL
        likers.map { |data| User.new(data) }
    end

    def self.num_likes_for_question_id(question_id)
        hashed = { question_id: question_id }
        question_data = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                COUNT(*) AS likes
            FROM
                questions
            JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                questions.id = :question_id
        SQL
    end

    def self.liked_questions_for_user_id(user_id)
        hashed = { user_id: user_id }
        question = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                questions
            JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                question_likes.liker_id = :user_id
            SQL
        question.map { |data| Question.new(data) }
    end

    def self.find_by_id(id)
        hashed = { id: id }
        like = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                question_likes
            WHERE
                question_likes.id = :id
            SQL
        like.map { |data| QuestionLike.new(data) }
    end

    def self.find_by_liker_id(liker_id)
        hashed = { liker_id: liker_id }
        like = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                question_likes
            WHERE
                question_likes.liker_id = :liker_id
            SQL

        like.map { |data| QuestionLike.new(data) }
    end

    def self.find_by_question_id(question_id)
        hashed = { question_id: question_id }
        like = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                question_likes
            WHERE
                question_likes.question_id = :question_id
            SQL
        like.map { |data| QuestionLike.new(data) }
    end

    def initialize(options)
        @id, @liker_id, @question_id =
            options.values_at('id', 'liker_id', 'question_id')
    end

end