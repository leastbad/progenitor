import ApplicationController from '../application_controller'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends ApplicationController {
  static targets = [
    'errors',
    'message',
    'modal',
    'email',
    'submit',
    'otp',
    'sms',
    'number'
  ]

  initialize () {
    this.modal = bootstrap.Modal.getOrCreateInstance(this.modalTarget)
  }

  connect () {
    super.connect()
    this.element.addEventListener('ajax:response:error', this.loginFailed)
    this.modalTarget.addEventListener('shown.bs.modal', this.focus)
  }

  disconnect () {
    this.element.removeEventListener('ajax:response:error', this.loginFailed)
    this.modalTarget.removeEventListener('shown.bs.modal', this.focus)
  }

  loginFailed = async event => {
    event.preventDefault()
    this.errorsTarget.classList.replace('d-none', 'd-flex')
    this.messageTarget.textContent = await event.detail.fetchResponse.text()
    this.otpTarget.focus()
  }

  proceed (e) {
    if (this.formChecked) return

    if (this.element.checkValidity()) {
      e.preventDefault()
      this.stimulate(
        'Profile#otp_enabled',
        { serializeForm: false },
        this.emailTarget.value
      ).then(({ payload }) => {
        this.numberTarget.textContent = payload.number
        this.smsTarget.classList[payload.sms ? 'remove' : 'add']('d-none')
        payload.tfa ? this.modal.show() : this.submit()
      })
    }
  }

  focus = () => {
    this.otpTarget.focus()
  }

  submit = () => {
    this.formChecked = true
    this.modal.hide()
    this.submitTarget.click()
    this.formChecked = false
  }
}
