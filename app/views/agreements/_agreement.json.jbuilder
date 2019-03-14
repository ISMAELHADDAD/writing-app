json.extract! agreement, :id, :content
json.isAccepted agreement.is_accepted
json.isAgree agreement.is_agree
json.proposedByAvatarId agreement.avatar.id
json.proposedByAvatarName agreement.avatar.name
