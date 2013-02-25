module DogGenerateHelper

  def generate_dogs(user,count)
    count.times do |n|
      user.dogs.build( :name => "Dog-#{n}" )
      user.save!
    end
  end

end

RSpec.configure do |config|
  config.include DogGenerateHelper, :type => :request
end