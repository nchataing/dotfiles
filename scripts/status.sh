#/bin/sh

time_fmt () {
    date '+%H:%M'
}

battery () {
    acpi | sed -n -e 's/.*: \([^,]*\), \([[:digit:]]*%\).*/\1 \2/p' | sed -n -e 's/Full\|Not charging/■/p;s/Charging/▲/p;s/Discharging/▼/p'
}

status () {
    echo "$(battery) | $(time_fmt)"
}

while true; do
    xsetroot -name "$(status)"
    sleep 5
done
