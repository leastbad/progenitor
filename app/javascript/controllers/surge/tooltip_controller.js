import { Controller } from 'stimulus'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends Controller {
  connect () {
    this.tooltip = new bootstrap.Tooltip(this.element)
    this.element.addEventListener('hidden.bs.tooltip', this.hide)
  }

  disconnect () {
    this.element.removeEventListener('hidden.bs.tooltip', this.hide)
    this.tooltip.dispose()
  }

  hide = () => {
    this.tooltip.hide() // this covers a weird popper glitch
  }
}
