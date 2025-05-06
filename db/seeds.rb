# Criar alguns projetos de exemplo
projects = [
  {title: 'Tarefas Pessoais'},
  {title: 'Tarefas de Trabalho'},
  {title: 'Compras'}
]

projects.each do |project_attrs|
  project = Project.find_or_create_by!(project_attrs)
  
  # Adicionar algumas tarefas ao projeto
  if project.title == 'Tarefas Pessoais'
    project.tasks.find_or_create_by!(title: 'Exercícios', description: 'Fazer 30 minutos de exercícios')
    project.tasks.find_or_create_by!(title: 'Ler livro', description: 'Ler pelo menos 20 páginas')
    project.tasks.find_or_create_by!(title: 'Meditar', description: 'Meditar por 10 minutos')
  elsif project.title == 'Tarefas de Trabalho'
    project.tasks.find_or_create_by!(title: 'Reunião com equipe', description: 'Discutir próximos passos do projeto')
    project.tasks.find_or_create_by!(title: 'Enviar relatório', description: 'Preparar e enviar relatório semanal')
    project.tasks.find_or_create_by!(title: 'Responder emails', description: 'Limpar caixa de entrada')
  elsif project.title == 'Compras'
    project.tasks.find_or_create_by!(title: 'Frutas e legumes', description: 'Maçã, banana, alface, tomate')
    project.tasks.find_or_create_by!(title: 'Itens de limpeza', description: 'Detergente, sabão em pó')
    project.tasks.find_or_create_by!(title: 'Padaria', description: 'Pão, queijo')
  end
end

puts "Seeds criados com sucesso!"