require 'rails_helper'

describe "games/show", type: :view do
  let(:game) {create :game}

  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    assign :game, game
    game.score! 6
  end

  it "renders attributes in dl>dd" do
    render
    assert_select 'dl>dd', text: Regexp.new(game.score.to_s)
    assert_select 'dl>dd', text: Regexp.new(game.state.to_s)
    assert_select 'dl>dd', text: Regexp.new(game.created_at.to_s)
  end
end
