pyversion=3.9.9
pyenv install -v $pyversion
eval "$(pyenv init -)"
pyenv global $pyversion
apt-get install python3-dotenv-cli
python3 -m venv .venv
