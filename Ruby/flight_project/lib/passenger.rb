class Passenger
    attr_reader :name
    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    def has_flight?(flightNum)
        return @flight_numbers.include?(flightNum.upcase)
    end
    
    def add_flight(flightNum)
        @flight_numbers << flightNum.upcase if !has_flight?(flightNum)
    end
end