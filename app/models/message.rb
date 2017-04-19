class Message < ApplicationRecord
	belongs_to :user
  validates :body, presence: true
  mount_uploader :picture, PictureUploader
end
