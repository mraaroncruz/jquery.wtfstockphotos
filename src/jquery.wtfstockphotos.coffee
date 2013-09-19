####
# WTF Stockphotos jQuery Plugin
# Replace image elements with crazy stock photos
# version 0.0.1, September 19, 2013
# by Aaron Cruz - @mraaroncruz
#
# Example
#
# // replace all images
#
# $.wtfstockphotos('img')
#
# // replace an images by class or id
#
# $.wtfstockphotos('.swappable-image')
#
#
# Options
#
# limit (default 30):
#   limit number of images fetched from reddit. will make initial request faster.
#
# $.wtfstockphotos('.swappable-image', { limit: 10 })
#

(($) ->
  $.wtfstockphotos = (el, options) ->
    defaults =
      limit: 30
    plugin = this
    plugin.reddit_url = "http://reddit.com/r/wtfstockphotos.json"
    plugin.settings = {}
    plugin.urls = []

    getNextImageUrl = ->
      url = plugin.urls.pop()
      plugin.urls.unshift(url)
      url

    replaceImages = (urls) ->
      for el in $(plugin.el)
        el.onerror = (err) ->
          el.src = getNextImageUrl()
        el.src = getNextImageUrl()

    shuffle = (array) ->
      for i in [(array.length - 1)..1]
        j = Math.floor(Math.random() * (i + 1))
        temp = array[i]
        array[i] = array[j]
        array[j] = temp
      array

    init = ->
      plugin.settings = $.extend({}, defaults, options)
      plugin.el = el
      req = $.ajax
        url: "#{plugin.reddit_url}?limit=#{plugin.settings.limit}"
        dataType: "jsonp"
        jsonp: "jsonp"

      req.done (res) ->
        posts = (post for post in res.data.children)
        plugin.urls = shuffle(post.data.url for post in posts)
        replaceImages()

    init()
)(jQuery)
