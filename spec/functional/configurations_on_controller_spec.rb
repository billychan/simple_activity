require 'spec_helper'

describe "Configurations on controller", type: :controller do
  controller do
    def create
      render text: 'do nothing but pass it through'
    end

    def update
      render text: "update"
    end

    def destroy
      render text: "destroy"
    end

    def foo
      render text: 'this is not on the default list'
    end
  end

  context "skip_controllers default settings" do
    before do
      @controller.class_eval{include SimpleActivity::ControllerMethods}
    end

    it "acts on normal controller names" do
      allow(@controller).to receive(:controller_name).and_return('articles')
      expect(@controller).to receive(:process_activity)
      post :create, {'foo'=>'bar'}
    end

    %w{Users Admin Session Registration}.each do |name|
      it "won't act on #{name}Controller" do
        allow(@controller).to receive(:controller_name).and_return(name.underscore)
        expect(@controller).not_to receive(:process_activity)
        post :create, {'foo'=>'bar'}
      end
    end
  end

  context "skip_controllers custom settings" do
    before do
      allow(SimpleActivity).to receive(:filtered_controllers)
      .and_return(/foo/i)
      @controller.class_eval{include SimpleActivity::ControllerMethods}
      allow(@controller).to receive(:controller_name).and_return('foos')
    end

    it "can be override by user" do
      expect(@controller).not_to receive(:process_activity)
      post :create, {'foo'=>'bar'}
    end
  end

  context "allowed_actions default settings" do
    before do
      @controller.class_eval{include SimpleActivity::ControllerMethods}
    end

    %w{create update destroy}.each do |action|
      it "works on default action #{action}" do
        expect(@controller).to receive(:process_activity)
        post :create, {'foo'=>'bar'}
      end
    end

    it "does nothing on custom action by default" do
      routes.draw { post "foo" => "anonymous#foo" }
      expect(@controller).not_to receive(:process_activity)
      post :foo
    end
  end

  # For allowed_actions custom settings, see another spec.
  # The reason is there is only one controller in this spec, it
  # will be polluted after setting after_filter once
end
