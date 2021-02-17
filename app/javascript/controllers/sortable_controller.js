import { Controller } from 'stimulus'
import { useResize } from 'stimulus-use'
import Sortable from 'sortablejs'

export default class extends Controller {
  static values = { group: String }

  initialize () {
    useResize(this, { element: document.body })
    this.group = this.groupValue || 'shared'
  }

  disconnect () {
    if (this.sortable) this.sortable.destroy()
  }

  resize ({ width }) {
    if (width > 991 && !this.sortable)
      this.sortable = new Sortable(this.element, {
        group: this.group
      })
  }
}
