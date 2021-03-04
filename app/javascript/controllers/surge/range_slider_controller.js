import { Controller } from 'stimulus'
import noUiSlider from 'nouislider'
import wNumb from 'wnumb'

export default class extends Controller {
  static values = { min: Number, max: Number }
  static targets = ['low', 'high', 'element']

  connect () {
    this.slider = noUiSlider.create(this.elementTarget, {
      start: [this.lowTarget.value, this.highTarget.value],
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
