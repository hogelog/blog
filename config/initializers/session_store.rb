# Be sure to restart your server when you modify this file.

#Blog::Application.config.session_store :cookie_store, key: '_blog_session'
Blog::Application.config.session_store :redis_store,
                                       servers: [
                                        "redis://localhost:6379/0/session"
                                       ]
