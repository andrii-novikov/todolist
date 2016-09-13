# frozen_string_literal: true
if @project.errors.any?
  json.msg @project.errors.full_messages.join('\n')
else
  json.partial! 'project', project: @project
end
