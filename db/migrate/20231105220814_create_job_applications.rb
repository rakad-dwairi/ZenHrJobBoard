class CreateJobApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :job_applications do |t|
      t.boolean :status
      t.references :user, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
