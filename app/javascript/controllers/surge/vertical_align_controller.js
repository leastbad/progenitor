import { Controller } from 'stimulus'
import { useResize } from 'stimulus-use'

export default class extends Controller {
  static targets = ['element']

  initialize () {
    useResize(this)
    this.groups = [
      ...new Set(
        this.elementTargets.map(element => {
          return element.dataset.group || ''
        })
      )
    ]
  }

  resize () {
    this.groups.forEach(group => {
      const elementGroup = this.elementTargets.filter(element => {
        if (element.dataset.group) return element.dataset.group === group
        return '' === group
      })
      const height = Math.max(
        ...elementGroup.map(element => {
          return element.offsetHeight
        })
      )
      elementGroup.forEach(element => (element.style.minHeight = `${height}px`))
    })
  }
}
