require 'rails_helper'

describe "games/show.json.jbuilder", type: :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
    @game = assign(:game, create(:game))
    render
  end

  attributes = %w[
    id
    state
    created_at
    updated_at
    url
  ]

  it "renders the following attributes of game: #{attributes.join(', ')} as json" do
    hash = MultiJson.load rendered
    expect(hash.keys.sort).to eq attributes.sort
    expected = @game.attributes.slice *attributes
    expected = MultiJson.load MultiJson.dump expected
    expected['url'] = game_url(@game, format: 'json')
    expect(hash).to eq expected
  end
end
