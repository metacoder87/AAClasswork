require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class User

    self.find_by_id(id)
        user = QuestionDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        return nil unless user.length > 0
    end

    self.find_by_name(fname, lname)
        user = QuestionDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?
                lname = ?
        SQL
        return nil unless user.length > 0
    end
end

class Question

    self.find_by_id(id)
        question = QuestionDatabase.instance.execute(<<-SQL, id)
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

end

class QuestionFollow

end

class Reply

end

class QuestionLike

end