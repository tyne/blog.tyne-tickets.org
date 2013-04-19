---
layout: page
title: Blog
tagline:
---
{% include JB/setup %}

<ul class="posts">
  {% for post in site.posts %}
    <a href="{{ BASE_PATH }}{{ post.url }}"><h2>{{ post.title }}</h2></a>
    {{ post.date | date_to_string }} | {{ post.post_author }}
    {{ post.content }}
  {% endfor %}
</ul>
