FactoryBot.define do
  factory :management_address do
      add_num               { '000-0000' }
      area_id               { Faker::Number.between(from: 2, to: 48) }
      city                  { 'test111' }
      add_line              { '000-0' }
      add_build             { 'test' }
      tel_num               { '00000000000' }
  end
end
