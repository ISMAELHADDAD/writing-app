json.discussions @discussions do |discussion|
  json.id discussion.id
  json.topicTitle discussion.topic_title
  json.ownerUserId discussion.user.id
  json.ownerUserName discussion.user.name
end
