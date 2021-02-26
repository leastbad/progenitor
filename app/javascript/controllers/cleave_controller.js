import { Controller } from 'stimulus'
import Cleave from 'cleave.js'
import 'cleave.js/dist/addons/cleave-phone.us'

export default class extends Controller {
  static values = { options: Object, digits: Number }

  connect () {
    this.cleave = new Cleave(this.element, this.optionsValue)
    if (this.hasDigitsValue)
      this.element.addEventListener('beforeinput', this.inputHandler)
  }

  disconnect () {
    this.cleave.destroy()
    if (this.hasDigitsValue)
      this.element.removeEventListener('beforeinput', this.inputHandler)
  }

  inputHandler = event => {
    if (
      String(this.element.value).length === this.digitsValue &&
      event.inputType === 'insertText'
    )
      event.preventDefault()
  }
}
