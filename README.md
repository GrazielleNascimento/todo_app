# To-Do List App

Uma aplicação completa de lista de tarefas desenvolvida com Ruby on Rails. Esta aplicação permite que os usuários gerenciem projetos e tarefas de forma eficiente, com uma interface moderna e responsiva.

## Funcionalidades

- Criação, visualização, edição e exclusão de projetos
- Adição de múltiplas tarefas a cada projeto
- Marcação de tarefas como concluídas/pendentes
- Filtragem de tarefas por status (todas, pendentes, concluídas)
- Atualizações dinâmicas com AJAX (sem recarregar a página)
- Interface responsiva e moderna com Tailwind CSS
- Tratamento de erros e validações


## Tecnologias Utilizadas

- **Ruby on Rails**: Framework web para desenvolvimento rápido
- **MySQL**: Banco de dados relacional
- **Tailwind CSS**: Framework CSS para estilização moderna
- **Turbo Drive**: Para navegação rápida sem recarregar páginas
- **Font Awesome**: Para ícones
- **JavaScript/AJAX**: Para interações dinâmicas

## Estrutura do Projeto

### Modelos

1. **Project**: Representa um projeto ou lista de tarefas
   - Atributos: title, timestamps
   - Associações: has_many :tasks

2. **Task**: Representa uma tarefa individual
   - Atributos: title, description, completed, project_id, timestamps
   - Associações: belongs_to :project

### Controladores

1. **ProjectsController**: Gerencia operações CRUD para projetos
2. **TasksController**: Gerencia operações CRUD para tarefas, incluindo alternar status

### Views

1. **Layouts**: Define a estrutura geral da aplicação com Tailwind CSS
2. **Views de Projetos**: Templates para exibir, criar e editar projetos
3. **Views de Tarefas**: Templates para renderizar tarefas individuais

## Instalação e Configuração

### Pré-requisitos

- Ruby 3.0.0 ou superior
- Rails 7.0.0 ou superior
- MySQL 5.7 ou superior
- Node.js e Yarn para assets

### Passos para Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/todo-app.git
   cd todo-app
   ```

2. Instale as dependências:
   ```bash
   bundle install
   yarn install
   ```

3. Configure o banco de dados:
   ```bash
   cp config/database.yml.example config/database.yml
   # Edite config/database.yml com suas credenciais MySQL
   ```

4. Configure as variáveis de ambiente:
   ```bash
   cp .env.example .env
   # Edite .env com suas configurações
   ```

5. Prepare o banco de dados:
   ```bash
   rails db:create
   rails db:migrate
   ```

6. Inicie o servidor:
   ```bash
   rails server
   ```

7. Acesse a aplicação em `http://localhost:3000`

## Uso da Aplicação

1. **Página Inicial**: Exibe todos os seus projetos e permite criar novos
2. **Página do Projeto**: Mostra as tarefas de um projeto específico
3. **Adição de Tarefas**: Use o formulário na página do projeto para adicionar tarefas
4. **Gerenciamento de Tarefas**: Marque as tarefas como concluídas clicando no círculo

## 📡 API Endpoints

- **GET /** - Lista todos os projetos
- **POST /projects** - Cria um novo projeto
- **GET /projects/:id** - Mostra um projeto específico
- **PATCH /projects/:id** - Atualiza um projeto
- **DELETE /projects/:id** - Remove um projeto
- **POST /projects/:project_id/tasks** - Cria uma tarefa
- **POST /projects/:project_id/batch_tasks** - Cria múltiplas tarefas
- **PATCH /tasks/:id/toggle_status** - Alterna status de uma tarefa
- **GET /health** - Rota de saúde da aplicação

## 📝 Estrutura do Projeto

app/
├── controllers/
│   ├── application_controller.rb
│   ├── projects_controller.rb
│   └── tasks_controller.rb
├── models/
│   ├── project.rb
│   └── task.rb
├── views/
│   ├── layouts/
│   │   └── application.html.erb
│   ├── projects/
│   │   ├── index.html.erb
│   │   ├── show.html.erb
│   │   ├── edit.html.erb
│   │   └── _project_card.html.erb
│   └── tasks/
│       ├── edit.html.erb
│       ├── _task.html.erb
│       └── (arquivos .js.erb para Turbo)
├── assets/
│   └── stylesheets/
│       ├── application.tailwind.css
│       └── custom.css
└── javascript/
    └── application.js