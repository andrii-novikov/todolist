# frozen_string_literal: true
json.(comment, :id, :text, :created_at)
if comment.attachment.url
  json.attachment do
    json.(comment.attachment, :url, :filename)
  end
end
