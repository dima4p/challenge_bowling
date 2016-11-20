require 'rails_helper'

describe "games/new", type: :view do
  let(:game) {build :game}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign(:game, game)
  end

  it "renders new game form" do
    render

    assert_select "form[action='#{games_path}'][method='post']" do
      assert_select 'input#game_state[name=?]', 'game[state]', count: 0
    end
  end
end
