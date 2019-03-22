# Discussion App API [![Build Status](https://travis-ci.org/ISMAELHADDAD/writing-app-backend-api.svg?branch=master)](https://travis-ci.org/ISMAELHADDAD/writing-app-backend-api)

A REST API for a discussion app which allows you to organize your ideas in a discussion format and compiles them in a library.

## Features

- Create and delete discussions.
- Add arguments in the discussion.
- Propose agreements and disagreements in the discussion.
- Accept or reject a proposed agreement.
- Invite people to participate through email.
- Assign avatars to users participating in the discussion.

## API Documentation
Auth | Method | Url | Params | Description
--- | --- | --- | --- | --- |
No | GET | `/discussions/:id` | `id` | Get discussion with specific id. |
No | GET | `/users/:id` | `id` | Get user with specific id.|
Yes | POST | `/discussions/:discussion_id/arguments` | `discussion_id`, `avatar_id`, `content` | Send an argument in a specific discussion. |
Yes | POST | `/discussions/:discussion_id/agreements` | `discussion_id`, `avatar_id`, `content`, `is_agree` | Propose an agreement if `is_agree = true` or disagreement if `is_agree = false` in a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/agreements/:agreement_id` | `discussion_id`, `avatar_id`, `is_accepted` | Accept an agreement if `is_accepted = true` or reject if `is_accepted = false` in a specific discussion. |
No | POST | `/tokensignin` | `id_token` | Verify Google token id. |
Yes | POST | `/discussions/:discussion_id/invite` | `discussion_id`, `email` | Send an email invitation to participate in a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/verify_invitation` | `discussion_id`, `token` | Verify if invitation is valid to participate in a specific discussion. |
Yes | PUT | `/discussions/:discussion_id/avatar/:avatar_id` | `discussion_id`, `avatar_id`, `user_id` | Assign user an avatar in a specific discussion. |
Yes | POST | `/discussions/` | `topic_title`, `topic_description`, `name_avatar_one`, `opinion_avatar_one`, `name_avatar_two`, `opinion_avatar_two` | Create new discussion. |
Yes | DELETE | `/discussions/:id` | `:id` | Delete a specific discussion. |
No | GET | `/discussions?page=[:page]&user_id=[:user_id]` | `page`, `user_id` | Get public discussions. |
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

- You need to set up the addon SendGrid in order to be able to send invitation emails. You need to set the env variables `SENDGRID_USERNAME` and `SENDGRID_PASSWORD`.

- If you want to set up `.travis.yml` in the root project for continuos integration, run this to create and add automtically the secrete api key of heroku to travis (more info on: [Travis Heroku Deployment](https://docs.travis-ci.com/user/deployment/heroku/)):

```bash
$ travis encrypt $(heroku auth:token) --add deploy.api_key
```
