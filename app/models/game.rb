class Game < ApplicationRecord

  validates :name, presence: true
  validates :starting_bet, numericality: { greater_than: 0 }

  # Constants
  VALUES = %w[2 3 4 5 6 7 8 9 10 K Q J A]
  SUITS = %w[H D S C]


  # Initialize the game
  def self.start_game(name:, starting_bet:, decks: 8)
    full_deck = self.init_game
    user_cards = [ full_deck.pop, full_deck.pop ]
    dealers_cards = [ full_deck.pop, full_deck.pop ]
    puts "here is the deck#{full_deck}"
    @stay_clicked = false
    @bust = false

    create(
      name: name,
      starting_bet: starting_bet,
      decks: decks,
      hands: 1,
      deck: full_deck,
      user_hands: user_cards,
      dealers_hands: dealers_cards,
      win_or_lose: false
    )
  end

  ## Shuffle the cards to be displayed
  def self.init_game
    deck = []
    SUITS.each { |i|
      VALUES.each { |j|
        deck << "#{j}-#{i}"
      }
    }
    deck.shuffle
  end

  def hit(player)
    remaining = deck
    unless @bust
      if player == "dealer"
        new_cards = dealers_hands + [ remaining.pop ]
        Game.update(dealers_hands: new_cards, deck: remaining)
      else
        new_cards = user_hands +  [ remaining.pop ]
        Game.update(user_hands: new_cards, deck: remaining)
        get_score(player: "user", cards: new_cards)
      end
    end
  end

  def stay
    @stay_clicked = true

    @dealers_score = get_score(cards: dealers_hands)
    if @dealers_score > 21
      unless @bust
        @users_score = get_score(player: "user", cards: user_hands)
        #determine_winner(dealers_score: @dealers_score, users_score: @users_score)
      end
    elsif @dealers_score < 17
      @bust = false
      hit("dealer")
      puts "dealers score is less than 17"
      stay
    else
      unless @bust
        get_score(player: "user", cards: user_hands)
      end
    end
  end

  def get_score(player: nil, cards:)
    @score = 0
    cards.each do  |card|
      value = card.split(/-/)[0]
      if value == "K" || value == "Q" || value == "J"
        @score +=10
      elsif value == "A"
        if @score < 11
          @score += 11
        else
          @score += 1
        end
      else
        @score += value.to_i

      end
    end
    if player == "user" && @score > 21
        @bust = true
    end
    @score
  end

  def show_deck
    @deck
  end

  def check_bust
    @bust
  end

  def get_users_cards
    @users_cards
  end

  def get_dealers_cards
    @dealers_cards
  end

  def determine_winner(dealers_score:, users_score: )

    if dealers_score > 21

    end

  end




end
