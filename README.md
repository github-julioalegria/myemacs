# My emacs enviroment

My emacs enviroment. Feel free to copy/clone/fork.

## What is in it?

+ [uniquify](http://emacswiki.org/emacs/uniquify), for better buffer naming.
+ [web-mode](http://web-mode.org/), great for editing django templates (HTML, javascript and django tags).
+ [yasnippet](https://github.com/capitaomorte/yasnippet), best snippet extension ever!
+ [expand-region](https://github.com/magnars/expand-region.el), selects region by semantic units.
+ [no-easy-keys](http://danamlund.dk/emacs/no-easy-keys.html),  the best if you are new to Emacs (trains you to use the proper keys).
+ Auto-saves and backups in the tmp directory.
+ Highlight matching brackets.
+ Spaces instead of tabs.
+ C and C++ with 4 spaces indentation (linux style).
+ Javascript with 2 spaces indentation.
+ Fixed window width: 80
+ Key binding `C-!` for `expand-region`.
+ Key binding `C-}` to double the frame width and split window horizontally.
+ Key binding `C-{` to keep current window (closes the rest) and returns to normal frame width.
+ Key binding `C-$` to open the shell.
+ Key binding `C-%` to open the python shell (python-mode only).
+ Use local file `pyflakespep8.py` (pyflakes + PEP8) instead of default pychecker for a source code warning and error report (`C-c C-w`).
+ flymake: python checker on the fly using local file `pyflakespep8.py` (pyflakes + PEP8) for better source code warning and error reports.
+ Define the modes where you want flymake to be enabled, in my case I just want flymake on python files.
+ Lots of useful snippets for python, django, html, jquery (and more) on `yasnippet/snippets`.

## What is the best way to avoid getting _Emacs Pinky_?

Configure so that the space bar works both as space and control: when the space is pressed alone, as a space, and pressed with others, as control. So `SPC-x` is treated as `C-x`.

You can do it with:
+ AutoHotKey (Windows).
+ at-home-modifier (Linux).
+ Keyremap4macbook (OS X).