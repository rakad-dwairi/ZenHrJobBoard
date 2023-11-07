class UpdateFieldToYourModel < ActiveRecord::Migration[7.1]
  def change
    change_column_default :job_applications, :status, "Not Seen"
  end
end
