# path=(/opt/local/{bin,sbin} $path)
# export PYTHONPATH=/usr/local/lib/python2.7/site-packages/:

#Override default tools with Cellar ones if available
#This makes sure homebrew stuff is used
export PATH=/usr/local/bin:$PATH

#Point OSX to Cellar python
export PYTHONPATH=/usr/local/lib/python:$PYTHONPATH

#Point to brewed Atom
export ATOM_PATH=/opt/homebrew-cask/Caskroom/atom/latestalias
