require 'spec_helper'

describe "Dogs Requests" do

  before :each do
    @user = FactoryGirl.create(:user)
    sign_in_as_a_valid_user @user

    generate_dogs(@user,5)
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
      response.should have_selector("select#dog_birthday_1i")
      response.should have_selector("select#dog_birthday_2i")
      response.should have_selector("select#dog_birthday_3i")

      response.should have_selector("a", :content => "Add skills" )
    end
  end

  describe "POST /dogs" do
    it "should be successful to create a new dog" do
      lambda {
        get "dogs/new"
        fill_in :dog_name, :with => "Bello"
        fill_in :dog_birthday_1i, :with => 2007
        fill_in :dog_birthday_2i, :with => 05
        fill_in :dog_birthday_3i, :with => 9
        click_button
        response.should have_selector("#flash_notice", :content => "created")
      }.should change(Dog, :count).by(1)
    end
  end

end
