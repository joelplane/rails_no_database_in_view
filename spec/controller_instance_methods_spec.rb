require 'spec/spec_helper'

module RailsNoDatabaseInView
  describe ControllerInstanceMethods do

    context "#render" do

      let(:controller_class) {
        Class.new do
          def render
            ActiveRecord::Base.connection.connected?
          end
          include ControllerInstanceMethods
        end
      }

      let(:raising_controller_class) {
        Class.new do
          def render
            raise StandardError.new "blah not connected blah"
          end
          include ControllerInstanceMethods
        end
      }

      it "disconnects the database" do
        ActiveRecord::Base.connection.connected?.should be_true
        controller_class.new.render.should be_false
      end

      it "reconnects the database" do
        controller_class.new.render.should be_false
        ActiveRecord::Base.connection.connected?.should be_true
      end

      it "wraps database connection error from Rails" do
        expect { raising_controller_class.new.render }.to raise_error(DatabaseAccessFromViewError)
      end

    end
  end
end
