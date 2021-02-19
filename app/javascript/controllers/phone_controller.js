import { Controller } from 'stimulus'
import Cleave from 'cleave.js'
import 'cleave.js/dist/addons/cleave-phone.us'

export default class extends Controller {
  connect () {
    this.cleave = new Cleave(this.element, {
      phone: true,
      phoneRegionCode: 'US'
    })
  }

  disconnect () {
    this.cleave.destroy()
  }
}
