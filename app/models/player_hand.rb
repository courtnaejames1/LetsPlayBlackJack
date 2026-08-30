class PlayerHand < ApplicationRecord
    belongs_to :deal
    belongs_to :game_entry
end
