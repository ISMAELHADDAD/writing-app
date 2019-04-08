json.extract! agreement, :id, :content
json.isAccepted agreement.is_accepted
json.isAgree agreement.is_agree
json.acceptedAt agreement.updated_at
json.proposedByAvatarId agreement.avatar.id
json.proposedByAvatarName agreement.avatar.name
