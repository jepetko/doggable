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

          click_button "Sign up"
          #TODO: which template is rendered
          response.should render_template('users/new')
          response.should have_selector('div#error')
        end.should_not change(User, :count)
      end
    end
  end
end
