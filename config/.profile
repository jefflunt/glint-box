if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

export LD_LIBRARY_PATH=/opt/vc/lib

# Clear console just before launch
clear
/home/pi/glint-es/glint-es &> /var/log/glint/glint-es.log