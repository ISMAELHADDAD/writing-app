json.discussions @discussions do |discussion|
  json.id discussion.id
  json.topicTitle discussion.topic_title
  json.owner do
    json.id discussion.user.id
    json.name discussion.user.name
  end
end
