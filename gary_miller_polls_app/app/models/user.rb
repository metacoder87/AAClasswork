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
private

    def polls_with_completion_counts
        joins_sql = <<-SQL
            LEFT OUTER JOIN (
                SELECT
                    *
                FROM
                    responses
                WHERE
                    respondent_id = #{self.id}
            ) AS responses ON answer_choices.id = responses.answer_choice_id
        SQL

        Poll.joins(questions: :answer_choices)
                .joins(joins_sql)
                .group('polls.id')
    end
    
end