FactoryGirl.define do
  factory :image do
    after :build do |image|
      image.file = File.new('spec/fixtures/doll.jpg')
    end
  end
end
