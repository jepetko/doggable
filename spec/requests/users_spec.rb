require 'spec_helper'

describe "Users Requests" do

  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit '/users/sign_up'

          fill_in "user_name", :with => ""
          fill_in "user_email", :with => ""
          fill_in "user_password", :with => ""
          fill_in "user_password_confirmation", :with => ""

          click_button
          response.should render_template('devise/registrations/new')
          response.should have_selector('div.alert-error')
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should create a new user" do
        lambda do
          visit '/users/sign_up'

          fill_in "user_name", :with => "superuser"
          fill_in "user_email", :with => "superuser@country.org"
          fill_in "user_password", :with => "superuser"
          fill_in "user_password_confirmation", :with => "superuser"
          click_button

          response.should render_template('home/index')
          response.should have_selector('#flash_notice') do |div|
            div.should contain("Welcome!")
          end
        end.should change(User,:count).by(1)
      end
    end
  end

  describe "sign in / sign out" do
    it "should deny signing in with blank fields" do
      visit 'users/sign_in'
      fill_in "user_email", :with =>  ""
      fill_in "user_password", :with => ""
      click_button

      response.should_not render_template('home/index')
      response.should have_selector('#flash_alert') do |div|
        div.should contain('Invalid')
      end
    end

    it "should be successful when credentials are valid" do
      visit 'users/sign_in'
      usr = FactoryGirl.create(:user)
      fill_in "user_email", :with => usr.email
      fill_in "user_password", :with => usr.password
      click_button

      response.should render_template('devise/sessions/new')
      response.should render_template('home/index')
      response.should have_selector('#flash_notice') do |div|
        div.should contain('successfully')
      end

      #avoid trial to sign_up twice when the user is already signed-in
      get 'users/sign_up'
      response.should redirect_to(root_path)
    end
  end
end
