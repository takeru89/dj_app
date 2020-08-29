class Request < ApplicationRecord
  belongs_to :user

  validates :request, presence: true
end
