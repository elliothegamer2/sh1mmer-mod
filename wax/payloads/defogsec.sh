read -p " <Enter to start> "
# stole code from reco and sh1mmer for this script ngl
asusb() {
  if [ -d /usb ]; then
    chroot "$USB_MNT" "/bin/bash" -c "TERM=xterm $*"
  else
    $@
  fi
}
if crossystem wp_sw?1; then
    echo "Attempting to clear WP"
    asusb flashrom --wp-disable > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Failed"
        echo "Disable write protection lol"
        sleep 3
        reboot
    else
        FLAGS=0x8090 # Force dev mode flag
        clear
        asusb /usr/share/vboot/bin/set_gbb_flags.sh "$FLAGS"
        message "Set GBB flags sucessfully"
    fi
    
fi

echo "Attempting Defog"
futility gbb --flash -s --flags=0x8090
crossystem block_devmode=0
vpd -i RW_VPD block_devmode=0
