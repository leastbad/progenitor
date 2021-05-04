# frozen_string_literal: true

ActionCable.server.config.logger = Logger.new(nil)

# this code is/was intended to facilitate server-side AC disconnects
# however, with the recent addition of exponential falloffs,
# client-side disconnects are preferable... making this somewhat moot
# module ActionCable
#   class RemoteConnections
#     class RemoteConnection
#       def valid_identifiers?(ids)
#         keys = ids.keys
#         identifiers.any? { |id| keys.include?(id) }
#       end
#     end
#   end
# end
