import { Controller } from 'stimulus'

export default class extends Controller {
  initialize () {
    this.element.style.height = `${this.element.scrollHeight}px`
    this.element.style.overflowY = 'hidden'
    this.update()
  }

  connect () {
    this.element.addEventListener('input', this.update)
  }

  disconnect () {
    this.element.removeEventListener('input', this.update)
  }

  update = () => {
    this.element.style.height = 'auto'
    this.element.style.height = `${this.element.scrollHeight}px`
  }
}
