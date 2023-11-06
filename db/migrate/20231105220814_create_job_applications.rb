class CreateJobApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :job_applications do |t|
      t.string :status, default: 'Not Seen'
      t.references :user, foreign_key: true
      t.references :job_post, foreign_key: true

      t.timestamps
    end
  end
end
