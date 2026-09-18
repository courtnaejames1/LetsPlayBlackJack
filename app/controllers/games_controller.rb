class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy hit stay ]


  # GET /games or /games.json
  def index
    @games = Game.all

  end

  def destroy
  end

  def update
  end

  # GET /games/1 or /games/1.json
  # Change to play logic
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games or /games.json
  def create
    @game = Game.start_game(name: game_params[:name], starting_bet: game_params[:starting_bet])

    if @game.save
      redirect_to action: "show", id: @game.id
    else
      render :new, status: :unprocessable_entity
    end
  end

  # POST /games/:id/stay
  def stay
    @game.stay
    render_hands
  end

  ## POST /games/:player
  def hit
    @game.hit(params[:player])
    render_hands
  end

 private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def game_params
      params.expect(game: [ :name, :starting_bet, :player] )
    end

    ## Holds the local variables to be past to the turbo stream
    def hand_locals
      {
        game: @game,
        user_hands: @game.user_hands,
        dealers_hands: @game.dealers_hands,
        users_score: @game.get_score(cards: @game.user_hands),
        dealers_score: @game.get_score(cards: @game.dealers_hands),
        games_over: @game.game_over?,
        status: @game.status
      }
    end

  ## Renders the turbo stream for the player/dealers hand
    def render_hands
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              "users_hands",
              partial: "games/users_hand",
              locals:  hand_locals
            ),
            turbo_stream.replace(
              "dealers_hands",
              partial: "games/dealers_hand",
              # Why are the scores returning nil
              locals: hand_locals
            )
          ]
        end
      end
    end

end
