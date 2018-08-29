from socket import gethostname as ghn
import os
import datetime

# Set things like c.tabs.position = "left"
c.url.searchengines = {
        "DEFAULT" : "https://duckduckgo.com/?q={}",
        "ar"      : "https://wiki.archlinux.org/?search={}",
        "aur"     : "https://aur.archlinux.org/packages/{}",
        "ma"      : "https://www.mathworks.com/help/matlab/ref/{}.html",
        "go"      : "https://www.google.com/search?hl=en&q={}",
        "re"      : "https://www.reddit.com/r/{}",
        "wi"      : "https://www.wikipedia.org/wiki/{}"
        }
# Colorthemes
css_dark = str(config.configdir) + '/css/dark.css'
css_lght = str(config.configdir) + '/css/light.css'
config.bind( '<Ctrl-d>', 'config-cycle --temp content.user_stylesheets {0} {1} "" ;; reload'.format(css_dark,css_lght) )

c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0"
c.editor.command = ["termite", "-e", "nvim {}"]
c.content.media_capture = True
c.spellcheck.languages = [ "en-US" ]
c.tabs.position = "left"
c.tabs.background = True
c.tabs.width = "12%"
c.completion.height = "10%"
c.confirm_quit = [ "always" ]
c.content.javascript.alert = True
c.content.javascript.can_access_clipboard = False
c.content.javascript.can_close_tabs = False
c.content.javascript.can_open_tabs_automatically = False
c.content.pdfjs = True
c.content.geolocation = True
c.downloads.location.prompt = True
# c.content.cookies.store = False

config.bind( '<Ctrl-b>', 'adblock-update')
config.bind( 'm', 'spawn mpv {url}')
config.bind( 'M', 'hint links spawn mpv {hint-url}')

# Time based locking
currentTime = datetime.datetime.now()
if ( currentTime.hour >= 7 ) & ( currentTime.hour < 20 ):
    c.content.host_blocking.enabled = True
else:
    c.content.host_blocking.enabled = False

if ghn() == "spbworkstation":
    c.url.default_page = "http://intranet.cshl.edu"
    c.url.start_pages = [ "http://intranet.cshl.edu" ]
else:
    c.url.default_page = "https://start.duckduckgo.com/"
    c.url.start_pages = [ "https://start.duckduckgo.com/" ]
