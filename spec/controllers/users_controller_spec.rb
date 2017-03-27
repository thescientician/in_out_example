require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }

  shared_examples_for "protected action" do |action, args = {}|

    it "should exist" do
      controller.should respond_to(action)
    end

    context "not logged in" do
      it "should boot back to login page" do
        get action, args
        unless args[:format] == :json
          expect(response).to redirect_to(new_user_session_path)
        else
          expect(response.code).to eq("401")
        end
      end
    end

    context "if logged in" do
      before(:each) do
        sign_in user  
      end

      it "should be ok" do
        get action, args
        response.should be_ok
      end
    end
  end


  describe "GET index" do

    it_should_behave_like "protected action", :index

    context "user is logged in" do
      before(:each) do
        sign_in user  
      end
      
      before { get :index }

      it "should render the index template" do
        expect(response).to render_template("index")
      end

      it "should populate the @users var" do
        assigns(:users).should_not be_nil
        assigns(:users).should be_empty
      end

      it "should assign the @teams var" do
        assigns(:teams).should_not be_nil
        assigns(:teams).should be_empty
      end

      it "should pull out all users that are not the current user" do
        assigns(:users).should have(0).users
        FactoryGirl.create(:user)
        get :index
        assigns(:users).should have(1).users
      end
    end
  end


  describe "GET status" do
    it_should_behave_like "protected action", :status, id:1, format: :json

    context "user is logged in" do
      before(:each) do
        sign_in user
      end
      it "respond with empty if user is not found" do
        expect {
          get :status, id:99
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "should respond to :json" do
        get :status, id:1, format: :json
        response.should be_ok
      end

      it "should render the id and fullname and status fields" do
        get :status, id:1, format: :json
        body = JSON.parse(response.body)
        body.should include("full_name")
        body.should include("id")
        body.should include("status")
      end

    end
  end

  describe "get show" do
    it_should_behave_like "protected action", :show, id:1


    context "logged in" do
      before(:each) do
        sign_in user
      end

      it "shoudl populate the user var" do
        get :show, id:1
        assigns(:user).should_not be_nil
      end

      it "should render the edit template" do
        get :show, id:1
        expect(response).to render_template(:show)
      end
    end
  end

  describe "get edit" do
    it_should_behave_like "protected action", :edit, id:1

    context "logged in" do
      before(:each) do
        sign_in user
      end

      it "shoudl populate the user var" do
        get :edit, id:1
        assigns(:user).should_not be_nil
      end

      it "should render the edit template" do
        get :edit, id:1
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "post update" do
     it "should exist" do
      controller.should respond_to(:update)
    end

    context "not logged in" do
      it "should boot back to login page" do
        post :update, id:1
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "logged in" do
      before(:each) do
        sign_in user
      end

      it "should update user atrributes" do
        post :update, id:1, user:{first_name:name = Faker::Name.first_name}
        assigns(:user).should be_persisted
        assigns(:user).first_name.should eq(name)
      end

      it "should redirect to users_path" do
        post :update, id:1, user:{first_name:Faker::Name.first_name}
        response.should redirect_to(users_path)
      end
    end
  end
  
end
