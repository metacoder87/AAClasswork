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
            expect(card.value).to be(:Queen)
        end

end

describe Deck do
    let(:deck) do
        Deck.new
    end

        it 'has fifty-two cards' do
            expect(deck.cards.values.flatten.count).to eq(52)
        end

        it 'has four suits' do
            expect(deck.cards.keys.count).to eq(4)
        end

        it 'has thirteen cards in each suit' do
            expect(deck.cards[:hearts].count).to eq(13)
        end

end

describe Hand do
    let(:deck) do
        Deck.new
    end
        
        describe "#high_card" do
            subject(:hand) { Hand.new([deck.cards.values[0][3],deck.cards.values[0][9],deck.cards.values[3][0],deck.cards.values[1][7],deck.cards.values[2][12]]) }
            it 'should know it has nothing' do
                expect(hand.rank).to eq(:ace_high)
            end
        end

        describe "#pair?" do
            subject(:hand) { Hand.new([deck.cards.values[0][3],deck.cards.values[0][1],deck.cards.values[3][3],deck.cards.values[1][2],deck.cards.values[2][12]]) }
            it 'should know it has a pair' do
                expect(hand.rank).to be(:pair)
            end
        end

        describe "#three_of_kind?" do
            subject(:hand) { Hand.new([deck.cards.values[0][3],deck.cards.values[0][1],deck.cards.values[3][3],deck.cards.values[1][3],deck.cards.values[2][12]]) }
            it 'should know it has three of a kind' do
                expect(hand.rank).to be(:three_of_kind)
            end
        end

        describe "#full_house?" do
            subject(:hand) { Hand.new([deck.cards.values[0][3],deck.cards.values[0][12],deck.cards.values[3][3],deck.cards.values[1][3],deck.cards.values[2][12]]) }
            it 'should know it has a full-house' do
                expect(hand.rank).to be(:full_house)
            end
        end

        describe "#two_pair?" do
            subject(:hand) { Hand.new([deck.cards.values[0][0],deck.cards.values[0][1],deck.cards.values[1][0],deck.cards.values[1][1],deck.cards.values[0][9]]) }
            it 'should know it has two-pair' do
                expect(hand.rank).to be(:two_pair)
            end
        end

        describe "#straight?" do
            subject(:hand) { Hand.new([deck.cards.values[1][0],deck.cards.values[0][1],deck.cards.values[2][2],deck.cards.values[0][3],deck.cards.values[0][4]]) }
            it 'should know it has a straight' do
                expect(hand.rank).to be(:straight)
            end
        end

        describe "#flush?" do
            subject(:hand) { Hand.new([deck.cards.values[0][10],deck.cards.values[0][1],deck.cards.values[0][12],deck.cards.values[0][7],deck.cards.values[0][4]]) }
            it 'should know it has a flush' do
                expect(hand.rank).to be(:flush)
            end
        end

        describe "#straight_flush?" do
            subject(:hand) { Hand.new([deck.cards.values[0][0],deck.cards.values[0][1],deck.cards.values[0][2],deck.cards.values[0][3],deck.cards.values[0][4]]) }
            it 'should know it has a straight-flush' do
                expect(hand.rank).to be(:straight_flush)
            end
        end

        describe "#four_of_a_kind?" do
            subject(:hand) { Hand.new([deck.cards.values[0][10],deck.cards.values[1][10],deck.cards.values[2][10],deck.cards.values[3][10],deck.cards.values[0][4]]) }
            it 'should know it has four-of-a-kind' do
                expect(hand.rank).to be(:four_of_a_kind)
            end
        end

end

describe Player do
    let(:deck) do
        Deck.new
    end
    let(:player) do
        Player.new(100000, "player_sim", Hand.new([deck.cards.values[0][3],deck.cards.values[0][12],deck.cards.values[3][3],deck.cards.values[1][3],deck.cards.values[2][12]]))
    end
    

        it 'has a hand' do
            expect(player.hand.rank).to be(:full_house)
        end

        it 'has a chips' do
            expect(player.chips).to be(100000)
        end
end

describe Game do
    subject(:game) { Game.new(4) }

        it 'has a deck' do
            expect(game.deck.cards.values.flatten.count).to eq(52)
        end

        it 'knows how many players' do
            expect(game.players.count).to eq(4)
        end

        it 'knows how much is in the pot' do
            expect(game.pot).to eq(0)
        end

end