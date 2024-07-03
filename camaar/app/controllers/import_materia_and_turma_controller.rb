class ImportMateriaAndTurmaController < ApplicationController
  def create
    materia_data = parse_json_data(params[:data])
    if materia_data.is_a?(Array) && materia_data.all? { |item| item.is_a?(Hash) }
      import_materias(materia_data)
      render json: { message: "Data imported successfully!" }, status: :created
    else
      render json: { message: "Invalid JSON data format." }, status: :bad_request
    end
  rescue JSON::ParserError
    render json: { message: "Invalid JSON data format." }, status: :bad_request
  rescue StandardError => e
    render json: { message: "Error importing data: #{e.message}" }, status: :bad_request
  end

  private

  def parse_json_data(data)
    JSON.parse(data, symbolize_names: true)
  # rescue JSON::ParserError
  #   nil
  end

  def import_materias(materia_data_array)
    materia_data_array.each do |materia_data|
      materia = Materia.create!(codigo: materia_data[:code], nome: materia_data[:name])
      turma_data = materia_data[:class]
      materia.turmas.create!(codigo: turma_data[:classCode], semestre: turma_data[:semester], horario: turma_data[:time])
    end
  end
end
