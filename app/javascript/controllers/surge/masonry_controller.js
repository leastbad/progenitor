import { Controller } from 'stimulus'
import Masonry from 'masonry-layout'
import { useResize, useDebounce } from 'stimulus-use'

export default class extends Controller {
  static targets = ['item']
  static debounces = ['resize']

  initialize () {
    useResize(this)
    useDebounce(this, { wait: 20 })
  }

  resize ({ width }) {
    if (this.width === width) return
    this.width = width
    if (this.masonry) this.masonry.destroy()
    this.masonry = new Masonry(this.element)
    this.masonry.addItems(this.itemTargets)
  }
}
