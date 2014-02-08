class Transaction < ActiveRecord::Base
  scope :by_time, ->(enter_time, close_time){where('time >= ? AND time < ?', enter_time, close_time)}
end
