class ImportMateriaAndTurmaController < ApplicationController
  def create
=begin     materia_data = JSON.parse(params[:data], symbolize_names: true) rescue nil
    if materia_data.present?
      begin
        import_materias(materia_data)
        render json: { message: "Data imported successfully!" }, status: :created
      rescue StandardError => e
        render json: { message: "Error importing data: #{e.message}" }, status: :bad_request
      end
    else
      render json: { message: "Invalid JSON data format." }, status: :bad_request
    end
=end
      if params[:file].present?
         file = params[:file].read
          materia_data = JSON.parse(file, symbolize_names: true) rescue nil

      if materia_data.present?
      begin
        import_materias(materia_data)
        flash[:notice] = "Dados importados com sucesso!"
        redirect_to new_formulario_path, :notice => flash[:notice]
        #render json: { message: "Data imported successfully!" }, status: :created
      rescue StandardError => e
        flash[:alert] = "Erro ao importar dados: #{e.message}"
        redirect_to new_formulario_path, :alert => flash[:alert]
      end
      else
        flash[:alert] = "Formato de dados JSON inválido."
        redirect_to new_formulario_path, :alert => flash[:alert]
      end
    else
        flash[:alert] = "Nenhum arquivo selecionado."
        redirect_to new_formulario_path, :alert => flash[:alert]
    end

  end

  private

  def import_materias(materia_data_array)
    materia_data_array.each do |materia_data|
      materia = Materia.create!(codigo: materia_data[:code], nome: materia_data[:name])
      turma_data = materia_data[:class]
      turma = materia.turmas.create!(codigo: turma_data[:classCode], semestre: turma_data[:semester], horario: turma_data[:time])
    end
  end
end
