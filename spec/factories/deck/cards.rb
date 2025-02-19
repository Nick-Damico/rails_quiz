FactoryBot.define do
  factory :card, class: 'Decks::Card' do
    deck { create(:deck) }
    front { "#{Faker::Lorem.sentence}?" }
    back { Faker::DcComics.hero }
  end
end
