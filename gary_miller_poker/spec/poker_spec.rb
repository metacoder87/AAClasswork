require 'rspec'
require 'poker'

describe Card do
    let(:card) do
        Card.new
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