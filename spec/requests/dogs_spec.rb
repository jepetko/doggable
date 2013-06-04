require 'spec_helper'

describe "Dogs Requests" do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in_as_a_valid_user @user

    @dogs = generate_dogs(@user,5)
  end

  describe "GET /dogs" do

    it "should be success" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dogs_path
      response.status.should be(200)
    end

    it "should return the correct count" do
      get dogs_path
      assert_have_selector ".simple-dog", :count => 5
    end
  end

  describe "GET /dogs/new" do
    it "should be success" do
      get dogs_path
      click_link 'Add your dog'
      response.should have_selector("input#dog_name")
      response.should have_selector("input#dog_birthday")

      response.should have_selector("a", :content => "Add skills" )
    end
  end

  describe "POST /dogs" do
    it "should be successful to create a new dog" do
      lambda {
        get "dogs/new"
        fill_in :dog_name, :with => "Bello"
        fill_in :dog_birthday, :with => "09.05.2007"
        choose :dog_sex_m
        click_button
        response.should have_selector("#flash_notice", :content => "created")
      }.should change(Dog, :count).by(1)
    end

    it "should be failure if the name is empty" do
      lambda {
        get "dogs/new"
        click_button
        response.should have_selector("#flash_error", :content => "created")
      }.should_not change(Dog,:count)
    end
  end

  describe "GET /dogs/N" do
    it "should not be successful because single dogs cannot be displayed" do
      get "dogs/#{@dogs.last.id}"
      response.should redirect_to(dogs_path)
    end
  end

  describe "GET /dogs/N/edit" do
    it "should be successful" do
      get "dogs/#{@dogs.last.id}/edit"
      response.should have_selector("input#dog_name", :value => "#{@dogs.last.name}")
    end
  end

  describe "PUT /dogs/N" do
    it "should be successful" do
      get "dogs/#{@dogs.last.id}/edit"
      fill_in :dog_name, :with => "My first dog"
      click_button
      response.should have_selector("#flash_notice", :content => "updated")

      get "dogs"
      response.should have_selector(".simple-dog", :content => "My first dog")
    end

    it "should be failure if the dog's name is empty" do
      get "dogs/#{@dogs.last.id}/edit"
      fill_in :dog_name, :with => ""
      click_button
      response.should have_selector(".alert-error", :content => "problems")
    end
  end

end
