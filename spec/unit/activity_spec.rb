require "spec_helper"

module SimpleActivity
  describe Activity do

    context "Use cache to find methods about actor and target" do
      let(:activity){Activity.new}

      it "respond to methods start with actor_" do
        expect(activity).to respond_to(:actor_foo)
      end

      it "respond to methods start with target_" do
        expect(activity).to respond_to(:target_foo)
      end

      it "get the result by serialized cache" do
        allow(activity).to receive(:cache).and_return(
          {'actor_foo'=>'bar'}
        )
        expect(activity.actor_foo).to eq('bar')
      end
    end

  end
end
