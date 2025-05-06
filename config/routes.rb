Rails.application.routes.draw do
  # Define a rota raiz para o controlador de projetos
  root "projects#index"

  # Rotas para projetos e tarefas (nested resources)
  resources :projects do
    resources :tasks, only: [:create, :new]
  end

  post '/projects/:project_id/batch_tasks', to: 'tasks#batch_create'

  resources :tasks do
    member do
      patch :toggle_status # Rota customizada para alternar o status da tarefa
    end
  end

  # Rota de saúde para verificar se a aplicação está funcionando
  get '/health', to: proc { [200, {}, ['ok']] }
end
