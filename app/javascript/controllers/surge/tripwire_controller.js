import ApplicationController from '../application_controller'
import { useIntersection } from 'stimulus-use'

export default class extends ApplicationController {
  static values = {
    reflex: String,
    charges: Number
  }

  initialize () {
    this.charges = this.hasChargesValue ? this.chargesValue : 1
  }

  connect () {
    if (!this.hasReflexValue) return
    super.connect()
    useIntersection(this)
  }

  appear (entry) {
    if (this.charges) {
      this.charges--
      this.stimulate(this.reflexValue, Math.round(entry.time))
    }
  }
}
