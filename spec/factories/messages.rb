FactoryGirl.define do
  factory :message do
    body "MyText"
  end

  factory :invalid_message, class: "Message" do
    body nil
  end
end
