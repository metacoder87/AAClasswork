require_relative 'questions_database'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'

class User

    def self.all
        user = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                users
            SQL
    end

    def self.find_by_id(id)
        user = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless user.length > 0

        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        hashed = { fname: fname, lname: lname }
        user = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                users
            WHERE
                users.fname = :fname AND users.lname = :lname
        SQL
        return nil unless user.length > 0

        User.new(user.first)
    end

    attr_reader :id
    attr_accessor :fname, :lname

    def initialize(options = {})
        @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
    end

    def authored_questions
        Question.find_by_author_id(id)
    end

    def authored_replies
        Reply.find_by_user_id(id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(id)
    end

    def average_karma
        question = QuestionsDatabase.get_first_value(<<-SQL, user_id: id)
            SELECT
                CAST(COUNT(question_likes.id) AS FLOAT) /
                COUNT(DISTINCT(questions.id)) AS karma_pts
            FROM
                questions
            LEFT OUTER JOIN
                question_likes
            ON
                question.id = question_likes.question_id
            WHERE
                questions.questioner_id = :user_id
            SQL
        question.map { |data| Question.new(data) }
    end

    def save
        hashed = { fname: @fname, lname: @lname }
        
        if @id
            QuestionsDatabase.execute(<<-SQL, hashed.merge({ id: id }))
                UPDATE
                    users
                SET
                    fname = :fname, lname = :lname
                WHERE
                    users.id = :id
            SQL
        else
            QuestionsDatabase.execute(<<-SQL, hashed)
                INSERT INTO
                    users (fname, lname)
                VALUES
                    (:fname, :lname)
            SQL

            @id = QuestionsDatabase.last_insert_row_id
        end
        self
    end

end