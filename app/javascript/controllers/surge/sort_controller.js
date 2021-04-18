import { Controller } from 'stimulus'

export default class extends Controller {
  initialize () {
    this.columns = this.element.querySelectorAll('[data-filter]')
  }

  connect () {
    this.columns.forEach(c => c.addEventListener('click', this.click))
  }

  disconnect () {
    this.columns.forEach(c => c.removeEventListener('click', this.click))
  }

  click = e => {
    const data = e.target.dataset
    const icon = e.target.querySelector('span')
    if (data.active === 'true') {
      data.direction = data.direction === 'asc' ? 'desc' : 'asc'
    }
  }
}
