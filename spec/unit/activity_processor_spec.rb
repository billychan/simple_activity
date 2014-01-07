require 'spec_helper'
require 'ostruct'

module SimpleActivity

  describe ActivityProcessor do

    before do
      @user       = OpenStruct.new(name: 'Bob', id: 1, class: 'User')
      @controller = OpenStruct.new(controller_name: 'articles', 
                                   action_name: 'update', 
                                   current_user: @user)  
      @article    = ::Article.create(title: 'foo')
      allow(@controller).to receive(:instance_variable_get).with("@article")
      .and_return(@article)
    end

    context "Create valid activity" do

      it "works with single argument of controller" do
        activity_service = ActivityProcessor.new(@controller)
        activity_service.save
        activity = Activity.last
        expect(activity.actor_id).to eq(1)
        expect(activity.target_id).to eq(1)
        expect(activity.action_key).to eq('update')
      end

      it "works with customized target" do
        comment = ::Comment.create(body: 'foobar')
        activity_service = ActivityProcessor.new(@controller, comment)
        activity_service.save
        expect(Activity.last.target_type).to eq('Comment')
      end
    end

    context "Log error to logger" do

      it "does so on wrong action_name" do
        @controller.action_name = ''
        activity_service = ActivityProcessor.new(@controller)
        expect(activity_service).to receive(:warning)
        activity_service.save
      end

      it "does so on target with error" do
        @article.errors.add(:title, 'fake error')
        activity_service = ActivityProcessor.new(@controller, @article)
        expect(activity_service).to receive(:warning)
        activity_service.save
      end

    end

  end
end
