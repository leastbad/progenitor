# frozen_string_literal: true

# ActionCable.server.config.logger = Logger.new(nil)

module ActionCable
  class RemoteConnections
    class RemoteConnection
      def valid_identifiers?(ids)
        keys = ids.keys
        identifiers.any? { |id| keys.include?(id) }
      end
    end
  end
end
