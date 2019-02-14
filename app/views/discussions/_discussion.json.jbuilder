json.extract! discussion, :id, :topicTitle, :topicDescription
json.ownerID discussion.user.id

json.arguments discussion.arguments.each do |argument|
  json.extract! argument, :num, :content, :publish_time
  json.from argument.avatar.name
end

json.agreements discussion.agreements.each do |agreement|
  json.extract! agreement, :content, :isAccepted, :isAgree
  json.proposed_by agreement.avatar.name
end

json.avatars discussion.avatars.each do |avatar|
  json.extract! avatar, :name, :opinion
  json.assigned_to avatar.user.id
end
