if @project.errors.any?
  json.array! @project.errors
else
  json.partial! 'project', project: @project
end
