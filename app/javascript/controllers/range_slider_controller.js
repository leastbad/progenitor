import { Controller } from 'stimulus'
import noUiSlider from 'nouislider'
import wNumb from 'wnumb'

export default class extends Controller {
  static values = { min: Number, max: Number, low: Number, high: Number }
  static targets = ['low', 'high']

  connect () {
    this.slider = noUiSlider.create(this.element, {
      start: [this.lowValue, this.highValue],
      connect: !0,
      tooltips: [wNumb({ decimals: 0 }), wNumb({ decimals: 0 })],
      step: 1,
      range: {
        min: [this.minValue],
        max: [this.maxValue]
      }
    })
    this.slider.on('update', (a, b, c) => {
      this[b === 0 ? 'lowTarget' : 'highTarget'].value = c[b]
    })
  }

  disconnect () {
    this.slider.destroy()
  }
}
