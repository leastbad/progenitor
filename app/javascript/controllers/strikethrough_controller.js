import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['checkbox', 'text']

  connect () {
    this.checkboxTarget.addEventListener('click', this.strike)
    this.strike()
  }

  disconnect () {
    this.checkboxTarget.removeEventListener('click', this.strike)
  }

  strike = () => {
    this.textTargets.forEach(element =>
      element.classList[this.checkboxTarget.checked ? 'add' : 'remove'](
        'line-through'
      )
    )
  }
}
