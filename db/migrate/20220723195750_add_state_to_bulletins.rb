class AddStateToBulletins < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :state, :string
    Bulletin.update_all(state: 'draft')
  end

  def down
    remove_column :bulletins, :state
  end
end
