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
    end

    def results_two_queries
        results = {}
        self.answer_choices.includes(:responses).each do |ac|
            results[ac.text] = ac.responses.length
        end
        return results
    end

end