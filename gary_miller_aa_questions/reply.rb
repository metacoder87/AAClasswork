require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class Reply

    def self.all
        reply = QuestionsDatabase.instance.execute(<<-SQL)
            SELECT
                *
            FROM
                replies
            SQL
    end

    def self.find_by_id(id)
        hashed = { id: id }
        reply = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                replies
            WHERE
                replies.id = :id
        SQL
        reply.map { |data| Reply.new(data) }
    end

    def self.find_by_parent_reply_id(parent_reply_id)
        hashed = { parent_reply_id: parent_reply_id }
        reply = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                replies
            WHERE
                replies.parent_reply_id = :parent_reply_id
            SQL
        reply.map { |data| Reply.new(data) }
    end

    def self.find_by_user_id(user_id)
        hashed = { user_id: user_id }
        reply = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                replies
            WHERE
                replies.replier_id = :user_id
            SQL
        reply.map { |data| Reply.new(data) }
    end

    def self.find_by_question_id(question_id)
        hashed = { question_id: question_id }
        reply = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                replies
            WHERE
                replies.question_id = :question_id
            SQL
        reply.map { |data| Reply.new(data) }
    end

    def initialize(options)
        @id, @parent_reply_id = nil, @replier_id, @question_id, @body =
            options.values_at('id', 'parent_reply_id', 'replier_id', 'question_id', 'body')
    end

    def save
        hashed = { parent_reply_id: parent_reply_id, replier_id: replier_id, question_id: question_id, body: body }

        if @id
            QuestionsDatabase.execute(<<-SQL, hashed.merge( { id: id } ))
                UPDATE
                    replies
                SET
                    parent_reply_id = :parent_reply_id, replier_id = :replier_id, question_id = :question_id, body = :body
                WHERE
                    replies.id = :id
            SQL
        else
            QuestionsDatabase.execute(<<-SQL, hashed)
                INSERT INTO
                    replies (parent_reply_id, replier_id, question_id, body)
                VALUES
                    (:parent_reply_id, :replier_id, :question_id, :body)
            SQL

            @id = QuestionsDatabase.last_insert_row_id
        end
        self
    end

    def author
        User.find_by_id(replier_id)
    end

    def question
        Question.find_by_id(question_id)
    end

    def parent_reply
        Reply.find_by_id(parent_reply_id)
    end

    def child_replies
        Reply.find_by_parent_reply_id(id)
    end

end