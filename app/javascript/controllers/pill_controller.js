import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { tag: String }

  initialize () {
    this.metaTag = document.head.querySelector(
      `meta[name=pill-${this.tagValue}]`
    )
    this.element.textContent = this.metaTag.content
    this.observer = new MutationObserver(this.meta)
  }

  connect () {
    this.observer.observe(this.metaTag, {
      attributeFilter: ['content']
    })
  }

  disconnect () {
    this.observer.disconnect()
  }

  meta = mutation => {
    this.element.textContent = mutation[0].target.content
  }
}
