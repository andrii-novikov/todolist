if task.errors.any?
  json.msg task.errors.full_messages.join('\n')
else
  json.(task, :id, :title, :done, :deadline, :status, :order, :created_at)
  json.comments task.comments, partial: 'comments/comment', as: :comment
end
