import 'stylesheets/application.scss'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import CableReady from 'cable_ready'
import { Notyf } from 'notyf'
import flash from '../shared/notyf'
import debounced from 'debounced'
import Rails from 'mrujs'
import AudioOperations from '@cable_ready/audio_operations'

// import LocalTime from 'local-time'

import 'controllers'
import 'channels'

const images = require.context('../images', true)
// const imagePath = name => images(name, true)

class MrujsCableCar {
  constructor () {
    this.observer = new MutationObserver(this.callback)
    this.elements = []
  }

  connect () {
    setTimeout(() => {
      document.querySelectorAll('[data-cable-car]').forEach(this.scanner)
      this.observer.observe(document.documentElement, {
        attributeFilter: ['data-cable-car'],
        subtree: true
      })
    })
  }

  disconnect () {
    this.elements.forEach(element => {
      element.removeEventListener('ajax:complete', this.process)
      element.observer.disconnect()
    })
    this.observer.disconnect()
  }

  callback = mutations => {
    mutations.forEach(mutation => this.scanner(mutation.target))
  }

  scanner = element => {
    element.addEventListener('ajax:complete', this.process)
    element.dataset.type = 'json'
    element.dataset.remote = 'true'
    element.observer = new MutationObserver(this.integrity)
    element.observer.observe(element, {
      attributeFilter: ['data-type', 'data-remote']
    })
    this.elements.push(element)
  }

  integrity = mutations => {
    mutations.forEach(mutation => {
      const element = mutation.target
      if (!element.hasAttribute('data-type')) element.dataset.type = 'json'
      if (!element.hasAttribute('data-remote')) element.dataset.remote = 'true'
    })
  }

  async process (event) {
    const x = await event.detail.fetchResponse
    console.log(x.isHtml)
    CableReady.perform(x.responseJson)
  }
}

Rails.start({
  plugins: [new MrujsCableCar()]
})

Turbolinks.start()
ActiveStorage.start()
debounced.initialize()
CableReady.addOperations(AudioOperations)

// LocalTime.start()

CableReady.operations.toast = operation => {
  new Notyf(flash).open(operation)
}

document.addEventListener('DOMContentLoaded', function () {
  const unlocked = () => {
    document.body.removeEventListener('click', unlocked)
    document.body.removeEventListener('touchstart', unlocked)
    document.body.setAttribute('data-audio-unlocked', true)
  }
  document.body.addEventListener('click', unlocked)
  document.body.addEventListener('touchstart', unlocked)
})
