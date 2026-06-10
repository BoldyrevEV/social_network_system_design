Table users {
  id integer [primary key]
  username varchar
  email varchar(255) [not null, unique]
  password_hash varchar(255) [not null]
  role varchar
  created_at timestamp
}

Table posts {
  id integer
  title varchar
  body text
  user_id bigint

  // Временная информация
  created_at timestamp 
  updated_at timestamp 
  published_at timestamp 
  
  // Доп информация
  likes_count integer [default: 0]
  comments_count integer [default: 0]
  
  // Медиа (JSONB)
  media jsonb [default: `'[]'`]
  
  // Статус
  is_published boolean [default: true]
  is_deleted boolean [default: false]
}

Table likes {
  id integer
  user_id bigint
  post_id bigint
  created_at timestamp
}

Table comments {
  id integer
  user_id bigint
  post_id bigint
  parent_id bigint
  
  content text
  
  // Вложенность
  depth smallint [default: 0]
  path ltree
  
  // Доп информация
  likes_count integer [default: 0]
  
  // Статус
  is_published boolean [default: true]
  is_deleted boolean [default: false]

  deleted_at timestamp
  created_at timestamp
  updated_at timestamp
}

Table follows {
  id integer
  follower_id bigint 
  followee_id bigint
  
  created_at timestamp
}

Ref user_posts: posts.user_id > users.id

Ref user_like: likes.user_id > users.id
Ref post_like: likes.post_id > posts.id

Ref user_comments: comments.user_id > users.id
Ref post_comments: comments.post_id > posts.id
Ref comments_comments: comments.parent_id > comments.id

Ref user_follows: follows.follower_id > users.id // кто подписался
Ref user_follows: follows.followee_id > users.id // на кого подписались

