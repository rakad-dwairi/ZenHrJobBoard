class CreateJobPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :job_posts do |t|
      t.string :title
      t.text :description
      t.date :date_posted
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
