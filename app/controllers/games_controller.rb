# This is the main controller to process model Game
#
class GamesController < ApplicationController

  load_and_authorize_resource except: :update

  # GET /games
  def index
    @games = @games.ordered
  end

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
  end

  # POST /games
  def create
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: t('games.was_created') }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: t('games.was_updated') }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: t('games.was_deleted') }
      format.js   { }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  # def set_game
  #   @game = Game.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    # The list to be filled later when Game starts taking more information
    # list = [
    # ]
    # params.require(:game).permit(*list)
    {}
  end
end
