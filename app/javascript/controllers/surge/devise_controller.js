import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['errors', 'message']

  connect () {
    this.element.addEventListener('ajax:response:error', this.loginFailed)
  }

  disconnect () {
    this.element.removeEventListener('ajax:response:error', this.loginFailed)
  }

  loginFailed = async event => {
    this.errorsTarget.classList.replace('d-none', 'd-flex')
    this.messageTarget.textContent = await event.detail.response.text()
  }
}
