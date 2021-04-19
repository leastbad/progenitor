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
    this.columns.forEach(c => {
      const link = c.dataset
      const svg = c.querySelector('svg').classList
      if (c.isSameNode(e.target)) {
        svg.remove('d-none')
        if (link.direction === 'asc') {
          link.direction = 'desc'
          svg.remove('fa-chevron-down')
          svg.add('fa-chevron-up')
        } else {
          link.direction = 'asc'
          svg.remove('fa-chevron-up')
          svg.add('fa-chevron-down')
        }
      } else {
        link.direction = 'desc'
        svg.add('d-none')
      }
    })
  }
}
