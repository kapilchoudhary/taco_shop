FactoryGirl.define do
  factory :taco do
    meat { ["chicken", "steak","other_meat" ].sample }
    rice { Faker::Boolean.boolean }
    salsa { Faker::Boolean.boolean }
    other_side { Faker::Boolean.boolean }
    notes { Faker::Lorem.sentence }


    trait :other_meat do
      meat {'other_meat'}
    end

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