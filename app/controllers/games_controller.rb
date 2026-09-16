class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy hit stay ]


  # GET /games or /games.json
  def index
    @games = Game.all
    @bust = false

  end

  def destroy

  end
  def update

  end
  # GET /games/1 or /games/1.json
  # Change to play logic
  def show
    @game  = Game.find(params[:id])
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

  def stay
    @game.stay
    @game.reload
    @stay_clicked = true
    @dealers_score = @game.get_score(cards: @game.dealers_hands)
    @users_score = @game.get_score(player: "user", cards: @game.user_hands)

    @scores = [ @dealers_score, @users_score ]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "users_cards",
            partial: "games/users_hand",
            locals: { users_hand: @game.user_hands, bust: @bust, stay_clicked: @stay_clicked }
          ),
          turbo_stream.replace(
            "dealers_cards",
            partial: "games/dealers_hand",
            locals: { dealers_hand: @game.dealers_hands, stay_clicked: @stay_clicked, score: @scores }
          )
        ]
      end
    end


  end

  def hit
    @game.hit(params[:player])
    @game.reload
    @bust = @game.check_bust
    @stay_clicked = false
    if @bust
      @stay_clicked = true
    end

    @dealers_score = @game.get_score(cards: @game.dealers_hands)
    @users_score = @game.get_score(player: "user", cards: @game.user_hands)

    @scores = [ @dealers_score, @users_score ]

    # TODO: make a private method does this so it isn't repetitive
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace(
            "users_cards",
            partial: "games/users_hand",
            locals: { users_cards: @game.user_hands, bust: @bust, stay_clicked: @stay_clicked }
          ),
          turbo_stream.replace(
            "dealers_cards",
            partial: "games/dealers_hand",
            # Why are the scores returning nil
            locals: { dealers_cards: @game.dealers_hands, stay_clicked: @stay_clicked, score: [ @dealers_score, @users_score ] }
          )
        ]
      end
    end
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

end
