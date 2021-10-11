class UploadReflex < ApplicationReflex
  def insert
    uploaded_file = current_user.add_file_slot
    self.payload = uploaded_file.as_json
    html = render(
      partial: "uploaded_files/uploaded_file",
      locals: {
        uploaded_file: uploaded_file
      }
    )
    cable_ready[UsersChannel].append(
      selector: "#uploads",
      html: html
    ).broadcast_to(current_user)
    morph :nothing
  end

  def submit
    # ActiveStorage::Blob.create_and_upload!(io: file, filename: filename).tap do |blob|
    #   ActiveStorage::Attachment.create!(record: record, name: name, blob: blob)
    # end

    uploaded_file = nil
    until uploaded_file do
      begin
        uploaded_file = current_user.uploaded_files.create(uploaded_file_params)
      rescue NoMethodError
      end
    end

    uuid = uploaded_file.uuid

    cable_ready[UsersChannel].morph(selector: "#file-#{uuid}", html: render(
      partial: "uploaded_files/uploaded_file",
      locals: {
        uploaded_file: uploaded_file
      }
    )).broadcast_to(current_user)

    current_user.remove_file_slot(uuid: uuid)

    morph :nothing
  end

  def remove
    file = current_user.uploaded_files.find(element.dataset["id"])
    file&.destroy
    cable_ready[UsersChannel].remove(selector: "#file-#{file.id}").broadcast_to(current_user)
    morph :nothing
  end

  private

  def uploaded_file_params
    params.require(:uploaded_file).permit(:input, :uuid, :blob)
  end
end
