class Question < ApplicationRecord
    validates :text, presence: true

    belongs_to :poll,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: 'Poll'

    has_many :answer_choices,
        primary_key: :id,
        foreign_key: :question_id,
        class_name: 'AnswerChoice'

    has_many :responses,
        through: :answer_choices,
        source: :responses

    def results_n_plus_one
        results = {}
        self.answer_choices.each do |ac|
            results[ac.text] = ac.responses.count
        end
        return results
    end

    def results_two_queries
        results = {}
        self.answer_choices.includes(:responses).each do |ac|
            results[ac.text] = ac.responses.length
        end
        return results
    end

    def results_all_sql
        ac = AnswerChoice.find_by_sql([<<-SQL, id])
        SELECT
            answer_choices.text, COUNT(responses.id) AS num_responses
        FROM
            answer_choices
            LEFT OUTER JOIN responses
                ON answer_choices.id = responses.answer_choice_id
            WHERE
                answer_choices.question_id = ?
            GROUP BY
                answer_choices.id
        SQL

        ac.inject({}) do |results, answer|
            results[answer.text] = answer.num_responses; results
        end

    end

    def results
        ac = self.answer_choices
                    .select('answer_choices.text, COUNT(responses.id) AS num_responses')
                    .left_outer_joins(:responses)
                    .group('answer_choices.id')

        ac.inject({}) do |results, answer|
            results[answer.text] = answer.num_responses; results
        end
    end
end