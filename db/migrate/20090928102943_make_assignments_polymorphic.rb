class MakeAssignmentsPolymorphic < ActiveRecord::Migration

  def self.up
    change_table :assignments do |t|
      t.remove :subject_id
      t.references :security_subject, :polymorphic => true
    end
  end

  def self.down
    change_table :assignments do |t|
      t.remove :security_subject_id
      t.remove :security_subject_type
      t.integer :subject_id
    end
  end
end
