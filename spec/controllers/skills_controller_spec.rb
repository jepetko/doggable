require 'spec_helper'

describe SkillsController do

  render_views

  before(:each) do
    @user = FactoryGirl.create(:user)
    @dog = FactoryGirl.build(:dog, :user => @user)
    @dog.save!
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should have_selector("input", :id => "skill_name")
      response.should have_selector("input", :id => "skill_picture")
    end
  end

  describe "POST 'create'" do
    before(:each) do

      file = File.open("/tmp/temp.jpg","a+")
      file.close
      picture = ActionDispatch::Http::UploadedFile.new( :content_type => "image/jpg",
                                                        :original_filename => "original.jpg",
                                                        :tempfile => file )

      @valid_attr = {:name => 'barking', :picture => nil}   #TODO: uploads are tested in requests
      @invalid_attr = {:name => nil}
    end

    it "should be failure" do
      lambda {
        post :create, :skill => @invalid_attr
        response.should render_template('new')
      }.should_not change(Skill, :count)
    end

    it "should be successful" do
      lambda {
        post :create, :skill => @valid_attr
        flash[:notice].should =~ /created/
      }.should change(Skill, :count).by(1)
    end

  end

end
