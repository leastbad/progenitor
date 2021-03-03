import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['dot']
  static values = { unread: Boolean }

  connect () {
    this.bellShake = null
    this.shakingInterval = setInterval(this.interval, 5000)
    this.element.addEventListener('show.bs.dropdown', this.dropdown)
  }

  disconnect () {
    clearInterval(this.shakingInterval)
    this.element.removeEventListener('show.bs.dropdown', this.dropdown)
  }

  interval = () => {
    this.dotTarget.style.display = this.unreadValue ? 'block' : 'none'
    this.bellShake = this.bellShake || this.element.querySelector('.bell-shake')
    if (this.unreadValue)
      this.bellShake.classList[
        this.bellShake.classList.contains('shaking') ? 'remove' : 'add'
      ]('shaking')
  }

  dropdown = () => {
    this.unreadValue = false
    clearInterval(this.shakingInterval)
    this.bellShake.classList.remove('shaking')
    this.dotTarget.style.display = 'none'
  }
}
