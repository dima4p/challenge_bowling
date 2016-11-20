require 'rails_helper'

describe "games/edit", type: :view do
  let(:game) {create :game}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign(:game, game)
  end

  it "renders the edit game form" do
    render

    assert_select "form[action='#{game_path(game)}'][method='post']" do
      assert_select 'input#game_state[name=?]', 'game[state]', count: 0
    end
  end
end
