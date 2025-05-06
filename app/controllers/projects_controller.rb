class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  
  # GET /projects - Lista todos os projetos com suas tarefas
  def index
    @projects = Project.includes(:tasks).all
    @project = Project.new # Para o formulário de novo projeto
  
    respond_to do |format|
      format.html # Renderiza a view show.html.erb
      format.json { 
        # Apenas inclui tarefas persistidas (que têm ID)
        render json: @projects.as_json(include: { tasks: { only: [:id, :title, :description, :completed, :created_at, :updated_at] } })
      }
    end
  end
  
  # GET /projects/:id - Mostra um projeto específico
  def show
    @task = @project.tasks.new # Para o formulário de nova tarefa
    
    respond_to do |format|
      format.html # Renderiza a view show.html.erb
      format.json { render json: @project.to_json(include: :tasks) }
    end
  end
  
  # GET /projects/new - Formulário para novo projeto
  def new
    @project = Project.new
    
    respond_to do |format|
      format.html # Renderiza a view new.html.erb
      format.json { render json: @project }
    end
  end
  
  # GET /projects/:id/edit - Formulário para editar projeto
  def edit
    respond_to do |format|
      format.html # Renderiza a view edit.html.erb
      format.json { render json: @project }
    end
  end
  
  # POST /projects - Cria um novo projeto
  def create
    @project = Project.new(project_params)
    
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Projeto criado com sucesso!' }
        format.json { render json: @project.to_json(include: :tasks), status: :created }
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  # PATCH/PUT /projects/:id - Atualiza um projeto existente
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project), notice: 'Projeto atualizado com sucesso!' }
        format.json { render json: @project.to_json(include: :tasks), status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /projects/:id - Remove um projeto
  def destroy
    @project.destroy
    
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Projeto removido com sucesso!' }
      format.json { head :no_content }
      format.js
    end
  end
  
  private
  
  # Define o projeto baseado no parâmetro id
  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        flash[:alert] = "Projeto não encontrado."
        redirect_to projects_path
      end
      format.json { render json: { error: "Projeto não encontrado" }, status: :not_found }
    end
  end
  
  # Parâmetros permitidos para o projeto
  def project_params
    params.require(:project).permit(:title)
  end
end