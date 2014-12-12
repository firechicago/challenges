class CreateAssignmentsTable < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :task_id, null: false
      t.integer :user_id, null: false
    end
  end
end
