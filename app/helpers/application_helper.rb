module ApplicationHelper
  def datetime_format(datetime)
    datetime.localtime.strftime('%Y/%m/%d %H:%M %Z')
  end

  def render_facebook_comment(url)
    render "shared/facebook_comment", url: url
  end

  def render_facebook_like(url)
    return unless Settings.use_facebook_like
    render 'shared/facebook_like', url: url
  end

  def render_hatena_bookmark_button(url, title)
    return unless Settings.use_hatena_bookmark_button
    render 'shared/hatena_bookmark', url: url, title: title
  end

  def render_twitter_button(url, title)
    return unless Settings.use_twitter_button
    render 'shared/twitter', url: url, title: title
  end
end
