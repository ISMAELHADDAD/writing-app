json.extract! discussion, :id, :topicTitle, :topicDescription
json.owner_UserID discussion.user.id

json.arguments discussion.arguments.each do |argument|
  json.extract! argument, :id, :num, :content, :publish_time
  json.from_AvatarID argument.avatar.id
  json.from_AvatarName argument.avatar.name
end

json.agreements discussion.agreements.each do |agreement|
  json.extract! agreement, :id, :content, :isAccepted, :isAgree
  json.proposed_by_AvatarID agreement.avatar.id
  json.proposed_by_AvatarName agreement.avatar.name
end

json.avatarOne do
  json.extract! discussion.avatars.first, :id, :name, :opinion
  json.assigned_to_UserID discussion.avatars.first.user.id
end

json.avatarTwo do
  json.extract! discussion.avatars.second, :id, :name, :opinion
  json.assigned_to_UserID discussion.avatars.second.user.id
end
