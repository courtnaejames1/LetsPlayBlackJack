class GameEntry < ApplicationRecord
    ## initializes relationships with models
    belongs_to :player
    belongs_to :game
    has_many :player_hand
    has_many :deal,  through: :player_hand


end
