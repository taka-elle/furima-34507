FactoryBot.define do
  factory :user do
    nickname              { 'Test' }
    email                 { Faker::Internet.free_email }
    password              { 'test111' }
    password_confirmation { password }
    last_name             { '田中' }
    first_name            { '太郎' }
    last_name_f           { 'タナカ' }
    first_name_f          { 'タロウ' }
    birthday              { '1997-01-19' }
  end
end
