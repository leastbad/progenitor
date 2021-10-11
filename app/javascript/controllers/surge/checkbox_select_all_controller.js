import ApplicationController from '../application_controller'

export default class extends ApplicationController {
  static targets = ['buttonAll', 'checkboxAll', 'checkbox', 'delete']
  static values = { reflex: String }

  connect () {
    super.connect()
    if (!this.requirementsSatisfied) return

    this.buttonAllTarget.addEventListener('click', this.click)
    this.deleteTarget.addEventListener('click', this.delete)
    this.checkboxAllTarget.addEventListener('change', this.toggle)
    this.checkboxTargets.forEach(checkbox =>
      checkbox.addEventListener('change', this.refresh)
    )
    this.refresh()
  }

  disconnect () {
    if (!this.requirementsSatisfied) return

    this.buttonAllTarget.removeEventListener('click', this.click)
    this.deleteTarget.removeEventListener('click', this.delete)
    this.checkboxAllTarget.removeEventListener('change', this.toggle)
    this.checkboxTargets.forEach(checkbox =>
      checkbox.removeEventListener('change', this.refresh)
    )
  }

  click = e => {
    if (e.target.tagName !== 'BUTTON') return
    this.checkboxAllTarget.click()
  }

  checkboxTargetConnected (checkbox) {
    checkbox.addEventListener('change', this.refresh)
    this.refresh()
  }

  checkboxTargetDisconnected (checkbox) {
    checkbox.removeEventListener('change', this.refresh)
    this.refresh()
  }

  toggle = e => {
    e.preventDefault()

    this.checkboxTargets.forEach(checkbox => {
      checkbox.checked = e.target.checked
      this.triggerInputEvent(checkbox)
    })

    this.manageDelete()
  }

  delete = () =>
    this.stimulate(
      this.reflexValue,
      this.checked.map(c => parseInt(c.dataset.id))
    ).then(this.refresh)

  refresh = () => {
    const checkboxesCount = this.checkboxTargets.length
    const checkboxesCheckedCount = this.checked.length

    this.checkboxAllTarget.checked = checkboxesCheckedCount > 0
    this.checkboxAllTarget.indeterminate =
      checkboxesCheckedCount > 0 && checkboxesCheckedCount < checkboxesCount

    this.buttonAllTarget[
      checkboxesCount > 0 ? 'removeAttribute' : 'setAttribute'
    ]('disabled', true)

    this.manageDelete()
  }

  triggerInputEvent = checkbox =>
    checkbox.dispatchEvent(
      new Event('input', { bubbles: false, cancelable: true })
    )

  manageDelete = () =>
    this.deleteTarget[
      this.checkboxAllTarget.checked || this.checkboxAllTarget.indeterminate
        ? 'removeAttribute'
        : 'setAttribute'
    ]('disabled', true)

  get checked () {
    return this.checkboxTargets.filter(checkbox => checkbox.checked)
  }

  get unchecked () {
    return this.checkboxTargets.filter(checkbox => !checkbox.checked)
  }

  get requirementsSatisfied () {
    return (
      this.hasCheckboxAllTarget &&
      this.hasButtonAllTarget &&
      this.hasDeleteTarget
    )
  }
}
