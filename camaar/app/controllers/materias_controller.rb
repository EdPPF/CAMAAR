##
# Responsável por gerenciar as matérias cadastradas no sistema.

class MateriasController < ApplicationController

    ##
    # Lista todas as matérias.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: retorna um JSON com todas as matérias.

    def index
        materias = Materia.all

        respond_to do |format|
            format.html
            format.json { render json: materias }
        end
    end


    ##
    # Mostra uma matéria específica.
    #
    # Parâmetros::
    # id: int - o id da matéria a ser mostrada.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: retorna um JSON com a matéria.

    def show
        materia = Materia.find(params[:id])

        respond_to do |format|
            format.html
            format.json { render json: materia }
        end
    end


    ##
    # Renderiza a view de criação de uma nova matéria.

    def new
        @materia = Materia.new
    end


    ##
    # Renderiza a view de edição de uma matéria.

    def edit
        @materia = Materia.find(params[:id])
    end


    ##
    # Cria uma nova matéria.
    #
    # Parâmetros::
    # materia: Hash - os atributos da matéria a ser criada.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: redireciona para a página de matérias e mostra uma mensagem de sucesso.
    # - Se os atributos da matéria forem inválidos, renderiza um JSON com erro 422.

    def create
        materia = Materia.new(materia_params)

        if materia.save
          redirect_to materias_path, notice: "#{materia.nome} created."
        else
          flash[:alert] = "Materia could not be created: " + materia.errors.full_messages.join(", ")
          render 'new', status: :unprocessable_entity
        end
    end


    ##
    # Atualiza uma matéria específica.
    #
    # Parâmetros::
    # id: int - o id da matéria a ser atualizada.
    #
    # Retorno:: redireciona para a página de matérias e mostra uma mensagem de sucesso.
    # - Se os atributos da matéria forem inválidos, renderiza um JSON com erro 422.

    def update
        materia = Materia.find(params[:id])
        nome_materia = materia.nome
        if materia.update(materia_params)
            redirect_to materias_path, notice: "#{nome_materia} updated."
        else
            flash.now[:alert] = "#{nome_materia} could not be updated: " + materia.errors.full_messages.join(", ")
            render 'edit', status: :unprocessable_entity
        end
    end


    ##
    # Deleta uma matéria específica.
    #
    # Parâmetros::
    # id: int - o id da matéria a ser deletada.
    #
    # Retorno:: redireciona para a página de matérias e mostra uma mensagem de sucesso.

    def destroy
        materia = Materia.find(params[:id])
        materia.destroy
        redirect_to materias_path, :notice => "#{materia.nome} deleted."
    end

    private
    def materia_params
        params.require(:materia).permit(:codigo, :nome)
    end
end
