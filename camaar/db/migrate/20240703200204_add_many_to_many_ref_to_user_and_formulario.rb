class AddManyToManyRefToUserAndFormulario < ActiveRecord::Migration[7.1]
  def change
    create_table :formularios_users, id: false do |t|
      t.belongs_to :formulario
      t.belongs_to :user
    end
  end
end
