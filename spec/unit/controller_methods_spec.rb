require 'spec_helper'

describe SimpleActivity::ControllerMethods do

  let(:controller_class) { Class.new }
  let(:controller) { controller_class.new }

  context "add after_filter" do

    it "add after_filter once included" do
      options = {only: [:create, :update, :destroy]}
      expect(controller_class).to receive(:after_filter)
      .with(:record_activity, options)
      controller_class.send(:include, SimpleActivity::ControllerMethods)
    end
  end

  context "methods" do
    before do
      controller_class.stub(:after_filter)
      controller_class.send(:include, SimpleActivity::ControllerMethods)
    end

    context "#record_activity" do

      it "sends a request to create a new activity" do
        foo = Object.new
        SimpleActivity::ActivityProcessor.stub(:new).and_return(foo)
        expect(foo).to receive(:save)
        controller.record_activity
      end

    end

  end
end
