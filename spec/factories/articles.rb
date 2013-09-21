FactoryGirl.define do
  factory :article, class: Article do
    user
    title "hoge title"
    text "hogehoge fugafuga"
  end
end
