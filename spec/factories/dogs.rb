# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dog do
    name "MyString"
    birthday "2012-12-08"
    sex "m"
  end
end
