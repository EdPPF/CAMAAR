require 'csv'

## Responsável por controlar as ações CRUD de Formulários
#

class FormulariosController < ApplicationController

    ##
    # Lista todos os formulários.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: renderiza um JSON com todos os formulários.

    def index
        @formularios = Formulario.all
        # mudei de render json: formularios, status: :ok para render json: formularios, status: :ok
        respond_to do |format|
            format.html
            format.json { render json: @formularios }
        end
    end


    ##
    # Mostra um formulário específico.
    #
    # Parâmetros:: o ID do formulário, passado pela rota.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: renderiza um JSON com o formulário.
    # - Se o formulário não for encontrado, renderiza um JSON com erro 404.

    def show
        @formulario = Formulario.find(params[:id])
         # render json: formulario, status: :ok

        respond_to do |format|
            format.html
            format.json { render json: @formulario }
        end
    rescue StandardError => e
        render json: e, status: :not_found
    end


    ##
    # Cria um novo formulário.
    #
    # Parâmetros:: os atributos do formulário, na requisição.
    #
    # Retorno:: renderiza um JSON com o formulário criado.
    # - Se os atributos do formulário forem inválidos, renderiza um JSON com erro 400.

    def create
        @formulario = Formulario.new(formulario_params)
        formulario.save!
        # render json: formulario, status: :created
    rescue StandardError => e
        render json: e, status: :bad_request
    end


    ##
    # Atualiza um formulário específico.
    #
    # Parâmetros:: o ID do formulário e os atributos a serem atualizados, passados pela requisição.
    #
    # Retorno:: redireciona para a lista de formulários.
    # - Se a atualização falhar, renderiza a view de edição e apresenta uma mensagem de erro com status 422.

    def update
        @formulario = Formulario.find(params[:id])
        if formulario.update!(formulario_params)
            redirect_to formularios_path, notice: "#{formulario.nome} updated."
        else
            flash.now[:alert] = "#{formulario.nome} could not be updated: " + formulario.errors.full_messages.join(", ")
            render 'edit', status: :unprocessable_entity
            # render json: formulario, status: :ok
        end
    end


    ##
    # Deleta um formulário específico.
    #
    # Parâmetros:: o ID do formulário, passado pela rota.
    #
    # Retorno:: se o formulário não for encontrado, renderiza um JSON com erro 404.

    def delete
        @formulario = Formulario.find(params[:id])
        formulario.destroy!
        # render json: { message: "Formulario deleted." }, status: :ok
    rescue StandardError => e
        render json: e, status: :not_found
    end


    ##
    # Não utilizado:: esse método cria uma nova instância de Formulário, mas não a salva no banco de dados.

    def new
        @formularios = Formulario.new
    end


    ##
    # Gera uma arquivo CSV com todos os formulários.
    #
    # Retorno:: um arquivo CSV com todos os formulários.
    # - Se não for possível gerar o arquivo, renderiza um JSON com erro 500.

    def export_csv
        @formularios = Formulario.all

        respond_to do |format|
          format.csv { send_data generate_csv(@formularios), filename: "formularios-#{Date.today}.csv" }
        end
    end

    private

    def formulario_params
        params.require(:formulario).permit(:nome, :turma_id, :template_id)
    end

    def generate_csv(formularios)
        CSV.generate(headers: true) do |csv|
          csv << ['ID', 'Nome', 'Descrição', 'Criado em', 'Atualizado em']

          formularios.each do |formulario|
            csv << [formulario.id, formulario.nome, formulario.descricao, formulario.created_at, formulario.updated_at]
          end
    end
end
end
