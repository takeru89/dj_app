class Request < ApplicationRecord
  belongs_to :user

  validates :request, presence: true

  def self.wrequest
    to = Time.current
    from = (to - 6.day).at_beginning_of_day
    @requests = Request.where(created_at: from...to)
  end
end
