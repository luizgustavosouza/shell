GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="$(sed 's, release .*$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=rhel_mudflap-03/root rd.lvm.lv=rhel_mudflap-03/swap rhgb quiet audit=1"
GRUB_DISABLE_RECOVERY="true"
