#! /bin/bash

tmux has -t opendaylight-vagrant 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
    tmux attach -t opendaylight-vagrant;
else
    tmux new-session -d -s opendaylight-vagrant
    tmux rename-window 'README'
    tmux send-keys 'less /vagrant/README.md' 'C-m'
    tmux new-window
    tmux send-keys 'sudo /opt/opendaylight/opendaylight-helium/bin/karaf' 'C-m'
    tmux rename-window 'opendaylight-karaf'
    tmux split-window -h 'exec sudo bash -c "while true; do netstat -pnl | grep java; sleep 1; clear; done"'
   tmux new-window 
    tmux rename-window 'bird'
    tmux send-keys 'sudo service bird start'
    tmux split-window -h 'exec sudo bash -c "while true; do birdcl show protocols all bgp1; sleep 1; clear; done"'
    tmux new-window
    tmux rename-window 'opendaylight-config'
    tmux send-keys 'cd /opt/opendaylight/etc/opendaylight/karaf' 'C-m' 'sudo vim '
    tmux new-window
    tmux rename-window 'opendaylight-repos'
    tmux send-keys 'cd /open-daylight' 'C-m'
    tmux select-window -t 0
    tmux -2 attach -t opendaylight-vagrant
fi
