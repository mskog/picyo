FactoryGirl.define do
  factory :album do
    name 'album'

    trait :with_images do
      after :create do |instance|
        create_list :image, 2, albums: [instance]
      end
    end
  end
end
