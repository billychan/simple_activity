require 'spec_helper'

# Put this in seperate test
# The reason is there is only one controller in this spec, it
# will be polluted after setting after_filter once
describe "custom allowed actions", type: :controller do
  controller do
    def foo
      render text: 'custom action foo'
    end
  end

  before do
    allow(SimpleActivity).to receive(:allowed_actions).and_return([:foo])
    @controller.class_eval { include SimpleActivity::ControllerMethods }
  end

  it "works on user added action(s)" do
    routes.draw { post "foo" => "anonymous#foo" }
    expect(@controller).to receive(:process_activity)
    post :foo
  end
end
