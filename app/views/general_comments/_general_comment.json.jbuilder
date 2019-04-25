json.extract! general_comment, :id, :text
json.date general_comment.created_at
json.user do
  json.id general_comment.user.id
  json.name general_comment.user.name
  json.imageUrl general_comment.user.image_url
end
