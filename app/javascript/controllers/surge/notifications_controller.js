import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['dot', 'shake']
  static values = { unread: Boolean }

  connect () {
    this.shakingInterval = setInterval(this.interval, 5000)
    this.element.addEventListener('show.bs.dropdown', this.dropdown)
  }

  disconnect () {
    clearInterval(this.shakingInterval)
    this.element.removeEventListener('show.bs.dropdown', this.dropdown)
  }

  interval = () => {
    this.dotTarget.style.display = this.unreadValue ? 'block' : 'none'
    if (this.unreadValue)
      this.shakeTarget.classList[
        this.shakeTarget.classList.contains('shaking') ? 'remove' : 'add'
      ]('shaking')
  }

  dropdown = () => {
    this.unreadValue = false
    clearInterval(this.shakingInterval)
    this.shakeTarget.classList.remove('shaking')
    this.dotTarget.style.display = 'none'
  }
}
