import { Controller } from 'stimulus'
import Masonry from 'masonry-layout'
import { useResize } from 'stimulus-use'

export default class extends Controller {
  static targets = ['item']

  initialize () {
    useResize(this)
    this.masonry = new Masonry(this.element)
    this.masonry.addItems(this.itemTargets)
  }

  resize () {
    this.masonry.reloadItems()
  }
}
