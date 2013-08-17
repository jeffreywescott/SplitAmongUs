require 'spec_helper'

describe ListsController do
  let(:user) { create(:user) }
  let(:list) { user.lists.create(:list) }
   
  before do
    sign_in(user)
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new list in the database" do
        expect {
          post :create, list: attributes_for(:list)
        }.to change(List, :count).by(1)
       end
      it "redirects to the dashboard page" do
        post :create, list: attributes_for(:list)
        response.should redirect_to dashboard_index_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new list in the database" do
        expect {
          post :create, list: attributes_for(:invalid_list)
          }.to_not change(List,:count)
      end
      it "renders the error message and redirects to the dashboard page" do
        post :create, list: attributes_for(:invalid_list)
        response.should redirect_to dashboard_index_path
      end
    end
  end 
end