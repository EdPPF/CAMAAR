class RemoveQuestaoRefToFomulario < ActiveRecord::Migration[7.1]
  def change
    remove_reference :questaos, :formulario, foreign_key: true, index: false
  end
end
