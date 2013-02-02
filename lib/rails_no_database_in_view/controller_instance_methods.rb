module RailsNoDatabaseInView
  module ControllerInstanceMethods

    def self.included base
      base.instance_eval do
        unless respond_to? :render_without_database_disconnected_for_rendering
          alias_method :render_without_database_disconnected_for_rendering, :render
          alias_method :render, :render_with_database_disconnected_for_rendering
        end
      end
    end

    def render_with_database_disconnected_for_rendering *args
      with_database_disconnected_for_rendering do
        render_without_database_disconnected_for_rendering *args
      end
    end

    private

    def with_database_disconnected_for_rendering
      retval = nil
      begin
        @no_db_inside_render_call ||= 0
        @no_db_inside_render_call += 1
        if @no_db_inside_render_call > 1
          retval = yield
        else
          no_db_disconnect
          begin
            retval = yield
          rescue StandardError => e
            if e.class.to_s.include?('ActiveRecord::') || e.message['not connected'] || e.message['closed database']
              raise DatabaseAccessFromViewError.new(e)
            else
              raise e
            end
          ensure
            no_db_reconnect
          end
        end
      ensure
        @no_db_inside_render_call -= 1
      end
      retval
    end

    def no_db_disconnect
      ActiveRecord::Base.connection.disconnect!
    end

    def no_db_reconnect
      ActiveRecord::Base.connection.reconnect!
      ActiveRecord::Base.establish_connection
    end

  end
end
