FactoryGirl.define do
  factory :user do
    username 'hogelog'
    password User.create_password('hogelog', 'pass')
  end
end
