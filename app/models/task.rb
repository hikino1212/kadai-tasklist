class Task < ApplicationRecord
  validates :content, presence: true, length: { maximum: 11 }
  validates :status, presence: true, length: { maximum: 11 }
end
