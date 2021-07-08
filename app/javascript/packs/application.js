import 'stylesheets/application.scss'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import CableReady from 'cable_ready'
import { Notyf } from 'notyf'
import flash from '../shared/notyf'
import debounced from 'debounced'
import Rails, { CableCar } from 'mrujs'
import AudioOperations from '@cable_ready/audio_operations'

// import LocalTime from 'local-time'

import 'controllers'
import 'channels'

const images = require.context('../images', true)
// const imagePath = name => images(name, true)

Rails.start({
  plugins: [new CableCar(CableReady)]
})

Turbolinks.start()
ActiveStorage.start()
debounced.initialize()
CableReady.addOperations(AudioOperations)

// LocalTime.start()

CableReady.operations.toast = operation => {
  new Notyf(flash).open(operation)
}

CableReady.operations.favicon = operation => {
  let link = document.head.querySelector(`link[rel~='icon']`)
  if (!link) {
    link = document.createElement('link')
    link.rel = 'icon'
    document.head.appendChild(link)
  }
  link.href = operation.emoji
    ? `data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 16 16%22><text x=%220%22 y=%2214%22>${operation.emoji}</text></svg>`
    : operation.src
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
