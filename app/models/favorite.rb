class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :word

  with_options presence: true do
    validates :user_id
    validates :word_id, uniqueness: { scope: :user_id }
  end
end
