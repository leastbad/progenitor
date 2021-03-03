import { Controller } from 'stimulus'
import Masonry from 'masonry-layout'
import { useResize } from 'stimulus-use'
import debounce from 'lodash/debounce'

export default class extends Controller {
  static targets = ['item']

  initialize () {
    this.resize = debounce(this.resize, 20)
    useResize(this)
  }

  resize ({ width }) {
    if (this.width === width) return
    this.width = width
    if (this.masonry) this.masonry.destroy()
    this.masonry = new Masonry(this.element)
    this.masonry.addItems(this.itemTargets)
  }
}
