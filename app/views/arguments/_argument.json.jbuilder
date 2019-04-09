json.extract! argument, :id, :num, :content
json.publishTime argument.publish_time
json.fromAvatar do
  json.id argument.avatar.id
  json.name argument.avatar.name
end
