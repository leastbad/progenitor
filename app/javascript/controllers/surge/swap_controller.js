import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['a', 'b']
  enter () {
    this.aTarget.classList.add('d-none')
    this.bTarget.style = 'animation: 150ms show-b'
    this.bTarget.classList.remove('d-none')
  }
  exit () {
    this.bTarget.classList.add('d-none')
    this.aTarget.style = 'animation: 150ms show-a'
    this.aTarget.classList.remove('d-none')
  }
}
