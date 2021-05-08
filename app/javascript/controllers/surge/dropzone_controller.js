import ApplicationController from '../application_controller'
import Dropzone from 'dropzone'
import { DirectUpload } from '@rails/activestorage'

export default class extends ApplicationController {
  static values = {
    url: String,
    clickable: Boolean,
    multiple: Boolean
  }

  connect () {
    super.connect()

    this.dropzone = new Dropzone(this.element, {
      url: this.urlValue,
      clickable: this.clickableValue,
      uploadMultiple: this.multipleValue,
      autoQueue: false,
      previewsContainer: false,
      dictDefaultMessage: 'Click or drop files here to upload',
      addedfile: this.processFile
    })
  }

  processFile = async file => {
    const insertResp = await this.stimulate('Upload#insert', this.element)
    const uuid = insertResp.payload.uuid
    const uploader = new Uploader(file, this.urlValue, uuid)

    uploader.process((error, blob) => {
      if (error) {
        console.error(error)
      } else {
        const form = document.querySelector(`#file-${uuid} form`)
        const hiddenTextField = form.querySelector('input.input')
        hiddenTextField.value = blob.filename

        const hiddenFileField = form.querySelector('input[type=file]')
        hiddenFileField.setAttribute('type', 'hidden')
        hiddenFileField.setAttribute('value', blob.signed_id)

        this.stimulate('Upload#submit', form, {
          serializeForm: true
        })
      }
    })
  }

  disconnect () {
    this.dropzone.destroy()
  }
}

class Uploader {
  constructor (file, url, uuid) {
    this.upload = new DirectUpload(file, url, this)
    this.uuid = uuid
  }

  process (callback) {
    this.upload.create(callback)
  }

  directUploadWillStoreFileWithXHR (request) {
    request.upload.addEventListener('progress', event => {
      this.directUploadDidProgress(event)
    })
  }

  directUploadDidProgress (event) {
    const factor = event.loaded / event.total
    const progressBar = document.querySelector(`#file-${this.uuid} .bar`)
    const percent = document.querySelector(`#file-${this.uuid} .percent`)
    const circumference = progressBar.getAttribute('stroke-dasharray')

    progressBar.setAttribute('stroke-dashoffset', circumference * (1 - factor))
    percent.textContent = `${Math.round(factor * 100)} %`
  }
}
