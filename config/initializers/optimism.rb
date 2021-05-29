Optimism.configure do |config|
  config.channel_proc = ->(context) { SessionChannel.broadcasting_for(context.session.id) }
end
