import 'stylesheets/application.scss'

import bootstrap from 'bootstrap/dist/js/bootstrap.bundle'
import Turbolinks from 'turbolinks'
// import Turbo from '@hotwired/turbo'
import Rails from '@rails/ujs'
import * as ActiveStorage from '@rails/activestorage'
import LocalTime from 'local-time'

import 'controllers'
import 'channels'

const images = require.context('../images', true)
// const imagePath = name => images(name, true)

Rails.start()
Turbolinks.start()
LocalTime.start()
ActiveStorage.start()
