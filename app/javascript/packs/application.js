import 'stylesheets/application.scss'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'
import Turbolinks from 'turbolinks'
// import Rails from '@rails/ujs'
import * as ActiveStorage from '@rails/activestorage'
import CableReady from 'cable_ready'
import { Notyf } from 'notyf'
import flash from '../shared/notyf'
import debounced from 'debounced'

import mrujs from 'mrujs'
window.mrujs = mrujs.start()

// import Turbo from '@hotwired/turbo'
// import LocalTime from 'local-time'

import 'controllers'
import 'channels'

const images = require.context('../images', true)
// const imagePath = name => images(name, true)

// Rails.start()
Turbolinks.start()
ActiveStorage.start()
debounced.initialize()

// LocalTime.start()

CableReady.DOMOperations.toast = operation => {
  new Notyf(flash).open(operation)
}

document.addEventListener('DOMContentLoaded', function () {
  if (document.body.hasAttribute('data-unlock-audio')) {
    const unlocked = () => {
      document.body.removeEventListener('click', unlocked)
      document.body.removeEventListener('touchstart', unlocked)
      document.body.setAttribute('data-audio-unlocked', true)
    }
    document.body.addEventListener('click', unlocked)
    document.body.addEventListener('touchstart', unlocked)
  }
})
