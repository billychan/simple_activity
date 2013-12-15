require 'spec_helper'

module SimpleActivity
  describe ModelExtenders do
    context "#activities method" do
      before do
        stub_const 'ActorFoo',  Class.new
        stub_const 'TargetFoo', Class.new
        stub_const 'Activity',  Class.new
        ActorFoo.extend ModelExtenders
        TargetFoo.extend ModelExtenders
        ActorFoo.class_eval do
          acts_as_activity_actor
        end
        TargetFoo.class_eval do
          acts_as_activity_target
        end
      end

      let(:actor_foo){ActorFoo.new}
      let(:target_foo){TargetFoo.new}

      it "assigns #activities to actor instance" do
        expect(actor_foo).to respond_to(:activities)
      end

      it "delivers right method of Activity for actor" do
        expect(Activity).to receive(:actor_activities).with(actor_foo)
        actor_foo.activities
      end

      it "assigns #activities to target instance" do
        expect(target_foo).to respond_to(:activities)
      end

      it "delivers right method of Activity for target" do
        expect(Activity).to receive(:target_activities).with(target_foo)
        target_foo.activities
      end
    end
  end
end
