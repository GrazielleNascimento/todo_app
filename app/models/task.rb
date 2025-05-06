class Task < ApplicationRecord
  # Associações
  belongs_to :project
  
  # Validações
  validates :title, presence: { message: "O título não pode ficar em branco" }
  validates :title, length: { maximum: 100, message: "O título deve ter no máximo 100 caracteres" }
  
  # Escopos (para facilitar consultas)
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :recent, -> { order(created_at: :desc) }
  
  # Valor padrão para o campo completed
  attribute :completed, :boolean, default: false
end