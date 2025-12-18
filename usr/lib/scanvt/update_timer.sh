#!/bin/bash
CONFIG_FILE="/etc/scanvt/config"
DEFAULT_TIME="02:00"
DEFAULT_DAYS="Mon,Tue,Wed,Thu,Fri,Sat,Sun"

# Ruta correcta para systemd persistente
TIMER_FILE="/etc/systemd/system/scanvt.timer"

if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

SCAN_TIME="${SCAN_HOUR:-$DEFAULT_TIME}"
SCAN_DAYS="${SCAN_DAYS_OF_WEEK:-$DEFAULT_DAYS}"

echo "Actualizando timer a: $SCAN_DAYS a las $SCAN_TIME"

# Escribir la unidad timer
cat <<EOF > "$TIMER_FILE"
[Unit]
Description=Timer dinámico para scanvt

[Timer]
OnCalendar=${SCAN_DAYS} *-*-* ${SCAN_TIME}:00
Persistent=true

[Install]
WantedBy=timers.target
EOF

# Recargar systemd para aplicar cambios
systemctl daemon-reload
systemctl enable scanvt.timer
systemctl restart scanvt.timer