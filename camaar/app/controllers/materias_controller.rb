##
# Responsável por gerenciar as matérias cadastradas no sistema.
class MateriasController < ApplicationController

    ##
    # Lista todas as matérias cadastradas no sistema.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: renderiza um JSON com todas as matérias.

    def index
        @materias = Materia.all

        respond_to do |format|
            format.html
            format.json { render json: @materias }
        end
    end


    ##
    # Mostra uma matéria específica.
    #
    # Parâmetros:: o ID da matéria, passado pela rota.
    #
    # Retorno:: depende do formato da requisição:
    # - HTML: renderiza a view associada.
    # - JSON: renderiza um JSON com a matéria.

    def show
        @materia = Materia.find(params[:id])

        respond_to do |format|
            format.html
            format.json { render json: @materia }
        end
    end


    ##
    # Não utilizada:: cria uma instância de matéria, mas não salva no banco de dados.

    def new
        @materia = Materia.new
    end


    ##
    # Cria uma nova matéria.
    #
    # Parâmetros:: os atributos da matéria, na requisição.
    #
    # Retorno:: redireciona para a lista de matérias, com uma mensagem de sucesso.
    # - Se os atributos da matéria forem inválidos, renderiza a view de criação, com uma mensagem de erro.

    def create
        @materia = Materia.new(materia_params)

        if @materia.save
          redirect_to materias_path, notice: "#{@materia.nome} created."
        else
          flash[:alert] = "Materia could not be created: " + @materia.errors.full_messages.join(", ")
          render 'new', status: :unprocessable_entity
        end
    end


    ##
    # Não utilizada:: procura por uma matéria específica para editar.

    def edit
        @materia = Materia.find params[:id]
        # TODO
    end


    ##
    # Atualiza uma matéria específica.
    #
    # Parâmetros:: o ID da matéria e os atributos a serem atualizados, passados pela requisição.
    #
    # Retorno:: redireciona para a lista de matérias, com uma mensagem de sucesso.
    # - Se a atualização falhar, renderiza a view de edição, com uma mensagem de erro.

    def update
        @materia = Materia.find(params[:id])
        if @materia.update(materia_params)
            redirect_to materias_path, notice: "#{@materia.nome} updated."
        else
            flash.now[:alert] = "#{@materia.nome} could not be updated: " + @materia.errors.full_messages.join(", ")
            render 'edit', status: :unprocessable_entity
        end
    end


    ##
    # Deleta uma matéria específica.
    #
    # Parâmetros:: o ID da matéria, passado pela rota.
    #
    # Retorno:: redireciona para a lista de matérias, com uma mensagem de sucesso.
    def destroy
        @materia = Materia.find(params[:id])
        @materia.destroy
        redirect_to materias_path, :notice => "#{@materia.nome} deleted."
    end

    private
    def materia_params
        params.require(:materia).permit(:codigo, :nome)
    end
end
