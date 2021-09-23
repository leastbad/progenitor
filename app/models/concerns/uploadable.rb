module Uploadable
  extend ActiveSupport::Concern

  included do
    kredis_set :_file_slots
    has_many :uploaded_files, as: :uploadable

    def file_slots
      _file_slots.members.map do |slot|
        UploadedFile.new.from_json(slot)
      end
    end

    def add_file_slot(**args)
      uploaded_file = UploadedFile.new(uuid: "U#{SecureRandom.urlsafe_base64}", **args)
      _file_slots << uploaded_file
      uploaded_file
    end

    def remove_file_slot(uuid:)
      slot = _file_slots.members.find { |temp| temp["uuid"] == uuid }
      _file_slots.remove(slot)
    end
  end
end
