class Request < ApplicationRecord
  belongs_to :user

  validates :request_word, presence: true, length: { maximum: 50 }

  def self.wrequest
    to = Time.current
    from = (to - 6.day).at_beginning_of_day
    @requests = Request.where(created_at: from...to)
  end
end
