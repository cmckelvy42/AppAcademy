require_relative "room"

class Hotel
  def initialize(name, capacities)
    @name = name
    @rooms = {}

    capacities.each{|k, v| @rooms[k] = Room.new(v)}
  end
  def name
    @name.split(' ').map{|w| w.capitalize}.join(' ')
  end
  def rooms 
    @rooms 
  end
  def room_exists?(name)
    return rooms.keys.include?(name)
  end
  def check_in(person, room)
    if !room_exists?(room)
        p "sorry, room does not exist"
        return false
    end
    if @rooms[room].add_occupant(person)
        p "check in successful"
        return true
    else
        p "sorry, room is full"
        return false
    end
  end
  def has_vacancy?
    @rooms.each_value {|r| return true if !r.full?}
    return false
  end
  def list_rooms
    @rooms.each {|k, v| puts "#{k} : #{v.available_space}"}
  end
end
