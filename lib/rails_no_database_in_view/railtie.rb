module RailsNoDatabaseInView
  class Railtie < Rails::Railtie
    config.to_prepare do
      ActionController::Base.extend ControllerClassMethods
    end
  end
end
