import consumer from './consumer'
import CableReady from 'cable_ready'
import { Notyf } from 'notyf'
import flash from '../shared/notyf'

let channel

document.addEventListener('turbolinks:load', () => {
  if (channel) return

  channel = consumer.subscriptions.create('UsersChannel', {
    received (data) {
      if (!data) channel = undefined
      if (data.notification) notify(data.notification)
      if (data.cableReady) CableReady.perform(data.operations)
    }
  })
})

function notify (notification) {
  new Notyf(flash).open({ type: notification[0], message: notification[1] })
}
