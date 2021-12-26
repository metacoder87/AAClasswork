

class Question

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
        questioner = QuestionDatabse.instance.execute(<<-SQL, questioner_id)
        SELECT
            *
        FROM
            questions
        WHERE
            questioner_id = ?
        SQL
        return nil unless questioner.length > 0
    end

    def self.find_by_title(title)
        question = QuestionsDatabase.instance.execute(<<-SQL, title)
        SELECT
            *
        FROM
            questions
        WHERE
            title = ?
        SQL
        return nil unless question.length > 0
    end
    
    def self.find_by_body(body)
        question = QuestionsDatabase.instance.execute(<<-SQL, body)
        SELECT
            *
        FROM
            questions
        WHERE
            body = ?
        SQL
        return nil unless question.length > 0
    end
    
end