require 'rails_helper'

RSpec.describe "Games", type: :request do
  describe "GET /games" do
    it "starts a Game and monitors it obtaining the score" do
      visit games_path
      click_on 'Start a new game'
      click_on 'Start game'
      expect(page).to have_css('.game_score', text: '0')
      sleep 2.5.seconds
    end

    it "for all strikes scores the game to 300" do
      visit games_path
      click_on 'Start a new game'
      click_on 'Start game'
      12.times {post score_path(10), xhr: true}
      expect(page).to have_selector('body.games.show')
      visit page.current_path
      expect(page).to have_css('.game_score', text: '300')
    end
  end
end
