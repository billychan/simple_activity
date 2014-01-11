require "spec_helper"

module SimpleActivity
  describe Activity do

    context "Dynamic methods on actor and target delegates to cache attr" do
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

      context "will not call cache for existing method" do
        %w{actor_type actor_id target_type target_id}.each do |method|
          it "calls #{method} directly" do
            expect(activity).not_to receive(:cache)
            activity.send method
          end
        end
      end
    end

    context "#rules" do
      let(:rules){ {'create'=>'bar', 'cache'=>'foo'} }
      let(:activity){Activity.new(target_type: 'Article')}

      before do
        all_rules = { 'Article' => rules }
        allow(Rule).to receive(:all_rules).and_return(all_rules)
      end

      it "gets rules for this target_type" do
        expect(activity.rules).to eq(rules)
      end

      it "gets speciic rules" do
        expect(activity.rules('create')).to eq('bar')
      end
    end

  end
end
