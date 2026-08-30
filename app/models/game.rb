class Game < ApplicationRecord
    belongs_to :dealer
    
    has_many :game_entry

    has_many :player, through: :game_entries
    has_many :hands, through: :deals
end
