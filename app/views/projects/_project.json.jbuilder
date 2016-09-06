json.(project, :id, :title)
json.tasks project.tasks, partial: 'tasks/task', as: :task

