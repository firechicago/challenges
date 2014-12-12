class CorrectAssignmentsColumns < ActiveRecord::Migration
  def change
    rename_column :assignments, :task_id, :project_id
  end
end
