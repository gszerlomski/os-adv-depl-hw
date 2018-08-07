if ps -p $SSH_AGENT_PID > /dev/null
then
   echo "ssh-agent is already running"
   ssh-add ~/.ssh/git
else
   eval `ssh-agent -s`
   ssh-add ~/.ssh/git
fi



