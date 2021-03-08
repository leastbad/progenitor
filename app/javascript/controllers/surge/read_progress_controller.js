import { Controller } from 'stimulus'
import { useThrottle } from 'stimulus-use'

export default class extends Controller {
  static throttles = ['scroll']
  static targets = ['indicator']

  connect () {
    useThrottle(this, { wait: 50 })
    window.addEventListener('scroll', this.scroll, { passive: true })
  }

  disconnect () {
    window.removeEventListener('scroll', this.scroll, { passive: true })
  }

  scroll = () => {
    var e =
      ((document.body.scrollTop || document.documentElement.scrollTop) /
        (document.documentElement.scrollHeight -
          document.documentElement.clientHeight)) *
      100
    this.indicatorTarget.style.width = e + '%'
  }
}
