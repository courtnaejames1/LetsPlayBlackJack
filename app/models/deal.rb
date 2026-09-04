class Deal < ApplicationRecord
    ## Initializes relationships between tables
    belongs_to :game
    has_many :player_hand
    has_many :game_entry, through: :player_hand
    has_many :players, through: :game_entry
end
