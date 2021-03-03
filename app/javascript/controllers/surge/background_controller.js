import { Controller } from 'stimulus'
import { useResize } from 'stimulus-use'

export default class extends Controller {
  static values = { image: String, breakpoint: Number }

  connect () {
    useResize(this, { element: document.body })
  }

  resize ({ width }) {
    if (this.hasBreakpointValue && width < this.breakpointValue) return
    this.element.style.background = `url(${this.imageValue})`
  }
}
