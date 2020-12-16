#! /bin/sh
#
# terminal.sh


# used for choosing the correct terminal in ssh and allow to do commands like clear
if grep -xq "export TERM=vt100" ~/.bashrc; then
	echo "Already here"
else
	echo "export TERM=vt100" >> ~/.bashrc
fi
source ~/.bashrc
