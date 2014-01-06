class CreateActivity < ActiveRecord::Migration
  def change
    create_table :simple_activity_activities do |t|
      t.string  :actor_type
      t.integer :actor_id
      t.string  :target_type
      t.integer :target_id
      t.string  :action_key
      t.boolean :display
      t.text    :cache

      t.timestamps
    end
  end
end
