class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :authored_polls,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: 'Poll'

    has_many :responses,
        primary_key: :id,
        foreign_key: :respondent_id,
        class_name: 'Response'

    def incomplete_polls
        polls_with_completion_counts
            .having('COUNT(DISTINCT questions.id) > COUNT(responses.id)')
            .having('COUNT(responses.id) > 0')
    end

end