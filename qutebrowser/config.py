config.load_autoconfig(False)

# Default settings
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')
config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:90.0) Gecko/20100101 Firefox/90.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
config.set('content.javascript.can_access_clipboard', True)

# Customized
c.fonts.default_family = ['Monaco']
c.fonts.default_size = '18pt'
c.fonts.tabs.selected = '18pt default_family'
c.fonts.tabs.unselected = '18pt default_family'
c.fonts.web.size.minimum = 16
c.fonts.hints = 'normal 16pt default_family'
c.fonts.contextmenu = 'normal 16pt default_family'
c.fonts.prompts = 'default_size default_family'
c.colors.completion.category.bg = 'black'
c.colors.completion.category.fg = 'white'
c.colors.completion.even.bg = 'black'
c.colors.completion.odd.bg = 'black'
c.colors.completion.fg = ['#888888']
c.colors.completion.item.selected.bg = '#333333'
c.colors.completion.item.selected.border.bottom = 'black'
c.colors.completion.item.selected.border.top = 'black'
c.colors.completion.item.selected.fg = 'white'
c.colors.completion.match.fg = '#ff4444'
c.colors.completion.scrollbar.bg = 'black'
c.colors.completion.scrollbar.fg = '#333333'
c.colors.contextmenu.menu.bg = '#444444'
config.set('fonts.web.size.minimum', 18, '*://*.github.com')
c.url.start_pages = ['https://google.com']
c.url.searchengines = {
        'DEFAULT': 'https://google.com/search?q={}',
        'gh': 'https://github.com/search?q={}',
        'r': 'https://www.reddit.com/search/?q={}',
        't': 'https://twitter.com/search?q={}',
        'y': 'https://www.youtube.com/results?search_query={}',
        'vd': 'https://vdict.com/{},1,0,0.html',
        'n': 'https://search.nixos.org/packages?query={}',
        }
config.bind('<Super-r>', 'reload')
config.bind('<Super-w>', 'tab-close')
config.bind('<Super-l>', 'set-cmd-text :open {url:pretty}')
config.bind('<Super-Shift-L>', 'set-cmd-text -s :tab-focus')
config.bind('<Super-]>', 'tab-next')
config.bind('<Super-[>', 'tab-prev')
config.bind('<Super-t>', 'set-cmd-text -s :open -t')
config.bind('<Super-1>', 'tab-focus 1')
config.bind('<Super-2>', 'tab-focus 2')
config.bind('<Super-3>', 'tab-focus 3')
config.bind('<Super-4>', 'tab-focus 4')
config.bind('<Super-5>', 'tab-focus 5')
config.bind('<Super-6>', 'tab-focus 6')
config.bind('<Super-7>', 'tab-focus 7')
config.bind('<Super-8>', 'tab-focus 8')
config.bind('<Super-9>', 'tab-focus 9')
config.bind('<Ctrl-r>', 'history -t')
config.bind('<Ctrl-u>', 'fake-key <Ctrl-Backspace>', mode='insert')
config.bind('<Ctrl-w>', 'fake-key <Alt-Backspace>', mode='insert')
config.bind('<Ctrl-j>', 'completion-item-focus next', mode='command')
config.bind('<Ctrl-k>', 'completion-item-focus prev', mode='command')
config.bind('<Ctrl-f>', 'rl-forward-word', mode='command')
config.bind('<Ctrl-j>', 'prompt-item-focus next', mode='prompt')
config.bind('<Ctrl-k>', 'prompt-item-focus prev', mode='prompt')
config.bind('<Ctrl-w>', 'rl-filename-rubout', mode='prompt')
config.bind('<Ctrl-u>', 'rl-rubout " "', mode='prompt')

# Unbind some keys
config.unbind('d', mode='normal')
config.unbind('r', mode='normal')

c.auto_save.session = True
c.auto_save.interval = 15000

c.completion.cmd_history_max_items = -1
c.completion.web_history.max_items = -1
c.completion.show = 'always'
c.completion.shrink = True
c.completion.use_best_match = True
c.confirm_quit = ['downloads']
c.content.autoplay = False
c.tabs.show = 'multiple' # hide the tab bar if only one tab is open
c.downloads.location.directory = '~/Downloads/'
c.downloads.location.prompt = True
c.downloads.location.remember = False
c.downloads.location.suggestion = 'both'
c.downloads.position = 'bottom'
