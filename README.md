# Microblogging API

A Rails API for a microblogging platform. Users can sign up, create posts, follow each others, comment on posts, and view a personalized feed. Focused on backend functionality with secure authentication, efficient queries, and test coverage.

---

## Features

* **User Authentication**

  * Sign up, sign in, and sign out using Devise.
  * Secure password storage.

* **Microposts**

  * Create, view, and delete posts (140 character limit).

* **Following**

  * Users can follow/unfollow others.
  * Users cannot follow themselves.

* **Comments**

  * Users can comment on any post.
  * Comment counts tracked with counter cache.

* **Feed**

  * Returns posts from self and followed users.
  * Ordered by most recent first.
  * Paginated for infinite scroll.
  * Avoids N+1 queries with includes and counter caches.

---

## API Endpoints

| Method | Endpoint        | Description         | Auth Required |
| ------ | --------------- | ------------------- | ------------- |
| POST   | /users/signup   | Sign up a new user  | No            |
| POST   | /users/signin   | Sign in             | No            |
| POST   | /users/signout  | Sign out            | Yes           |
| POST   | /microposts     | Create a post       | Yes           |
| DELETE | /microposts/:id | Delete a post       | Yes           |
| GET    | /microposts/:id | View a post         | No            |
| POST   | /follow         | Follow a user       | Yes           |
| POST   | /unfollow       | Unfollow a user     | Yes           |
| POST   | /comments       | Create a comment    | Yes           |
| GET    | /feed           | Get feed with posts | Yes           |

---

## Setup

1. Clone the repo

```bash
git clone https://github.com/PratiAmalden/microblog-api
cd microblogging-api
```

2. Install dependencies

```bash
bundle install
```

3. Setup the database

```bash
rails db:create db:migrate db:seed
```

4. Start the server

```bash
rails server
```

---

## Testing

* Uses **RSpec** and **FactoryBot** for model and request specs.
* Test validations, associations, feed logic, and authorization.

```bash
rspec
```