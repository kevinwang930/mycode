export NVM_DIR="/opt/tools/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export JAVA_HOME=/opt/homebrew/Cellar/openjdk/22.0.2
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/opt/tools/JetBrains/script:$PATH
