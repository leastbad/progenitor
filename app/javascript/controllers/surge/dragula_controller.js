import { Controller } from 'stimulus'
import { useResize } from 'stimulus-use'
import dragula from 'dragula'

export default class extends Controller {
  static targets = ['container']

  initialize () {
    useResize(this, { element: document.body })
  }

  disconnect () {
    if (this.dragula) this.dragula.destroy()
  }

  resize ({ width }) {
    if (width > 991 && !this.dragula) {
      this.dragula = dragula(this.containerTargets, {
        accepts: (el, target, source, sibling) => {
          return el.hasAttribute('data-drag')
        }
      })
      this.dragula.on('drag', () =>
        this.containerTargets.forEach(ele => ele.classList.add('dragging'))
      )
      this.dragula.on('dragend', () =>
        this.containerTargets.forEach(ele => ele.classList.remove('dragging'))
      )
    }
  }
}
