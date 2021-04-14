import { Controller } from 'stimulus'

export default class extends Controller {
  static values = { tag: String }

  initialize () {
    import('../../shared/audio').then(audio => (this.play = audio.play))
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
    const content = mutation[0].target.content
    if (content && content !== '0') {
      this.element.textContent = mutation[0].target.content
      this.element.classList.remove('d-none')
      this.play('/etc_woodblock_2x_octave.mp3')
    } else {
      this.element.textContent = ''
      this.element.classList.add('d-none')
    }
  }
}
