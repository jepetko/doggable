module DogGenerateHelper

  def generate_dogs(user,count)
    count.times do |n|
      user.dogs.build( :name => "Dog-#{n}" )
      user.save!
    end
  end

  def associate_skills(dog,count)
    count.times do |n|
      skill = Skill.new(:name => "Skill-#{n}")
      dog.skills << skill
    end
    dog.save!
  end

end

RSpec.configure do |config|
  config.include DogGenerateHelper, :type => :request
end