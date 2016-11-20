require 'rails_helper'

describe "games/index.json.jbuilder", type: :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    @game = create(:game)
    assign :games, [@game, @game]
    render
  end

  attributes = %w[
    id
    state
    created_at
    updated_at
    url
  ]

  it "renders a list of games as json with following attributes: #{attributes.join(', ')}" do
    hash = MultiJson.load rendered
    expect(hash.first).to eq(hash = hash.last)
    expect(hash.keys.sort).to eq attributes.sort
    expected = @game.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = game_url(@game, format: 'json')
    expect(hash).to eq expected
  end
end
