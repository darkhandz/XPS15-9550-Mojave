#!/bin/bash
sudo launchctl unload /Library/LaunchAgents/com.XPS.ComboJack.plist
sudo rm /Library/LaunchAgents/com.XPS.ComboJack.plist
sudo rm /usr/bin/hda-verb
sudo rm /usr/bin/ComboJack
sudo rm /usr/local/sbin/hda-verb
sudo rm /usr/local/sbin/ComboJack
sudo rm -rf /usr/local/share/ComboJack/
echo
echo "Uninstall success, Please reboot!"
echo
echo "Enjoy!"
echo
exit 0
