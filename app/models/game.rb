class Game < ApplicationRecord

  validates :name, presence: true
  validates :starting_bet, numericality: { greater_than: 0 }

  # Constants
  VALUES = %w[2 3 4 5 6 7 8 9 10 K Q J A]
  SUITS = %w[H D S C]
  BLACKJACK = 21
  DEALER_STAYS = 17


  # Initialize the game
  def self.start_game(name:, starting_bet:, decks: 8)
    full_deck = self.init_game
    user_cards = [ full_deck.pop, full_deck.pop ]
    dealers_cards = [ full_deck.pop, full_deck.pop ]

    create(
      name: name,
      starting_bet: starting_bet,
      decks: decks,
      hands: 1,
      deck: full_deck,
      user_hands: user_cards,
      dealers_hands: dealers_cards,
      status: "in_progress"
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

  ## Determines if the game is still being played
  def in_progress?
    status == "in_progress"
  end

  ## Determines if the game is over
  # Used to determine if scores should be shown
  def game_over?
    !in_progress?
  end

  ## Distributes another card to the dealer/player
  def hit(player)
    return self unless in_progress?

    remaining = deck.dup
    new_card = remaining.pop

      if player == "dealer"
        new_cards = dealers_hands + [ new_card ]
        update(dealers_hands: new_cards, deck: remaining)
         if get_score(cards: new_cards)  > BLACKJACK
           update(status: "dealers_bust")
         end
      else
        new_cards = user_hands +  [ new_card ]
        update(user_hands: new_cards, deck: remaining)
         if get_score(cards: new_cards) > BLACKJACK
           update(status: "player_bust")
         end
      end

  end

  ## Allows the player to performs the game
  # logic of stay and distribute more cards to the dealer
  def stay
    return unless in_progress?

    while in_progress? && get_score(cards: dealers_hands) < DEALER_STAYS
      hit("dealer")
    end

    determine_winner if in_progress?
    self
  end

  ## Calculates the score of the player
  def get_score(cards:)
    @score = 0
    cards.each do  |card|
      value = card.split(/-/).first
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
    @score
  end

  ## Determines the winner and updates the status of the game
  def determine_winner
    dealers_score = get_score(cards: dealers_hands)
    users_score = get_score(cards: user_hands)

    case
    when dealers_score > BLACKJACK
      new_status = "dealer_bust"
    when users_score > BLACKJACK
      new_status = "player_bust"
    when  users_score == dealers_score
      new_status = "push"
    when users_score > dealers_score
      new_status = "player_win"
    else
      new_status = "dealers_win"
    end

    update(status: new_status)
  end
end
