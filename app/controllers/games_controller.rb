# == Schema Information
#
# Table name: games
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  state      :string
#  updated_at :datetime         not null
#

# This is the main controller to process model Game
#
class GamesController < ApplicationController

  protect_from_forgery except: :score

  load_resource except: [:score]
  before_action :find_current, only: [:score]
  authorize_resource

  layout false, only: :score

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

  # POST /score/1
  def score
    return unless @game
    @game.score! params[:pins]
    head :ok
  end

  # PATCH/PUT /games/1
  def update
    @game.cancel!
    respond_to do |format|
      format.html { redirect_to games_path, notice: t('games.was_updated') }
      format.json { render :show, status: :ok, location: @game }
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

  def find_current
    @game = Game.current
    head :bad_request unless @game
    @game
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    # The list to be filled later when Game starts taking more information
    if params[:action] == 'create'
      {}
    else
      list = [ ]
      list << :cancel if can? :cancel, @game
      params.require(:game).permit(*list)
    end
  end
end
