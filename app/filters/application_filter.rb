class ApplicationFilter < ActiveEntity::Base
  attr_accessor :id

  def initialize(attributes={})
    super
    unless @id
      @id = SecureRandom.uuid
      Kredis.json("#{self.class.name}:#{@id}").value = self.attributes.to_json
    end
  end

  def []=(attr_name, value)
    super
    Kredis.json("#{self.class.name}:#{@id}").value = self.attributes.to_json
  end

  def self.find(id)
    raise ArgumentError unless id
    filter = Kredis.json("#{name}:#{id}").value
    raise ActiveRecord::RecordNotFound unless filter
    new filter.merge(id: id)
  end
end