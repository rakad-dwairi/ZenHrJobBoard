class CreateJobApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :job_applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true
      t.string :status
      t.date :application_date

      t.timestamps
    end
  end
end
