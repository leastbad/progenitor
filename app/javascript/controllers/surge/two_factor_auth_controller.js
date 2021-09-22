import ApplicationController from '../application_controller'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends ApplicationController {
  static targets = ['modal']

  beforeDisable () {
    if (this.hasModalTarget)
      bootstrap.Modal.getInstance(this.modalTarget).dispose()
  }
}
