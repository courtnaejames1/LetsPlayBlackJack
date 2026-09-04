class GamesController < ApplicationController
  ## before anything happens in the game
  ## create a deal
  before_action :create
  def index
    @game = Game.all()
    @stay_clicked = false
    @bust = false
    @dealers_card = @game.get_dealers_cards
    @players_card = @game.get_players_cards
  end

  ## creates the game
  # When the game is created a new dealer is made
  def create(dealer)
    @dealer = Dealer.new()
    @game = Game.new()

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: "Game was successfully created." }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @game.errors, status: :unprocessable_content }
      end
    end
  end

  ## Initializes the game
  def initialize_game
    puts "INIT GAME"
    @game.initialize_game
  end

  ## When a game is finished, the player has the ability
  # create another game
  # @return new cards for players and dealers
  def another
    @dealer = Dealer.new("Sasha", 50.00)
    @game.create(@dealer)
    @game.another
    @players_cards = @game.get_players_cards
    @dealers_cards = @game.get_dealers_cards

    [ @players_cards, @dealers_cards ]

  end

  ## deal the player a new card
  # and updates the players cards displayed
  # @returns the player cards
  def hit
    player = param[:player]
    @game.hit(player)
    @bust = @game.check_bust

    @players_cards = @game.get_players_cards

    @players_card
  end

  ## does not distribute the player with
  # a new card and the player loses their turn
  # returns the dealers cards
  def stay
    @game.stay
    @stay_clicked= true
    @score = @game.get_score
    @dealers_cards = @game.get_dealers_cards

    @dealers_cards
  end
end
