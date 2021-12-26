require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionFollow

    def self.find_by_id(id)
        qfollow = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless qfollow.length > 0
    end

end
