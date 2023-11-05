class AddExpiryDateToJobPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :job_posts, :expiry_date, :date
  end
end
