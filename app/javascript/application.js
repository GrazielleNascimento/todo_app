import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
  // Inicializar filtros de tarefas
  initTaskFilters();
  
  // Configurar animações para mensagens flash
  setupFlashMessages();
  
  // Adicionar efeitos para checkboxes de tarefas
  setupTaskCheckboxes();
});

// Inicializar filtros de tarefas
function initTaskFilters() {
  const filters = document.querySelectorAll('.filter');
  if (!filters.length) return;
  
  const tasks = document.querySelectorAll('.task-item');
  
  filters.forEach(filter => {
    filter.addEventListener('click', function() {
      // Atualizar classes ativas
      filters.forEach(f => f.classList.remove('active'));
      this.classList.add('active');
      
      const filterValue = this.dataset.filter;
      
      // Filtrar tarefas
      tasks.forEach(task => {
        if (filterValue === 'all') {
          task.style.display = 'flex';
        } else if (filterValue === 'pending' && !task.classList.contains('task-completed')) {
          task.style.display = 'flex';
        } else if (filterValue === 'completed' && task.classList.contains('task-completed')) {
          task.style.display = 'flex';
        } else {
          task.style.display = 'none';
        }
      });
    });
  });
}

// Configurar mensagens flash
function setupFlashMessages() {
  const flashMessages = document.querySelectorAll('.alert');
  
  flashMessages.forEach(message => {
    // Adicionar botão de fechar
    const closeButton = message.querySelector('button');
    if (closeButton) {
      closeButton.addEventListener('click', () => {
        message.classList.add('fade-out');
        setTimeout(() => {
          message.remove();
        }, 300);
      });
    }
    
    // Auto-dismiss após 5 segundos
    setTimeout(() => {
      message.classList.add('fade-out');
      setTimeout(() => {
        message.remove();
      }, 300);
    }, 5000);
  });
}

// Configurar checkboxes de tarefas
function setupTaskCheckboxes() {
  const checkboxes = document.querySelectorAll('.task-checkbox');
  
  checkboxes.forEach(checkbox => {
    checkbox.addEventListener('click', () => {
      const task = checkbox.closest('.task-item');
      task.classList.toggle('task-completed');
      checkbox.classList.toggle('checked');
    });
  });
}

// Função para atualizar a barra de progresso
function updateProgressBar(completedCount, totalCount) {
  const percent = totalCount > 0 ? Math.round((completedCount / totalCount) * 100) : 0;
  
  // Atualizar texto de progresso
  const progressText = document.querySelector('.progress-container .flex span:first-child');
  if (progressText) {
    progressText.textContent = `${completedCount} de ${totalCount} tarefas completas`;
  }
  
  // Atualizar percentual
  const percentText = document.querySelector('.progress-container .flex span:last-child');
  if (percentText) {
    percentText.textContent = `${percent}%`;
  }
  
  // Atualizar barra de progresso
  const progressBar = document.querySelector('.progress-fill');
  if (progressBar) {
    progressBar.style.width = `${percent}%`;
  }
}

// Funções globais para serem usadas com Turbo
window.addNewTask = function(taskHtml, completedCount, totalCount) {
  const tasksList = document.getElementById('tasks-list');
  if (!tasksList) return;
  
  // Remover mensagem de "nenhuma tarefa" se existir
  const emptyMessage = tasksList.querySelector('.text-center');
  if (emptyMessage) {
    emptyMessage.remove();
  }
  
  // Adicionar nova tarefa com animação
  const tempDiv = document.createElement('div');
  tempDiv.innerHTML = taskHtml;
  const newTask = tempDiv.firstElementChild;
  newTask.classList.add('fade-in');
  
  tasksList.insertBefore(newTask, tasksList.firstChild);
  
  // Atualizar progresso
  updateProgressBar(completedCount, totalCount);
  
  // Inicializar eventos para a nova tarefa
  setupTaskCheckboxes();
};

window.removeTask = function(taskId, completedCount, totalCount) {
  const task = document.getElementById(`task-${taskId}`);
  if (!task) return;
  
  // Animar remoção
  task.classList.add('fade-out');
  
  setTimeout(() => {
    task.remove();
    
    // Adicionar mensagem de "nenhuma tarefa" se não houver mais tarefas
    const tasksList = document.getElementById('tasks-list');
    if (tasksList && tasksList.children.length === 0) {
      tasksList.innerHTML = `
        <div class="text-center py-6">
          <i class="fas fa-tasks text-3xl text-light-dark mb-4"></i>
          <p class="text-light-dark">Este projeto ainda não tem tarefas.</p>
        </div>
      `;
    }
    
    // Atualizar progresso
    updateProgressBar(completedCount, totalCount);
  }, 300);
};

window.updateTaskStatus = function(taskId, completed, completedCount, totalCount) {
  const task = document.getElementById(`task-${taskId}`);
  if (!task) return;
  
  // Atualizar classe
  if (completed) {
    task.classList.add('task-completed');
    // Selecionar apenas o checkbox dentro deste task específico
    const checkbox = task.querySelector('.task-checkbox');
    if (checkbox) {
      checkbox.classList.add('checked');
    }
  } else {
    task.classList.remove('task-completed');
    const checkbox = task.querySelector('.task-checkbox');
    if (checkbox) {
      checkbox.classList.remove('checked');
    }
  }
  
  // Atualizar progresso
  updateProgressBar(completedCount, totalCount);
};