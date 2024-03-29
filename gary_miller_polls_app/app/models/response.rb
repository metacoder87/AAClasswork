class Response < ApplicationRecord
    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: 'AnswerChoice'

    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :respondent_id,
        class_name: 'User'

    has_one :question,
        through: :answer_choice,
        source: :question

    validate :not_duplicate_response, unless: -> { answer_choice.nil? }

    validate :respondent_is_not_poll_author, unless: -> { answer_choice.nil? }

    def sibling_responses
        ids = { answer_choice_id: self.answer_choice_id, id: self.id }
        Response.find_by_sql([<<-SQL, ids])
        SELECT 
            responses.*
        FROM (
            SELECT
                questions.*
            FROM
                questions
            JOIN
                answer_choices ON questions.id = answer_choices.question_id
            WHERE
                answer_choices.id = :answer_choice_id
        )   AS questions
        JOIN
            answer_choices ON questions.id = answer_choices.question_id
        JOIN
            responses ON answer_choices.id = responses.answer_choice_id
        WHERE
            (:id IS NULL) OR (responses.id != :id)
        SQL
    end

    def respondent_already_answered?
        sibling_responses.exists?(respondent_id: self.respondent_id)
    end

private

    def not_duplicate_response
        if respondent_already_answered?
            errors[:respondent_id] << 'cannot vote more than once per question'
        end
    end

    def respondent_is_not_poll_author
        poll_author_id = Poll
            .joins(questions: :answer_choices)
            .where('answer_choices.id = ?', self.answer_choice_id)
            .pluck('polls.author_id')
            .first

        if poll_author_id = self.respondent_id
            errors[:respondent_id] << 'cannot author poll'
        end
    end
end