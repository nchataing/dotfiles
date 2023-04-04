#/bin/sh

time_fmt () {
    echo -n "$(date '+%H:%M')"
}

battery () {
    echo -n $(acpi | sed -n -e 's/.*: \([^,]*\), \([[:digit:]]*%\).*/\1 \2/p' | sed -n -e 's/Full\|Not charging/■/p;s/Charging/▲/p;s/Discharging/▼/p')
}

status () {
    echo -n "$(battery) | $(time_fmt)"
}

while :; do
    xsetroot -name "$(status)"
    sleep 5
done
