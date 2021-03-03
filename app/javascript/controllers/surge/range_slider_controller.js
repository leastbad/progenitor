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
    const hiddenLow = document.createElement('input')
    hiddenLow.type = 'hidden'
    hiddenLow.setAttribute('data-range-slider-target', 'low')
    this.element.appendChild(hiddenLow)
    const hiddenHigh = document.createElement('input')
    hiddenHigh.type = 'hidden'
    hiddenHigh.setAttribute('data-range-slider-target', 'high')
    this.element.appendChild(hiddenHigh)
  }
}
