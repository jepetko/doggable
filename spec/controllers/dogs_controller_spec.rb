require 'spec_helper'

describe DogsController do

  render_views

  before (:each) do
    ##### create a user and sign-in!
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "DateComponentsHelper" do
    it "should explode the date" do
      d = Date.new(2000)
      m = { :the_number => 1, :the_string => "B", :the_date => d }
      explode_date_comp(m)
      m.should have_key("the_date(1i)".to_sym)
      m.should have_key("the_date(2i)".to_sym)
      m.should have_key("the_date(3i)".to_sym)
    end

  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
      response.should have_selector("input", :id => "dog_name")
      response.should have_selector('select[@id="dog_birthday_1i"]/option')
      response.should have_selector('select[@id="dog_birthday_2i"]/option')
      response.should have_selector('select[@id="dog_birthday_3i"]/option')
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @valid_attr = { :name => "Aron", :birthday => Date.new(2006,03,01) }
      explode_date_comp(@valid_attr)

      @invalid_attr = { :name => "" }
    end

    it "should be failure" do
      lambda {
        post :create, :dog => @invalid_attr
        response.should render_template('new')
      }.should_not change(Dog, :count)
    end

    it "should be successful" do
      lambda {
        post :create, :dog => @valid_attr
        flash[:notice].should =~ /created/
      }.should change(Dog, :count).by(1)
    end
  end

  describe "actions for which an existing dog is necessary" do

    before(:each) do
      ##### create a dog for this user!
      @dog = FactoryGirl.build(:dog, user: @user, name: "LaraMausi", birthday: "2010-01-02")
      @dog.save!

      @valid_attr = { :name => "PuppiMausi", :birthday => Date.new(2001) }
      @invalid_attr = { :name => "" }

    end

    describe "GET 'index'" do
      it "should be successful" do
        get :index
        response.should be_success
        response.should have_selector("table", :content => @dog.name )
      end
    end

    describe "GET 'edit'"  do
      it "should be successful" do
        get :edit, :id => @dog
        response.should be_success
        response.should have_selector("input", :id => "dog_name", :value => @dog.name)
        response.should have_selector('select[@id="dog_birthday_1i"]/option', :value => "#{@dog.birthday.year}")
        response.should have_selector('select[@id="dog_birthday_2i"]/option', :value => "#{@dog.birthday.month}")  #January
        response.should have_selector('select[@id="dog_birthday_3i"]/option', :value => "#{@dog.birthday.day}")
      end
    end

    describe "PUT 'update'" do
      it "should be failure" do
        put :update, :id => @dog, :dog => @invalid_attr
        response.should render_template('edit')
      end

      it "should be successful" do
        put :update, :id => @dog, :dog => @valid_attr
        flash[:notice].should =~ /updated/
        response.should redirect_to("/dogs")
        get :index
        response.should have_selector("table", :content => @valid_attr[:name])
      end
    end

    describe "DELETE 'destroy'" do
      it "should be failure" do
        expect {
          delete :destroy, :id => 10000000
        }.to raise_error ActiveRecord::RecordNotFound
      end

      it "should be success" do
        lambda {
          delete :destroy, :id => @dog
          flash[:notice].should =~ /destroyed/
        }.should change(Dog, :count).by(-1)
      end
    end
  end
end
