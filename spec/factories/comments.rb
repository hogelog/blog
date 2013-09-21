FactoryGirl.define do
  factory :comment do
    article
    text 'Comment!'
  end
end
