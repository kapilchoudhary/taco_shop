FactoryGirl.define do
  factory :taco do
    meat { ["chicken", "steak" ].sample }
    rice { Faker::Boolean.boolean }
    salsa { Faker::Boolean.boolean }
    notes { Faker::Lorem.sentence }

    trait :chicken do
      meat {'chicken'}
    end

    trait :steak do
      meat {'steak'}
    end

    trait :invalid do
      meat {'invalid'}
    end

    trait :nil_meat do
      meat {nil}
    end

    trait :update_notes do
      notes { 'Update Notes' }
    end

  end
end