require 'rails_helper'

describe "games/index", type: :view do
  let!(:game) {create :game}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign :games, Game.all
  end

  it "renders a list of games" do
    render

    assert_select 'tr>td', text: game.state.to_s, count: 1
    assert_select 'tr>td', text: game.created_at.to_s, count: 1
  end

end
