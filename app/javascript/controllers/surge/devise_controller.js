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
    this.modalTarget.addEventListener('hidden.bs.modal', this.clearOtp)
  }

  disconnect () {
    this.element.removeEventListener('ajax:response:error', this.loginFailed)
    this.modalTarget.removeEventListener('shown.bs.modal', this.focus)
    this.modalTarget.removeEventListener('hidden.bs.modal', this.clearOtp)
  }

  loginFailed = async event => {
    event.preventDefault()
    this.errorsTarget.classList.replace('d-none', 'd-flex')
    this.messageTarget.textContent = await event.detail.fetchResponse.text()
    this.formChecked = true
    this.otpTarget.focus()
  }

  proceed (e) {
    if (this.formChecked) {
      this.formChecked = undefined
      return
    }
    if (this.element.checkValidity()) {
      if (e) e.preventDefault()
      this.otpTarget.value.length === 6
        ? this.submitForm(true)
        : this.stimulate(
            'TwoFactorAuth#otp_enabled',
            { serializeForm: false },
            this.emailTarget.value
          ).then(({ payload }) => {
            this.numberTarget.textContent = payload.number
            this.smsTarget.classList[payload.sms ? 'remove' : 'add']('d-none')
            payload.tfa ? this.modal.show() : this.submitForm(false)
          })
    }
  }

  submitForm = hide => {
    if (this.formChecked == false) return
    this.formChecked = true
    if (hide) this.modal.hide()
    this.submitTarget.click()
    this.formChecked = false
  }

  focus = () => {
    this.errorsTarget.classList.replace('d-flex', 'd-none')
    this.otpTarget.focus()
  }

  count = () => {
    if (this.otpTarget.value.length === 6) this.proceed()
  }

  clearOtp = () => {
    this.otpTarget.value = ''
  }
}
