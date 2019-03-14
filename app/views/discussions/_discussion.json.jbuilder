json.id discussion.id
json.topicTitle discussion.topic_title
json.topicDescription discussion.topic_description
json.ownerUserId discussion.user.id

json.arguments discussion.arguments.each do |argument|
  json.extract! argument, :id, :num, :content
  json.publishTime argument.publish_time
  json.fromAvatarId argument.avatar.id
  json.fromAvatarName argument.avatar.name
end

json.agreements discussion.agreements.each do |agreement|
  json.extract! agreement, :id, :content
  json.isAccepted agreement.is_accepted
  json.isAgree agreement.is_agree
  json.proposedByAvatarId agreement.avatar.id
  json.proposedByAvatarName agreement.avatar.name
end

json.avatarOne do
  json.extract! discussion.avatars.first, :id, :name, :opinion
  json.assignedToUserId discussion.avatars.first.user.id
end

json.avatarTwo do
  json.extract! discussion.avatars.second, :id, :name, :opinion
  json.assignedToUserId discussion.avatars.second.user.id
end

json.participants discussion.participants.collect { |par| par.user_id }
