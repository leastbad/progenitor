import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import StimulusReflex from 'stimulus_reflex'
import consumer from '../channels/consumer'
import controller from './application_controller'
import Flatpickr from 'stimulus-flatpickr'
import Dropzone from 'dropzone'
import CableReady from 'cable_ready'

Dropzone.autoDiscover = false

const app = require.context('controllers', true, /_controller\.js$/)
const surge = require.context('controllers/surge', true, /_controller\.js$/)

const application = Application.start()
application.load(definitionsFromContext(app))
application.load(definitionsFromContext(surge))
application.register('flatpickr', Flatpickr)
application.consumer = consumer

StimulusReflex.initialize(application, {
  controller,
  isolate: true
})

if (process.env.RAILS_ENV === 'development') {
  StimulusReflex.debug = true
  import('radiolabel').then(Radiolabel =>
    application.register('radiolabel', Radiolabel.default)
  )
}

document.addEventListener('turbo:before-cache', () => {
  application.controllers.forEach(controller => {
    if (typeof controller.teardown === 'function') {
      controller.teardown()
    }
  })
})

CableReady.initialize({ consumer })
