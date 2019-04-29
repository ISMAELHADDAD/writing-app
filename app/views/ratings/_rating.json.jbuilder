json.extract! rating, :id, :rating
json.criterium do
  json.id rating.criterium.id
  json.text rating.criterium.text
end
