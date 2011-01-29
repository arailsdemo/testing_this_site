Factory.sequence :seq do |n|
  n
end

FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "#{n} Zombies!"}
    add_attribute(:sequence) { Factory.next(:seq) }
    status 'published'
  end
end
