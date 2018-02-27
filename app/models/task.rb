class Task < ApplicationRecord
  validates :content, presence: true, length: { maximum: 11 }
  validates :Status, presence: true, length: { maximum: 11 }
end
