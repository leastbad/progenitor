import { Controller } from 'stimulus'
import noUiSlider from 'nouislider'

export default class extends Controller {
  static values = { min: Number, max: Number, current: Number }
  static targets = ['input']

  connect () {
    this.slider = noUiSlider.create(this.element, {
      start: this.currentValue,
      connect: [true, false],
      step: 1,
      range: {
        min: this.minValue,
        max: this.maxValue
      }
    })
    this.slider.on('update', (a, b, c) => {
      this.inputTarget.value = c[0]
    })
  }

  disconnect () {
    this.slider.destroy()
  }
}
