import ApplicationController from '../application_controller'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends ApplicationController {
  initialize () {
    this.modal = bootstrap.Modal.getOrCreateInstance(
      document.getElementById('modal-otp')
    )
    this.form = this.element.closest('form')
    this.email = document.getElementById('user_email')
  }

  proceed (e) {
    if (this.formChecked === true) return

    if (this.form.checkValidity()) {
      e.preventDefault()
      this.stimulate('Profile#otp_enabled', this.email.value).then(
        ({ payload }) => {
          if (payload) {
            this.modal.show()
          } else {
            this.formChecked = true
            this.element.click()
            this.formChecked = false
          }
        }
      )
    }
  }
}
