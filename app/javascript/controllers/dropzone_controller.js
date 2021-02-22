import { Controller } from 'stimulus'
import Dropzone from 'dropzone'

export default class extends Controller {
  static values = { url: String }
  connect () {
    this.dropzone = new Dropzone(this.element, { url: this.urlValue })
  }

  disconnect () {
    this.dropzone.destroy()
  }
}
