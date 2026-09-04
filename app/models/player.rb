class Player < ApplicationRecord
    ## Initialize connections between the games and the player
    has_many :game_entry
    has_many :games, through: :game_entry
end
