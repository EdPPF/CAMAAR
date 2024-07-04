##
# Responsável por controlar as requisições referentes a User.

class UsersController < ApplicationController

  ##
  # Lista todos os usuários cadastrados no sistema.
  #
  # Retorno:: renderiza um JSON com todos os usuários e status 200.

  def index
    users = User.all
    render json: array_serializer(users), status: :ok
#  rescue StandardError => e
#      render json: e, status: :not_found
  end


  ##
  # Mostra um usuário específico.
  #
  # Parâmetros::
  # id: int - o id do usuário a ser mostrado.
  #
  # Retorno:: renderiza um JSON com o usuário e status 200.
  # - Se o usuário não existir, renderiza um JSON com a mensagem de erro e status 404.

  def show
    user = User.find(params[:id])
    render json: serializer(user), status: :ok
  rescue StandardError => e
    render json: e, status: :not_found
  end


  ##
  # Cria novos usuários a partir de um arquivo JSON.
  #
  # Parâmetros::
  # file: JSON - o arquivo JSON com os dados dos usuários a serem importados.
  #
  # Retorno:: redireciona para a página de formulários com uma mensagem de sucesso ou erro.

  def create
    if params[:file].present?
      file = params[:file].read
      class_members = JSON.parse(file, symbolize_names: true) rescue nil
      if class_members.present?
        begin
          import_users(class_members)
          flash[:notice] = "Dados de usuários importados com sucesso!"
          redirect_to new_formulario_path, :notice => flash[:notice]
        rescue StandardError => e
          flash[:alert] = "Erro ao importar dados de usuários: #{e.message}"
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

#   def update
#       user = User.find(params[:id])
#       user.update!(user_params)
#       render json: user, status: :ok
#   rescue StandardError => e
#       render json: e, status: :bad_request
#   end


  ##
  # Deleta um usuário específico.
  #
  # Parâmetros::
  # id: int - o id do usuário a ser deletado.
  #
  # Retorno:: renderiza um JSON com a mensagem de sucesso e status 200.
  # - Se o usuário não existir, renderiza um JSON com a mensagem de erro e status 404.

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

  def import_users(class_members_data_array)
    class_members_data_array.each do |materia_data|
      materia = Materia.find_or_create_by!(codigo: materia_data[:code])
      turma = materia.turmas.find_or_create_by!(
        codigo: materia_data[:classCode],
        semestre: materia_data[:semester],
        horario: materia_data[:time]
      )

      # Import dicentes (students)
      materia_data[:dicente].each do |dicente_data|
        user = find_or_create_user(dicente_data)
        associate_user_with_turma(user, turma)
      end

      # Import docente (teacher)
      user_docente = find_or_create_user(materia_data[:docente], :user)
      # Associate user (docente) with turma through matricula
      associate_user_with_turma(user_docente, turma)
    end
  end

  def find_or_create_user(user_data, role = :user)
    user = User.find_by(
      nome: user_data[:nome],
      email: user_data[:email],
      matricula: user_data[:matricula] || user_data[:usuario]
    )
    if user.blank?
      password_length = 6
      password = Devise.friendly_token.first(password_length)
      user = User.create!(
        nome: user_data[:nome],
        email: user_data[:email],
        matricula: user_data[:matricula] || user_data[:usuario],
        password: password, password_confirmation: password,
        curso: user_data[:curso],
        formacao: user_data[:formacao],
        ocupacao: user_data[:ocupacao],
        role: role
      )
      # UserMailer.welcome_email(user, password).deliver_now!
    else
      user.update(
        curso: user_data[:curso],
        formacao: user_data[:formacao],
        ocupacao: user_data[:ocupacao],
        role: role
      )
    end
    user
  end

  def associate_user_with_turma(user, turma)
    Matricula.find_or_create_by!(user: user, turma: turma)
  end
end
