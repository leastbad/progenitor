import ApplicationController from '../application_controller'

export default class extends ApplicationController {
  static values = {
    reflex: String,
    states: Array,
    times: Array
  }

  connect () {
    if (!this.hasReflexValue) return
    super.connect()
    this.previousState = null
    this.previousTime = null
    this.observer = new MutationObserver(this.beacon)
    this.observer.observe(this.element, {
      attributeFilter: ['data-state', 'data-time'],
      childList: false,
      subtree: false
    })
  }

  disconnect () {
    if (!this.hasReflexValue) return
    this.observer.disconnect()
  }

  beacon = (mutations, observer) => {
    let sendReflex
    for (const mutation of mutations) {
      const newState = parseInt(mutation.target.dataset.state)
      const newTime = parseInt(mutation.target.dataset.time)
      let dirty
      if (
        mutation.attributeName === 'data-state' &&
        this.statesValue.includes(newState)
      )
        sendReflex = true
      if (
        mutation.attributeName === 'data-time' &&
        this.timesValue.includes(newTime)
      )
        sendReflex = true
      if (sendReflex) {
        if (newState !== this.previousState) {
          this.previousState = newState
          dirty = true
        }
        if (newTime !== this.previousTime) {
          this.previousTime = newTime
          dirty = true
        }
        if (dirty) this.stimulate(this.reflexValue)
      }
    }
  }
}
