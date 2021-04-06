import CableReady from 'cable_ready'
import consumer from './consumer'

consumer.subscriptions.create('SessionChannel', {
  received (data) {
    if (data.cableReady)
      CableReady.perform(data.operations, {
        emitMissingElementWarnings: false
      })
  },

  connected () {
    document.addEventListener('reconnect', this.reconnect)
  },

  disconnected () {
    document.removeEventListener('reconnect', this.reconnect)
  },

  reconnect () {
    consumer.disconnect()
    consumer.connect()
  }
})
