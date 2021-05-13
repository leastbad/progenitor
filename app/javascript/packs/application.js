import 'stylesheets/application.scss'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'
import Turbolinks from 'turbolinks'
import * as ActiveStorage from '@rails/activestorage'
import CableReady from 'cable_ready'
import { Notyf } from 'notyf'
import flash from '../shared/notyf'
import debounced from 'debounced'
import Rails from '@rails/ujs'
// import Rails from 'mrujs'

// import LocalTime from 'local-time'

import 'controllers'
import 'channels'

const images = require.context('../images', true)
// const imagePath = name => images(name, true)

Rails.start()
Turbolinks.start()
ActiveStorage.start()
debounced.initialize()

// LocalTime.start()

CableReady.DOMOperations.toast = operation => {
  new Notyf(flash).open(operation)
}
