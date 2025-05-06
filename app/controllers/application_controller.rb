class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  # Método para tratar erros de forma elegante
  rescue_from StandardError do |exception|
    respond_to do |format|
      format.html do
        raise exception # Deixa o Rails lidar com a exceção para respostas HTML
      end
      format.json { render json: { error: exception.message }, status: :internal_server_error }
    end
  end
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    respond_to do |format|
      format.html do
        flash[:alert] = "O registro solicitado não foi encontrado."
        redirect_to root_path
      end
      format.json { render json: { error: "Registro não encontrado" }, status: :not_found }
    end
  end
end