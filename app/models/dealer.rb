class Dealer < ApplicationRecord
    ## Initializes relationships between tables
    has_many :games
end
