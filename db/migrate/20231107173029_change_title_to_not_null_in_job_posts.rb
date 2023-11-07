class ChangeTitleToNotNullInJobPosts < ActiveRecord::Migration[7.1]
  def change
    change_column :job_posts, :title, :string, null: false, default: ''
  end
end
