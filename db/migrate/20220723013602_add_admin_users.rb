class AddAdminUsers < ActiveRecord::Migration[6.1]
  def change
    User.find_by_email('hellpl4y@gmail.com')&.update(admin: true)
  end
end
