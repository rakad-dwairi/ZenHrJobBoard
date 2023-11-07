class UpdateApplicationDateInJobApplication < ActiveRecord::Migration[7.1]
  def change
    change_column_default :job_applications, :application_date, Date.current
  end
end
