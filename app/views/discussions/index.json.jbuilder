json.discussions @discussions do |discussion|
  json.id discussion.id
  json.topicTitle discussion.topic_title
  json.owner do
    json.id discussion.user.id
    json.name discussion.user.name
  end
end

json.pages do
  json.current @discussions.current_page
  json.total @discussions.total_pages
end
