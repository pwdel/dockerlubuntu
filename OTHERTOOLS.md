# linux
xclip -sel clip < ~/.ssh/id_rsa.pub

# in case you get a display null error
DISPLAY=:0 xclip -sel clip < ~/.ssh/id_rsa.pub

# osx
pbcopy < ~/.ssh/id_rsa.pub
