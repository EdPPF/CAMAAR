class MateriasController < ApplicationController
    def index
        materias = Materia.all

        respond_to do |format|
            format.html
            format.json { render json: materias }
        end
    end

    def show
        materia = Materia.find(params[:id])

        respond_to do |format|
            format.html
            format.json { render json: materia }
        end
    end

    def create
        materia = Materia.new(materia_params)

        if materia.save
          redirect_to materias_path, notice: "#{materia.nome} created."
        else
          flash[:alert] = "Materia could not be created: " + materia.errors.full_messages.join(", ")
          render 'new', status: :unprocessable_entity
        end
    end

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
