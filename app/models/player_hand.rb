class PlayerHand < ApplicationRecord
    ## Initializes relations
    belongs_to :deal
    belongs_to :game_entry
end
