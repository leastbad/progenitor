class UploadedFile < ApplicationRecord
  belongs_to :uploadable, polymorphic: true, touch: true
  attribute :uuid, :string
  attribute :input, :string
  has_one_attached :blob
end
