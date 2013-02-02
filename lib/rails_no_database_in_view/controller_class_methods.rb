module RailsNoDatabaseInView
  module ControllerClassMethods

    def no_database_access_from_view!
      self.class_eval do
        include ControllerInstanceMethods
      end
    end

  end
end
