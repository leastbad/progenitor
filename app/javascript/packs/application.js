import 'stylesheets/application.scss'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'
import Turbolinks from 'turbolinks'
import Rails from '@rails/ujs'
import * as ActiveStorage from '@rails/activestorage'
import CableReady from 'cable_ready'
import { Notyf } from 'notyf'
import flash from '../shared/notyf'

// import Turbo from '@hotwired/turbo'
// import LocalTime from 'local-time'

import 'controllers'
import 'channels'

const images = require.context('../images', true)
// const imagePath = name => images(name, true)

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// LocalTime.start()

CableReady.DOMOperations.toast = operation => {
  new Notyf(flash).open(operation)
}

CableReady.DOMOperations.increment = operation => {
  console.log('Jazz hands!', operation)
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
