# frozen_string_literal: true
json.msg @comment.destroyed? ? 'Ok' : @comment.errors.full_messages
