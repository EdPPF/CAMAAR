require 'csv'

##
# Responsável por controlar as ações CRUD de Formulários

class FormulariosController < ApplicationController

    ##
    # Lista todos os formulários.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: retorna um JSON com todos os formulários.

    def index
        formularios = Formulario.all
        respond_with_formulario(formularios)
    end


    ##
    # Mostra um formulário específico.
    #
    # Parâmetros::
    # id: int - o id do formulário a ser mostrado.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: retorna um JSON com o formulário.
    # - Se o formulário não for encontrado, renderiza um JSON com erro 404.

    def show
        formulario = find_formulario
         # render json: formulario, status: :ok
        respond_with_formulario(formulario)
    rescue StandardError => e
        render json: e, status: :not_found
    end


    ##
    # Cria um novo formulário.
    #
    # Parâmetros::
    # formulario: Hash - os atributos do formulário a ser criado.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: redireciona para a página de formulários e mostra uma mensagem de sucesso.
    # - JSON: retorna um JSON com o formulário criado.
    # - Se os atributos do formulário forem inválidos, renderiza um JSON com erro 400

    def create
        @formulario = Formulario.new(formulario_params)
        @formulario.save!
        respond_to do |format|
            format.html { redirect_to new_formulario_path, notice: "#{@formulario.nome} created."}
            format.json { render json: @formulario, status: :created }
        end
    rescue StandardError => e
        render json: e, status: :bad_request
    end


    ##
    # Atualiza um formulário específico.
    #
    # Parâmetros::
    # id: int - o id do formulário a ser atualizado.
    # formulario: Hash - os atributos do formulário a ser atualizado.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: redireciona para a página de formulários e mostra uma mensagem de sucesso.
    # - JSON: retorna um JSON com o formulário atualizado.
    # - Se os atributos do formulário forem inválidos, renderiza um JSON com erro 400

    def update
        formulario = find_formulario
        if formulario.update(formulario_params)
            handle_success(formulario)
        else
            handle_failure(formulario)
        end
    end


    ##
    # Deleta um formulário específico.
    #
    # Parâmetros::
    # id: int - o id do formulário a ser deletado.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: redireciona para a página de formulários e mostra uma mensagem de sucesso.
    # - JSON: retorna um JSON com uma mensagem de sucesso.
    # - Se o formulário não for encontrado, renderiza um JSON com erro 404.

    def destroy
        formulario = find_formulario
        formulario.destroy!
        # render json: { message: "Formulario deleted." }, status: :ok
        respond_with_formulario(formulario)
    rescue StandardError => e
        render json: e, status: :not_found
    end


    ##
    # Renderiza a view de criação de formulários.

    def new
        @formularios = Formulario.new
    end


    ##
    # Renderiza a view de edição de um formulário específico.

    def send_form
        # idealmente, o que está nesse método era para estar no formulario#new, mas esse método já está renderizando uma view diferente, então decidi criar um método novo
        @formulario = Formulario.new
        @turmas = Turma.includes(:materia).all();
        @templates = Template.all();
    end

    def resultados
        @formularios = Formulario.all
    end

    def responder
        @formulario = Formulario.find(params[:id])
        @template = @formulario.template
        @questaos = @template.questaos
    end

    def show_pending
        if current_user
            @formularios = Formulario.where.not(id: current_user.formularios.select(:id))
        else
            redirect_to formularios_path, notice: "Um erro ocorreu"
        end
    end

  
    ##
    # Exporta os formulários para um arquivo CSV.
    #
    # Retorno:: um arquivo CSV com todos os formulários.
    # - Se não for possível gerar o arquivo, renderiza um JSON com erro 500.
  
    def export_csv
        formulario = Formulario.find(params[:id])
        respond_to do |format|
          format.csv { send_data generate_csv(formulario), filename: "formularios-#{Date.today}.csv" }
        end
    end

    private

    def formulario_params
        params.require(:formulario).permit(:nome, :turma_id, :template_id)
    end

    def generate_csv(formulario)
      template = formulario.template
      questaos = template.questaos
      respostas = formulario.respostas
      if (respostas.empty? || questaos.empty?)
        return "Formulario sem respostas"
      else
        CSV.generate(headers: true) do |csv|
          headers = questaos.pluck(:texto)
          csv << headers
          respostas = respostas.group_by(&:questao_id)

          max_respostas_count = respostas.values.map(&:size).max

          (0...max_respostas_count).each do |index|
            row = []
            questaos.each do |questao|
              respostas_questao = respostas[questao.id] || []
              resposta = respostas_questao[index]
              row << (resposta ? resposta.texto : "")
            end
            csv << row
          end
        end

      end
    end

    def find_formulario
        Formulario.find(params[:id])
    end

    def respond_with_formulario(formulario, status: :ok)
        respond_to do |format|
            format.html
            format.json { render json: formulario, status: status}
        end
    end

    # Similar ao respond_with_formulario, mas com a diferença de que ele redireciona para a página de formularios
    def handle_success(formulario)
        respond_to do |format|
            format.html { redirect_to formularios_path, notice: "#{formulario.nome} updated." }
            format.json { render json: formulario, status: :ok }
        end
    end

    def handle_failure(formulario)
        flash.now[:alert] = "#{formulario.nome} could not be updated: " + formulario.errors.full_messages.join(", ")
        render 'edit', status: :bad_request
    end
end
