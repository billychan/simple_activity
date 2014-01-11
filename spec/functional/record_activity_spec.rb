require 'spec_helper'

describe "Record activity by automatic after_filter", type: :controller do

  controller ArticlesController do
    include SimpleActivity::ControllerMethods

    def create
      @article = Article.new(params[:article])
      @article.save ? render(text: 'saved') : render(text: 'error')
    end
  end

  before do
    @user = User.create(name: 'Bob')
    allow(@controller).to receive(:current_user).and_return(@user)
    allow(@controller).to receive(:controller_name).and_return('articles')
  end

  context "create activity" do
    before do
      post :create, {article: {title: 'foo', user_id: @user.id}}
    end

    let(:activity){SimpleActivity::Activity.last}

    it "keeps the original process" do
      expect(Article.count).to eq(1)
    end

    it "adds activity succesfully" do
      expect(activity.actor_type).to  eq('User')
      expect(activity.actor_id).to    eq(@user.id)
      expect(activity.target_type).to eq('Article')
      expect(activity.target_id).to   eq(Article.last.id)
      expect(activity.action_key).to  eq('create')
    end

    it "gets cache to work properly" do
      expect(activity.actor_name).to eq('Bob')
      expect(activity.target_title).to eq('foo')
    end
  end

  context "Callbacks for third party libs" do
    before do
      stub_const "FooLib", Class.new
    end

    it "calls the third party #process with valid activity" do
      SimpleActivity::Callbacks.add('FooLib')
      expect(FooLib).to receive(:process) do |activity|
        expect(activity).to be_persisted
      end
      post :create, {article: {title: 'foo', user_id: @user.id}}
    end

    it "add the third party to backend jobs" do
      SimpleActivity::Callbacks.add('FooLib', backend: true)
      job = double('job')
      allow(FooLib).to receive(:delay).and_return(job)
      expect(job).to receive(:process)
      post :create, {article: {title: 'foo', user_id: @user.id}}
    end

    after do
      SimpleActivity::Callbacks.delete('FooLib')
      hide_const("Foolib")
    end
  end

end
