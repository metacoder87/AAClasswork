require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class QuestionLike

    def self.find_by_id(id)
        qlike = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        return nil unless qlike.length > 0
    end

end