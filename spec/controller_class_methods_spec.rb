require 'spec/spec_helper'
require 'ostruct'

module RailsNoDatabaseInView

  class SillyErrorForTest < StandardError
  end

  describe ControllerClassMethods do

    let(:controller_class) {
      Class.new do
        extend ControllerClassMethods
        def render
          raise SillyErrorForTest
        end
      end
    }

    context "no_database_access_from_view!" do

      # These are order-dependent

      it "render instance method is not patched unless called" do
        exception = capture_exception { controller_class.new.render }
        was_intercepted?(exception).should be_false
      end

      it "includes ControllerInstanceMethods" do
        controller_class.instance_eval { no_database_access_from_view! }
        controller_class.kind_of?(ControllerInstanceMethods)
      end

      it "patches render instance method" do
        controller_class.instance_exec { no_database_access_from_view! }
        exception = capture_exception { controller_class.new.render }
        was_intercepted?(exception).should be_true
      end

      private

      def capture_exception
        exception = nil
        begin
          yield
        rescue SillyErrorForTest => e
          exception = e
        end
        exception
      end

      def was_intercepted? exception
        exception.backtrace.any? do |line|
          line =~ /rails_no_database_in_view.controller_instance_methods\.rb/ &&
          line.include?('render')
        end
      end

    end
  end

end

