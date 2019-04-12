set throttle off
set frameskip 20
set mute on
set scale_factor 3
set glow 0
set blur 0
set accuracy screen
debug set_bp 0xffff {} {
  exit
}
