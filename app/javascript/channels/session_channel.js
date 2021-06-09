import CableReady from 'cable_ready'
import consumer from './consumer'

let reconnecting = false

consumer.subscriptions.create('SessionChannel', {
  received (data) {
    if (data.cableReady)
      CableReady.perform(data.operations, {
        emitMissingElementWarnings: false
      })
  },

  connected () {
    reconnecting = false
    document.addEventListener('reconnect', this.reconnect)
  },

  disconnected () {
    document.removeEventListener('reconnect', this.reconnect)
    // if (reconnecting) setTimeout(() => consumer.connect())
    if (reconnecting) consumer.connect()
  },

  reconnect () {
    reconnecting = true
    consumer.disconnect()
  }
})
