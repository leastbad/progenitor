import ApplicationController from '../application_controller'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends ApplicationController {
  static targets = ['disableModal']

  beforeDisable () {
    if (this.hasDisableModalTarget)
      bootstrap.Modal.getInstance(this.disableModalTarget).dispose()
  }
}
