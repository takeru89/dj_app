FactoryBot.define do
  factory :word do
    kana          { 'りんご' }
    kanji         { '林檎' }
    english       { 'apple' }
    word_class_id { 2 }
    explanation   { 'りんごを5個食べました。' }
  end
end
