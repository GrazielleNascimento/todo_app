class Project < ApplicationRecord
  # Associações
  has_many :tasks, dependent: :destroy
  
  # Validações
  validates :title, presence: { message: "O título não pode ficar em branco" }
  validates :title, length: { maximum: 100, message: "O título deve ter no máximo 100 caracteres" }
  
  # Métodos personalizados
  
  # Retorna o número de tarefas completas
  def completed_tasks_count
    tasks.where(completed: true).count
  end
  
  # Retorna o número total de tarefas
  def total_tasks_count
    tasks.count
  end
  
  # Calcula a porcentagem de conclusão do projeto
  def completion_percentage
    return 0 if total_tasks_count.zero?
    (completed_tasks_count.to_f / total_tasks_count * 100).round
  end
end