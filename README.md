# Discussion App API [![Build Status](https://travis-ci.org/ISMAELHADDAD/writing-app-backend-api.svg?branch=master)](https://travis-ci.org/ISMAELHADDAD/writing-app-backend-api)

A REST API for a discussion app which allows you to organize your ideas in a discussion format and compiles them in a library.

## Features

- Create and delete discussions.
- Add arguments in the discussion in real time.
- Propose agreements and disagreements in the discussion in real time.
- Accept or reject a proposed agreement in real time.
- Invite people to participate through email in real time.
- Assign avatars to users participating in the discussion in real time.
- View list of public and private discussions.
- Fork an existing discussion.
- Make a comment on a specific discussion.
- Define criteria to a discussion.
- Rate an avatar according to the criteria of a discussion.

## API Documentation
Auth | Method | Url | Params | Description
--- | --- | --- | --- | --- |
No | GET | `/discussions/:id` | `id` | Get discussion with specific id. |
No | GET | `/users/:id` | `id` | Get user with specific id.|
Yes | POST | `/discussions/:discussion_id/arguments` | `discussion_id`, `avatar_id`, `content` | Send an argument in a specific discussion. |
Yes | POST | `/discussions/:discussion_id/agreements` | `discussion_id`, `avatar_id`, `content`, `is_agree` | Propose an agreement if `is_agree = true` or disagreement if `is_agree = false` in a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/agreements` `/:agreement_id` | `discussion_id`, `avatar_id`, `is_accepted` | Accept an agreement if `is_accepted = true` or reject if `is_accepted = false` in a specific discussion. |
No | POST | `/tokensignin` | `id_token` | Verify Google token id. |
Yes | POST | `/discussions/:discussion_id/invite` | `discussion_id`, `email` | Send an email invitation to participate in a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/verify_invitation` | `discussion_id`, `token` | Verify if invitation is valid to participate in a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/avatar/:avatar_id` | `discussion_id`, `avatar_id`, `user_id` | Assign user an avatar in a specific discussion. |
Yes | POST | `/discussions/` | `topic_title`, `topic_description`, `name_avatar_one`, `opinion_avatar_one`, `name_avatar_two`, `opinion_avatar_two` | Create new discussion. |
Yes | DELETE | `/discussions/:id` | `:id` | Delete a specific discussion. |
No | GET | `/discussions?page=[:page]&user_id=[:user_id]` | `page`, `user_id` | Get public discussions. |
Yes | PUT | `/discussions/:discussion_id/fork` | `discussion_id` | Fork a specific discussion. |
No | GET | `/discussions/:discussion_id/general_comments` | `discussion_id` | Get comments from a specific discussion. |
Yes | POST | `/discussions/:discussion_id/general_comments` | `discussion_id`, `text` | Post a comment into a specific discussion. |
No | GET | `/discussions/:discussion_id/criteria` | `discussion_id` | Get the criteria of a specific discussion. |
Yes | POST | `/discussions/:discussion_id/criteria` | `discussion_id`, `text` | Add a criteria for a specific discussion. |
No | GET | `/discussions/:discussion_id/avatar/:avatar_id` `/ratings` | `discussion_id` | Get the ratings for a specific avatar from a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/avatar/:avatar_id` `/ratings/:rating_id` | `discussion_id`, `rating` | Set a rating for a specific avatar from a specific discussion. |
## Installing for development, testing, and deploy
#### Ruby version: 2.5.1
#### Rails version: 5.2.2
Install gems:

```bash
$ bundle install --without production
```
Run development server:

```bash
$ rails s
```
Run tests:

```bash
$ rails test
```

Deployment to Heroku:

- You need to set up the addon Redis in order to be able to connect the WebSockets. You need to set the env variable `REDISTOGO_URL` (more info on: [Heroku-RedisToGo Article](https://devcenter.heroku.com/articles/redistogo)).

- You need to set up the addon SendGrid in order to be able to send invitation emails. You need to set the env variables `SENDGRID_USERNAME` and `SENDGRID_PASSWORD` (more info on: [Heroku-SendGrid Article](https://devcenter.heroku.com/articles/sendgrid)).

- If you want to set up `.travis.yml` in the root project for continuos integration, run this to create and add automtically the secrete api key of heroku to travis (more info on: [Travis Heroku Deployment](https://docs.travis-ci.com/user/deployment/heroku/)):

```bash
$ travis encrypt $(heroku auth:token) --add deploy.api_key
```
