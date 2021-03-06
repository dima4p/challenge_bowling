require 'rails_helper'

describe GamesController, type: :controller do
  before :each do
    allow(controller).to receive(:current_ability).and_return(current_ability)
  end

  # This should return the minimal set of attributes required to create a valid
  # Game. As you add validations to Game, be sure to
  # adjust the attributes here as well. The list could not be empty.
  let(:game) {create :game}

  let(:valid_attributes) { {} }

  let(:invalid_attributes) do
    # {state: ''}
    skip("Add a hash of attributes invalid for your model")
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # GamesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all games as @games" do
      game
      get :index, params: {}, session: valid_session
      expect(assigns(:games)).to be_kind_of(ActiveRecord::Relation)
      expect(assigns(:games)).to eq([game])
    end
  end

  describe "GET #show" do
    it "assigns the requested game as @game" do
      get :show,
          params: {id: game.to_param},
          session: valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "GET #new" do
    it "assigns a new game as @game" do
      get :new, params: {}, session: valid_session
      expect(assigns(:game)).to be_a_new(Game)
    end
  end

  describe "GET #edit" do
    it "assigns the requested game as @game" do
      get :edit, params: {id: game.to_param},
          session: valid_session
      expect(assigns(:game)).to eq(game)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect do
          post :create,
              params: {game: valid_attributes},
              session: valid_session
        end.to change(Game, :count).by(1)
      end

      it "assigns a newly created game as @game" do
        post :create,
            params: {game: valid_attributes},
            session: valid_session
        expect(assigns(:game)).to be_a(Game)
        expect(assigns(:game)).to be_persisted
      end

      it "redirects to the created game" do
        post :create,
            params: {game: valid_attributes},
            session: valid_session
        expect(response).to redirect_to(Game.last)
        # expect(response).to redirect_to(games_url)
      end
    end   # with valid params

    # context "with invalid params" do
    #   it "assigns a newly created but unsaved game as @game" do
    #     # allow_any_instance_of(Game).to receive(:save).and_return(false)
    #     post :create,
    #         params: {game: invalid_attributes},
    #         session: valid_session
    #     expect(assigns(:game)).to be_a_new(Game)
    #   end
    #
    #   it "re-renders the 'new' template" do
    #     # allow_any_instance_of(Game).to receive(:save).and_return(false)
    #     post :create,
    #         params: {game: invalid_attributes},
    #         session: valid_session
    #     expect(response).to render_template("new")
    #   end
    # end   # with invalid params
  end   # POST #create

  describe "PUT #update" do
    before :each do
      allow(Game).to receive(:find).and_return game
    end

    it 'looks for the Game' do
      expect(Game).to receive(:find).with('1').and_return game
      put :update, params: {id: game.id, game: {cancel: '1'}},
          session: valid_session
    end

    it 'sends :update! to the found game' do
      expect_any_instance_of(Game).to receive(:cancel!)
      put :update, params: {id: game.id, game: {cancel: '1'}},
          session: valid_session
    end

    it 'returns :ok' do
      put :update, params: {id: game.id, game: {cancel: '1'}},
          session: valid_session
      expect(response).to have_http_status :found
    end
  end   # PUT #update

  describe "POST #score" do
    before :each do
      allow(Game).to receive(:current).and_return game
    end

    it 'looks for current Game' do
      expect(Game).to receive(:current).and_return nil
      post :score, params: {pins: '5', xhr: true},
          session: valid_session
    end

    context 'when not found current Game' do
      it 'returns :bad_request' do
        expect(Game).to receive(:current).and_return nil
        post :score, params: {pins: '5', xhr: true},
            session: valid_session
        expect(response).to have_http_status :bad_request
      end
    end   # when not found current Game

    context 'when found current Game' do
      it 'sends :score! to the found game' do
        expect_any_instance_of(Game).to receive(:score!).with('5')
        post :score, params: {pins: '5', xhr: true},
            session: valid_session
      end

      it 'returns :ok' do
        post :score, params: {pins: '5', xhr: true},
            session: valid_session
        expect(response).to have_http_status :ok
      end
    end   # when found current Game
  end   # POST #score

  describe "DELETE #destroy" do
    it "destroys the requested game" do
      game
      expect do
        delete :destroy,
            params: {id: game.to_param},
            session: valid_session
      end.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      game
      delete :destroy,
          params: {id: game.to_param},
          session: valid_session
      expect(response).to redirect_to(games_url)
    end
  end   # DELETE #destroy

end
