json.set! :html,
          "<h1>#{@article.title}</h1>\r\n" <<
            markdown(@article.text)
