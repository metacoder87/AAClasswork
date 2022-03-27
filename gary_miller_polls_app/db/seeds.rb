# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
    User.destroy_all
    Poll.destroy_all
    Question.destroy_all
    AnswerChoice.destroy_all
    Response.destroy_all

    user1 = User.create!(
        username: 'Dantelion'
    )
    user2 = User.create!(
        username: 'Feynmen'
    )

    poll1 = Poll.create!(
        title: 'Quantum Limits', 
        author: user2
    )
    poll2 = Poll.create!(
        title: 'Demonic Entanglement', 
        author: user1
    )

    q1 = Question.create!(
        text: 'What is the smallest scale?', 
        poll: poll1
    )
    ac1 = AnswerChoice.create!(
        text: 'Bathroom', 
        question: q1
    )
    ac2 = AnswerChoice.create!(
        text: 'Nano', 
        question: q1
    )
    ac3 = AnswerChoice.create!(
        text: 'Planck', 
        question: q1
    )

    q2 = Question.create!(
        text: 'The equation which gives the mathematical 
                apparatus for the description of quantum 
                mechanical systems was formulated by, and 
                is named after, which Austrian physicist?', 
        poll: poll1
    )
    ac4 = AnswerChoice.create!(
        text: 'Gerhard Schröder', 
        question: q2
    )
    ac5 = AnswerChoice.create!(
        text: 'Arnold Schwarzenegger', 
        question: q2
    )
    ac6 = AnswerChoice.create!(
        text: 'James R. Schlesinger', 
        question: q2
    )
    ac7 = AnswerChoice.create!(
        text: 'Erwin Schrödinger', 
        question: q2
    )

    r1 = Response.create!(
        respondent: user1,
        answer_choice: ac3
    )

    r2 = Response.create!(
        respondent: user1,
        answer_choice: ac7
    )

end