class AddPasswordDigestToUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :password_digest # Adding this line to remove the column incase it existed
    add_column :users, :password_digest, :string
  end
end
