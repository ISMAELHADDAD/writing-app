json.extract! agreement, :id, :content
json.isAccepted agreement.is_accepted
json.isAgree agreement.is_agree
json.acceptedAt agreement.updated_at
json.proposedByAvatar do
  json.id agreement.avatar.id
  json.name agreement.avatar.name
end
