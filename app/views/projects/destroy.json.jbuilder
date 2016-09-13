# frozen_string_literal: true
json.msg @project.destroyed? ? 'Ok' : @project.errors.full_messages
