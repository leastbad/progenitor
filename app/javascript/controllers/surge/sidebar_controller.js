import { Controller } from 'stimulus'
import { useResize, useDebounce } from 'stimulus-use'

export default class extends Controller {
  static debounces = ['resize']

  initialize () {
    this.sidebarToggle = document.getElementById('sidebar-toggle')
  }

  connect () {
    useResize(this, { element: document.body })
    useDebounce(this, { wait: 10 })
    this.sidebarToggle.addEventListener('click', this.clicked)
    this.element.addEventListener('mouseenter', this.mouseEntered)
    this.element.addEventListener('mouseleave', this.mouseLeft)
  }

  disconnect () {
    this.sidebarToggle.removeEventListener('click', this.clicked)
    this.element.removeEventListener('mouseenter', this.mouseEntered)
    this.element.removeEventListener('mouseleave', this.mouseLeft)
  }

  clicked = () => {
    if (this.element.classList.contains('contracted')) {
      this.element.classList.remove('contracted')
      localStorage.removeItem('sidebar')
    } else {
      this.element.classList.add('contracted')
      localStorage.setItem('sidebar', 'contracted')
    }
  }

  mouseEntered = () => {
    if (this.width < 768) return
    this.element.classList.remove('contracted')
  }

  mouseLeft = () => {
    if (this.width < 768) return
    this.element.classList[
      localStorage.getItem('sidebar') === 'contracted' ? 'add' : 'remove'
    ]('contracted')
  }

  resize ({ width }) {
    if (this.width === width) return
    this.width = width
    if (width < 768) this.element.classList.remove('contracted')
    else
      this.element.classList[
        localStorage.getItem('sidebar') === 'contracted' ? 'add' : 'remove'
      ]('contracted')
  }
}
