json.discussions @discussions do |discussion|
  json.id discussion.id
  json.topicTitle discussion.topic_title
  json.topicDescription discussion.topic_description
  json.publishTime discussion.created_at
  json.forkedFrom discussion.forked_from
  json.private discussion.private
  json.owner do
    json.id discussion.user.id
    json.name discussion.user.name
    json.imageUrl discussion.user.image_url
  end
end

json.pages do
  json.current @discussions.current_page
  json.total @discussions.total_pages
end
