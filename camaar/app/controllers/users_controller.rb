class UsersController < ApplicationController
  # def login
  #   user = User.find_by(email: login_params[:email])
  #   if user.valid_password?(login_params[:password])
  #       render json: user, status: :ok
  #   else
  #       head :unauthorized
  #   end
  # rescue StandardError => e
  #     head :unauthorized
  # end
  #
  def index
      users = User.all
      render json: array_serializer(users), status: :ok
#  rescue StandardError => e
#      render json: e, status: :not_found
  end

  def show
      user = User.find(params[:id])
      render json: serializer(user), status: :ok
  rescue StandardError => e
      render json: e, status: :not_found
  end


#   def create
#       user = User.new(user_params)
#       puts user_params
#       user.save!
#       render json: user, status: :created
#   rescue StandardError => e
#       render json: e, status: :unprocessable_entity
#   end

#   def update
#       user = User.find(params[:id])
#       user.update!(user_params)
#       render json: user, status: :ok
#   rescue StandardError => e
#       render json: e, status: :bad_request
#   end


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

#   def user_params
#     params.require(:user).permit(:nome, :email, :password, :curso, :matricula, :formacao, :ocupacao)
#   end

  def serializer(user)
    UserSerializer.new.serialize_to_json(user)
  end

  def array_serializer(users)
    Panko::ArraySerializer.new(users, each_serializer: UserSerializer).to_json
  end

  def generate_random_password(length = 6)
    SecureRandom.hex(length / 2).chars.map { |c| rand(2) == 0 ? c : c.chr }.join
  end


  def import_users(class_members_data_array)
    class_members_data_array.each do |materia_data|



      materia = Materia.find_or_create_by!(codigo: materia_data[:code])  # Search by code only



      turma = materia.turmas.find_or_create_by!(codigo: materia_data[:classCode],
                                                semestre: materia_data[:semester], horario: materia_data[:time])



      # Import dicentes (students)
      dicente_data_array = materia_data[:dicente]
      dicente_data_array.each do |dicente_data|
        user = User.find_by(nome: dicente_data[:nome], email: dicente_data[:email],
                            matricula: dicente_data[:matricula])
        if user.blank?
          password = generate_random_password
          user = User.create!(nome: dicente_data[:nome], email: dicente_data[:email],
                              matricula: dicente_data[:matricula], password: password,
                              curso: dicente_data[:curso],
                              formacao: dicente_data[:formacao], ocupacao: dicente_data[:ocupacao], role: :user)

          #UserMailer.welcome_email(user, password).deliver_now!
        else
          user.update!(curso: dicente_data[:curso], formacao: dicente_data[:formacao], ocupacao: dicente_data[:ocupacao], role: :user)
        end

        # Associate user with turma through matricula
        matricula = Matricula.find_or_create_by!(user: user, turma: turma)
      end

      # Import docente (teacher)
      docente_data = materia_data[:docente]
      user_docente = User.find_by(nome: docente_data[:nome], email: docente_data[:email],
                                  matricula: docente_data[:usuario])
      if user_docente.blank?
        password = generate_random_password
        user_docente = User.create!(nome: docente_data[:nome], email: docente_data[:email],
                                    matricula: docente_data[:usuario], password:password,
                                    formacao: docente_data[:formacao], ocupacao: docente_data[:ocupacao], role: :user)
      else
        user_docente.update!(formacao: docente_data[:formacao], ocupacao: docente_data[:ocupacao], role: :user)
      end
      # Associate user (docente) with turma through matricula
      matricula = Matricula.find_or_create_by!(user: user_docente, turma: turma)


    end

  end
end
