import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'textarea',
    'container',
    'polite',
    'progressbar',
    'svgcontainer',
    'svg',
    'circle',
    'number'
  ]
  static values = { limit: Number }

  initialize () {
    this.limit = this.limitValue || 280
    this.update()
  }

  connect () {
    this.textareaTarget.addEventListener('change', this.update)
    this.textareaTarget.addEventListener('input', this.update)
  }

  disconnect () {
    this.textareaTarget.removeEventListener('change', this.update)
    this.textareaTarget.removeEventListener('input', this.update)
  }

  update = () => {
    const count = this.textareaTarget.value.length
    const spread = this.limit - count
    const inc = 56.3467 / this.limit
    this.politeTarget.textContent =
      spread < 0
        ? `You have exceeded the character limit by ${Math.abs(spread)}`
        : `${spread} characters remaining`
    this.progressbarTarget.setAttribute(
      'aria-valuenow',
      Math.min(parseInt(count / (this.limit / 100)), 100)
    )
    this.numberTarget.textContent = spread
    this.containerTarget.style.opacity = count === 0 ? 0 : 1
    this.progressbarTarget.style.opacity = count >= this.limit + 10 ? 0 : 1
    this.numberTarget.style.color = count >= this.limit ? '#fa5252' : '#5b7083'
    this.circleTarget.style.strokeDashoffset = Math.max(spread * inc, 0)
    if (count >= this.limit - 20) {
      this.svgcontainerTarget.style.height = '30px'
      this.svgcontainerTarget.style.width = '30px'
      this.numberTarget.style.opacity = 1
      if (count >= this.limit)
        this.circleTarget.setAttribute('stroke', '#fa5252')
      else this.circleTarget.setAttribute('stroke', '#f3b773')
      this.circleTarget.style.strokeDasharray = 87.9646
      this.circleTarget.setAttribute('r', 14)
      this.svgTarget.setAttribute('viewBox', '0 0 30 30')
    } else {
      this.svgcontainerTarget.style.height = '20px'
      this.svgcontainerTarget.style.width = '20px'
      this.numberTarget.style.opacity = 0
      this.circleTarget.setAttribute('stroke', '#2ca58d')
      this.circleTarget.style.strokeDasharray = 56.5487
      this.circleTarget.setAttribute('r', 9)
      this.svgTarget.setAttribute('viewBox', '0 0 20 20')
    }
  }
}
