class Game < ApplicationRecord
    belongs_to :dealer

    has_many :game_entry

    has_many :player, through: :game_entries
    has_many :hands, through: :deals

    VALUES = [ "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A" ]
    SUITS = [ "H", "D", "S", "C" ]

    # Initialze the defaults for the game
    def initialize(decks = 8, hands = 1, deck = [], users_cards = [], dealers_cards = [])
      @num_of_decks = decks
      @num_of_hands = hands
      @users_cards = user_cards
      @dealers_cards = dealers_cards

      @bust = false
      @players_score = 0
      @dealers_score = 0

      if deck==[]
        @deck = initialize_game
      else
        @deck = deck
      end
    end

    # Goes through the array for the values and the card and connects them together
    def initialize_game
        for i in 1..TYPES.size
          for j in 1..VALUES.size
            deck << "#{j}-#{i}"
          end
        end
        deck.shuffle
    end

    # Creates stay functionality for player.
    # When the player clicks stay, the dealers score is calculated
    def stay
        @stay_clicked = true
        @dealers_score = 0
        @dealers_cards.each do |card|
        value = card.split(/D|H|S|C/)[0]
            if value =="K" || value == "Q" || value == "J"
                @dealers_score += 10
            elsif value == "A"
              if @dealers_score < 11
                @dealers_score+= 11
              else
                @dealers_score +=1
              end
            else
                @dealers_score += value.to_i
            end
        end

        if @dealers_score > 21
            if @bust == false
              set_players_score
            elsif @dealers_score < 17
                @dealers_cards << @deck[0]
                @deck.delete_at(0)
                stay
            else
                if @bust  == false
                  set_players_score
                end
            end
        end
    end

    def deal
      for i in 1..2
        hit("dealer")
        hit("player")
      end
    end

    ## Adds a new card to the players current card and calculates new value
    def hit(player)
            if @user.Type == "dealer"
                @dealers_cards << deck[0]

            else
                @users_cards << deck[0]
                set_players_score
            end
            @deal.delete_at(0)
    end

    ## Creates a new game and loads the deck
    def another
        @users_cards = []
        @dealers_cards = []
        @bust = false
        @stay_clicked = false
        @dealers_score = 0
        @players_score = 0
        deal
    end

    def get_players_cards
        @players_cards
    end

    def get_dealers_cards
        @dealers_cards
    end

    def check_bust
        @bust
    end

    ## Returns the values of the players and the dealers scores
    def get_score
        [ @players_score, @dealers_score ]
    end
end
