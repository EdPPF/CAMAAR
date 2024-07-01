##
# Responsável por controlar as requisições referentes a User.

class UsersController < ApplicationController

  ##
  # Lista todos os usuários cadastrados no sistema.
  #
  # Retorno:: renderiza um JSON com todos os usuários e status HTTP 200 (OK).
  # - Se não houver usuários cadastrados, renderiza um JSON vazio e status HTTP 404 (Not Found).

  def index
      users = User.all
      render json: array_serializer(users), status: :ok
  rescue StandardError => e
      render json: e, status: :not_found
  end

  ##
  # Mostra um usuário específico.
  #
  # Parâmetros:: o ID do usuário, passado pela rota.
  #
  # Retorno:: renderiza um JSON com o usuário e status HTTP 200 (OK).
  # - Se o usuário não for encontrado, renderiza um JSON vazio e status HTTP 404 (Not Found).

  def show
      user = User.find(params[:id])
      render json: serializer(user), status: :ok
  rescue StandardError => e
      render json: e, status: :not_found
  end

  ##
  # Cria um novo usuário.
  #
  # Parâmetros:: os atributos do usuário, na requisição.
  #
  # Retorno:: renderiza um JSON com o usuário criado e status HTTP 201 (Created).
  # - Se os atributos do usuário forem inválidos, renderiza um JSON com o erro e status HTTP 422 (Unprocessable Entity).

  def create
      user = User.new(user_params)
      puts user_params
      user.save!
      render json: user, status: :created
  rescue StandardError => e
      render json: e, status: :unprocessable_entity
  end

  ##
  # Atualiza um usuário existente.
  #
  # Parâmetros:: os atributos do usuário, na requisição.
  #
  # Retorno:: renderiza um JSON com o usuário atualizado e status HTTP 200 (OK).
  # - Se o usuário não for encontrado, renderiza um JSON vazio e status HTTP 404 (Not Found).

  def update
      user = User.find(params[:id])
      user.update!(user_params)
      render json: user, status: :ok
  rescue StandardError => e
      render json: e, status: :bad_request
  end

  ##
  # Deleta um usuário existente.
  #
  # Parâmetros:: o ID do usuário, passado pela rota.
  #
  # Retorno:: renderiza um JSON com o usuário deletado e status HTTP 200 (OK).
  # - Se o usuário não for encontrado, renderiza um JSON vazio e status HTTP 404 (Not Found).

  def delete
      user = User.find(params[:id])
      user.destroy!
      render json: user, status: :ok
  rescue StandardError => e
      render json: e, status: :not_found
  end

  private

  # def login_params
  #     params.require(:user).permit(:email, :password)
  # end

  def user_params
    params.require(:user).permit(:nome, :email, :password, :curso, :matricula, :formacao, :ocupacao)
  end

  def serializer(user)
    UserSerializer.new.serialize_to_json(user)
  end

  def array_serializer(users)
    Panko::ArraySerializer.new(users, each_serializer: UserSerializer).to_json
  end
end
