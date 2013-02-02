module RailsNoDatabaseInView

  class FakeConnection
    def initialize
      @connected = true
    end

    def disconnect!
      @connected = false
    end

    def reconnect!
      @connected = true
    end

    def connected?
      @connected
    end
  end

  module ActiveRecord
    class Base
      def self.connection
        @connection ||= FakeConnection.new
      end
      def self.establish_connection
      end
    end
  end

end
