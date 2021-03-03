// Load all the controllers within this directory and all subdirectories.
// Controller files must be named *_controller.js.

import { Application } from 'stimulus'
import { definitionsFromContext } from 'stimulus/webpack-helpers'
import StimulusReflex from 'stimulus_reflex'
import consumer from '../channels/consumer'
import controller from '../controllers/application_controller'
import Flatpickr from 'stimulus-flatpickr'
import Dropzone from 'dropzone'

Dropzone.autoDiscover = false

const context = require.context('controllers', true, /_controller\.js$/)
const surge = require.context('controllers/surge', true, /_controller\.js$/)

const application = Application.start()
application.load(definitionsFromContext(context))
application.load(definitionsFromContext(surge))
application.register('flatpickr', Flatpickr)
application.consumer = consumer

StimulusReflex.initialize(application, { consumer, controller, isolate: true })

if (process.env.RAILS_ENV === 'development') {
  StimulusReflex.debug = true
  import('radiolabel').then(Radiolabel =>
    application.register('radiolabel', Radiolabel.default)
  )
}
