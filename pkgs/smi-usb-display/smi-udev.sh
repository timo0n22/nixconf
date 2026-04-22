#!/bin/sh
# smi-udev.sh — generated for NixOS smi-usb-display module
# Called by udev when Silicon Motion USB display is added/removed

get_siliconmotion_dev_count() {
  cat /sys/bus/usb/devices/*/manufacturer 2>/dev/null | grep -c "Silicon_Motion" || echo "0"
}

get_siliconmotion_symlink_count() {
  root=$1
  if [ ! -d "$root/siliconmotion/by-id" ]; then
    echo "0"
    return
  fi
  for f in $(find "$root/siliconmotion/by-id" -type l -exec realpath {} \; 2>/dev/null); do
    test -c "$f" && echo "$f"
  done | wc -l
}

start_service() {
  systemctl start smiusbdisplay
}

stop_service() {
  systemctl stop smiusbdisplay
}

start_siliconmotion() {
  if [ "$(get_siliconmotion_dev_count)" != "0" ]; then
    start_service
  fi
}

stop_siliconmotion() {
  root=$1
  if [ "$(get_siliconmotion_symlink_count "$root")" = "0" ]; then
    stop_service
  fi
}

create_siliconmotion_symlink() {
  root=$1
  device_id=$2
  devnode=$3
  mkdir -p "$root/siliconmotion/by-id"
  ln -sf "$devnode" "$root/siliconmotion/by-id/$device_id"
}

unlink_siliconmotion_symlink() {
  root=$1
  devname=$2
  for f in "$root/siliconmotion/by-id/"*; do
    if [ ! -e "$f" ] || ([ -L "$f" ] && [ "$f" -ef "$devname" ]); then
      unlink "$f"
    fi
  done
  (cd "$root" && rmdir -p --ignore-fail-on-non-empty siliconmotion/by-id 2>/dev/null || true)
}

main() {
  action=$1
  root=$2
  devnode=$4

  if [ "$action" = "add" ]; then
    device_id=$3
    create_siliconmotion_symlink "$root" "$device_id" "$devnode"
    start_siliconmotion
  elif [ "$action" = "remove" ]; then
    devname=$3
    unlink_siliconmotion_symlink "$root" "$devname"
    stop_siliconmotion "$root"
  elif [ "$action" = "START" ]; then
    start_siliconmotion
  fi
}

if [ "$ACTION" = "add" ] && [ "$#" -ge 3 ]; then
  main "$1" "$2" "$3" "$4"
  exit 0
fi

if [ "$ACTION" = "remove" ]; then
  if [ "$#" -ge 2 ]; then
    main "$1" "$2" "$3" "$4"
  fi
  exit 0
fi
