require 'rails_helper'

RSpec.describe GamesController, type: :controller do 
  describe "games#indxex action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end  
end