require_relative 'questions_database'
require_relative 'user'
require_relative 'question'

class Reply

    def self.find_by_id(id)
        reply = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless reply.length > 0
    end

end