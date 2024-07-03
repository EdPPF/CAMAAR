class AddManyToManyRefToUserAndFormulario < ActiveRecord::Migration[7.1]
  def change
    create_table :users_formularios, id: false do |t|
      t.belongs_to :formulario
      t.belongs_to :user
    end

    add_index :formularios_users, :formulario_id
    add_index :formularios_users, :user_id
  end
end
