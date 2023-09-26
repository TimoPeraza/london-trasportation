class Station
  attr_accessor :name, :zones

  def initialize(name, zones)
    @name = name
    @zones = zones

    validate
  end

  private

  def validate
    raise 'Name should be a string and not nil' if !name.is_a?(String)
    raise 'Zones should be an Array of Integers and not empty' if !zones.is_a?(Array) || zones.empty? || !zones.all?(Integer)
  end
end
