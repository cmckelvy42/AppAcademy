class Flight
    attr_reader :passengers
    def initialize(flightNum, capacity)
        @flight_number = flightNum
        @capacity = capacity
        @passengers = []
    end

    def full?
        return @passengers.size >= @capacity
    end

    def board_passenger(passenger)
        @passengers << passenger if !full? && passenger.has_flight?(@flight_number)
    end

    def list_passengers
        ret = []
        @passengers.each{|e| ret << e.name}
        return ret
    end

    def [](i)
        return @passengers[i]
    end

    def <<(passenger)
        board_passenger(passenger)
    end
end