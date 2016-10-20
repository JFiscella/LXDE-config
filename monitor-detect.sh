#!/bin/sh

## this will read the EDID data using xrandr.
## it extracts the monitors' names according to the EDID specification.
## 
## source: http://stackoverflow.com/questions/10500521/linux-retrieve-monitor-names#24933353

xrandr --verbose | awk '
/[:.]/ && hex {
    sub(/.*000000fc00/, "", hex)
    hex = substr(hex, 0, 26) "0a"
    sub(/0a.*/, "0a", hex)
    print hex
    hex=""
}
hex {
    gsub(/[ \t]+/, "")
    hex = hex $0
}
/EDID.*:/ {
    hex=" "
}' | xxd -r -p
