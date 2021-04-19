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
          svg.replace('fa-chevron-down', 'fa-chevron-up')
        } else {
          link.direction = 'asc'
          svg.replace('fa-chevron-up', 'fa-chevron-down')
        }
      } else {
        link.direction = 'desc'
        svg.add('d-none')
      }
    })
  }
}
