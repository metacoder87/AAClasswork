require 'rspec'
require 'poker'

describe Card do
    let(:card) do
        Card.new(:hearts, :Queen)
    end

        describe initialize do
            
            it 'holds suit' do
                expect(card.suit).to be(:hearts)
            end

            it "holds value" do
                expect(card.suit).to be(:Queen)
            end

        end

end

describe Deck do
    let(:deck) do
        Deck.new
    end
end

describe Hand do
    let(:hand) do
        Hand.new()
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