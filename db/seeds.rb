# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Argument.destroy_all
Agreement.destroy_all
Avatar.destroy_all
User.destroy_all
Discussion.destroy_all


user = User.create( name: 'user1234')

discussion = Discussion.create(topicTitle: 'Title',
                               topicDescription: 'Description',
                               user: user
                              )

Avatar.create( name: 'name1', opinion: 'opinion1', discussion: discussion, user: user )
Avatar.create( name: 'name2', opinion: 'opinion2', discussion: discussion, user: user )
Argument.create( num: 1, content: 'content', publish_time: DateTime.now, discussion: discussion, avatar: Avatar.first )
Argument.create( num: 2, content: 'content', publish_time: DateTime.now, discussion: discussion, avatar: Avatar.second )
Argument.create( num: 3, content: 'content', publish_time: DateTime.now, discussion: discussion, avatar: Avatar.first )
Agreement.create( content: 'content', isAccepted: true, isAgree: true, discussion: discussion, avatar: Avatar.first )

# avatars_to_create = [
#   [ 'name', 'opinion' ],
#   [ 'name2', 'opinion2' ]
# ]
# avatars_to_create.each do |name, opinion|
#   Avatar.create( name: name, opinion: opinion, discussion: discussion, user: user )
# end
#
# arguments_to_create = [
#   [ 1, 'content', DateTime.now ],
#   [ 2, 'content', DateTime.now ],
#   [ 3, 'content', DateTime.now ]
# ]
#
# arguments_to_create.each do |num, content, publish_time|
#   Argument.create( num: num, content: content, publish_time: publish_time, discussion: discussion, avatar: Avatar.first )
# end
#
# agreements_to_create = [
#   [ 'content', false, true ],
#   [ 'content', false, true ],
#   [ 'content', false, true ]
# ]
#
# agreements_to_create.each do |content, isAccepted, isAgree|
#   Agreement.create( content: content, isAccepted: isAccepted, isAgree: isAgree, discussion: discussion, avatar: Avatar.first )
# end
