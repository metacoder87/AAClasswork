require 'rspec'
require 'poker'

describe Card do
    let(:card) do
        Card.new(:hearts, :Queen)
    end

        it 'holds suit' do
            expect(card.suit).to be(:hearts)
        end

        it "holds value" do
            expect(card.suit).to be(:Queen)
        end

end

describe Deck do
    let(:deck) do
        Deck.new
    end

        it 'has fifty-two cards' do
            expect(deck.cards.count).to eq(52)
        end

        it 'has four suits' do
            expect(deck.cards.keys.count).to eq(4)
        end

        it 'has thirteen cards in each suit' do
            expect(deck.cards[:hearts].count).to eq(13)
        end

end

describe Hand do
    let(:hand) do
        Hand.new([:D4,:S2,:DJ,:CQ,:HA])
    end

        it 'should know it has nothing' do
            expect(hand.rank).to be(:ace_high)
        end

    let(:hand) do
        Hand.new([:D4,:SJ,:DJ,:CQ,:HA])
    end

        it 'should know it has a pair' do
            expect(hand.rank).to be(:a_pair)
        end

    let(:hand) do
        Hand.new([:D4,:S4,:DQ,:CQ,:HA])
    end

        it 'should know it has two-pair' do
            expect(hand.rank).to be(:two_pair)
        end

    let(:hand) do
        Hand.new([:HQ,:HA,:C10,:SA,:DA])
    end

        it 'should know it has three of a kind' do
            expect(hand.rank).to be(:three_of_kind)
        end

    let(:hand) do
        Hand.new([:D4,:S5,:D6,:C7,:H8])
    end

        it 'should know it has a straight' do
            expect(hand.rank).to be(:straight)
        end

    let(:hand) do
        Hand.new([:D4,:D2,:DJ,:DQ,:DA])
    end

        it 'should know it has a flush' do
            expect(hand.rank).to be(:flush)
        end

    let(:hand) do
        Hand.new([:D4,:S4,:DJ,:C4,:HJ])
    end

        it 'should know it has a full-house' do
            expect(hand.rank).to be(:full_house)
        end

    let(:hand2) do
        Hand.new([:D8,:D9,:D10,:DJ,:DQ])
    end

        it 'should know it has a straight-flush' do
            expect(hand2.rank).to be(:straight_flush)
        end

    let(:hand) do
        Hand.new([:D4,:S4,:H4,:C4,:HA])
    end

        it 'should know it has four-of-a-kind' do
            expect(hand.rank).to be(:four_of_a_kind)
        end

end

describe Player do
    let(:player) do
        Player.new
    end
end

describe Game do
    let(:game) do
        Game.new
    end
end