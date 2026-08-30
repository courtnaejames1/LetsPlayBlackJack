class Player < ApplicationRecord
    has_many :game_entry
    has_many :games through :game_entry
end
