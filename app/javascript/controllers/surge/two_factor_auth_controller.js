import ApplicationController from '../application_controller'
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'

export default class extends ApplicationController {
  static targets = ['disableModal']

  enableApp = e => {
    setTimeout(() => {
      if (e.target.value.length !== 6) return
      this.stimulate('TwoFactorAuth#validate', e.target.value).then(
        ({ payload }) => {
          //respond
        }
      )
    })
  }

  beforeDisable () {
    if (this.hasDisableModalTarget)
      bootstrap.Modal.getInstance(this.disableModalTarget).dispose()
  }
}
