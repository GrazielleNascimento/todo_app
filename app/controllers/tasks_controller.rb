class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_status]
  before_action :set_project, only: [:create, :new]
  
   # GET /tasks - Lista todas as tarefas
   def index
    @tasks = Task.includes(:project).all
    
    respond_to do |format|
      format.html # Renderiza a view index.html.erb
      format.json { render json: @tasks.to_json(include: :project) }
    end
  end

  # POST /projects/:project_id/batch_tasks - Cria várias tarefas de uma vez
  def batch_create
    @project = Project.find(params[:project_id])
    @tasks = []
  
    params[:tasks].each do |task_params|
      @tasks << @project.tasks.create(task_params.permit(:title, :description, :completed))
    end
  
    render json: @tasks, status: :created
  end
  
  
  # GET /tasks/:id - Mostra uma tarefa específica (adicionei este método)
  def show
    respond_to do |format|
      format.html { redirect_to project_path(@task.project) }
      format.json { render json: @task }
    end
  end
  
  # GET /projects/:project_id/tasks/new - Formulário para nova tarefa
  def new
    @task = @project.tasks.new
    
    respond_to do |format|
      format.html # Renderiza a view new.html.erb
      format.json { render json: @task }
    end
  end
  
  # POST /projects/:project_id/tasks - Cria uma nova tarefa
  def create
    @task = @project.tasks.new(task_params)
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_path(@project), notice: 'Tarefa criada com sucesso!' }
        format.json { render json: @task, status: :created }
        format.js
      else
        format.html { redirect_to project_path(@project), alert: @task.errors.full_messages.join(', ') }
        format.json { render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end
  
  # GET /tasks/:id/edit - Formulário para editar tarefa
  def edit
    respond_to do |format|
      format.html # Renderiza a view edit.html.erb
      format.json { render json: @task }
    end
  end
  
  # PATCH/PUT /tasks/:id - Atualiza uma tarefa existente
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_path(@task.project), notice: 'Tarefa atualizada com sucesso!' }
        format.json { render json: @task, status: :ok }
        format.js
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end
  
  # DELETE /tasks/:id - Remove uma tarefa
  def destroy
    project = @task.project
    @task.destroy
    
    respond_to do |format|
      format.html { redirect_to project_path(project), notice: 'Tarefa removida com sucesso!' }
      format.json { head :no_content }
      format.js
    end
  end
  
  # PATCH /tasks/:id/toggle_status - Alterna o status da tarefa (completa/incompleta)
  def toggle_status
    @task.update(completed: !@task.completed)
    
    respond_to do |format|
      format.html { redirect_to project_path(@task.project) }
      format.json { render json: @task }
      format.js
    end
  end
  
  private
  
  # Define a tarefa baseado no parâmetro id
  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        flash[:alert] = "Tarefa não encontrada."
        redirect_to projects_path
      end
      format.json { render json: { error: "Tarefa não encontrada" }, status: :not_found }
    end
  end
  
  # Define o projeto baseado no parâmetro project_id
  def set_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html do
        flash[:alert] = "Projeto não encontrado."
        redirect_to projects_path
      end
      format.json { render json: { error: "Projeto não encontrado" }, status: :not_found }
    end
  end
  
  # Parâmetros permitidos para a tarefa
  def task_params
    params.require(:task).permit(:title, :description, :completed)
  end
end

