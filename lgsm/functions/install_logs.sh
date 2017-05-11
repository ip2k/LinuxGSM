#!/bin/bash
# LinuxGSM install_logs.sh function
# Author: Daniel Gibbs
# Website: https://gameservermanagers.com
# Description: Creates log directories.

local commandname="INSTALL"
local commandaction="Install"
local function_selfname="$(basename $(readlink -f "${BASH_SOURCE[0]}"))"

if [ "${checklogs}" != "1" ]; then
	echo ""
	echo "Creating log directories"
	echo "================================="
fi
sleep 1
# Create script and console log directories
mkdir -pv "${logdir}"
mkdir -pv "${scriptlogdir}"
touch "${scriptlog}"
if [ -n "${consolelogdir}" ]; then
	mkdir -pv "${consolelogdir}"
	touch "${consolelog}"
fi

# Create gamelogdir if variable exists but directory does not
if [ -n "${gamelogdir}" ]&&[ ! -d "${gamelogdir}" ]; then
	mkdir -pv "${gamelogdir}"
fi

# Symlink gamelogdir to lgsm logs if variable exists
if [ -n "${gamelogdir}" ]; then
	if [ ! -h "${logdir}/server" ]; then
		ln -nfsv "${gamelogdir}" "${logdir}/server"
	fi
fi

# If server uses SteamCMD create a symbolic link to the Steam logs
if [ -d "${rootdir}/Steam/logs" ]; then
	if [ ! -h "${logdir}/steamcmd" ]; then
		ln -nfsv "${rootdir}/Steam/logs" "${logdir}/steamcmd"
	fi
fi
sleep 1
fn_script_log_info "Logs installed"
