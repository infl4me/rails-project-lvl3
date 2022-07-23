class AddAdminUsers < ActiveRecord::Migration[6.1]
  def change
    User.update_all({ email: 'hellpl4y@gmail.com' }, { admin: true })
  end
end
