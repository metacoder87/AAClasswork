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

    def self.find_by_author_id(author_id)
        hashed = { author_id: author_id }
        question = QuestionsDatabase.instance.execute(<<-SQL, hashed)
            SELECT
                *
            FROM
                questions
            WHERE
                questions.questioner_id = :author_id
            SQL
        
        question.map { |data| Question.new(data) }
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

    def save
        hashed = { questioner_id: questioner_id, title: title, body: body }

        if @id
            QuestionsDatabase.execute(<<-SQL, hashed.merge( { id: id } ))
                UPDATE
                    users
                SET
                    questioner_id = :questioner_id, title = :title, body = :body
                WHERE
                    questions.id = :id
            SQL
        else
            QuestionsDatabase.execute(<<-SQL, hashed)
                INSERT INTO
                    users (questioner_id, title, body)
                VALUES
                    (:questioner_id, :title, :body)
            SQL

            @id = QuestionsDatabase.last_insert_row_id
        end
        self
    end

    def author
        User.find_by_id(questioner_id)
    end

    def replies
        Reply.find_by_question_id(id)
    end

    def followers
        QuestionFollow.followers_for_question_id(id)
    end

    def most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def likers
        QuestionLike.likers_for_question_id(id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(id)
    end

    def most_liked(n)
        QuestionLike.most_liked_questions(n)
    end
    
end