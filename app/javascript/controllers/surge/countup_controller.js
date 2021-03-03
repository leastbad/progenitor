import { Controller } from 'stimulus'
import { CountUp } from 'countup.js'

export default class extends Controller {
  static values = { switch: String, start: Number, end: Number }

  initialize () {
    this.switch = document.getElementById(this.switchValue)
    this.count = new CountUp(this.element, this.endValue, {
      startVal: this.startValue
    })
  }

  connect () {
    this.switch.addEventListener('change', this.run)
  }

  disconnect () {
    this.switch.removeEventListener('change', this.run)
  }

  run = () => {
    this.switch.checked ? this.count.start() : this.count.reset()
  }
}
