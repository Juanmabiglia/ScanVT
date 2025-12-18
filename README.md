# scanvt

`scanvt` es una herramienta de escaneo de malware automatizado para sistemas Linux. Utiliza **ClamAV** para el análisis rápido y **VirusTotal** para confirmar amenazas, reduciendo drásticamente los falsos positivos.

**Versión 1.1:** Núcleo reescrito en Python 3 para máximo rendimiento, soporte para `clamdscan`, notificaciones modernas (Discord/Telegram) y configuración flexible.

## ✨ Características

- **Motor Híbrido:** Velocidad de ClamAV + Inteligencia de VirusTotal.
- **Ultra Rápido:** Integración nativa con `clamav-daemon` (escaneo en memoria).
- **Cero Falsos Positivos:** Verificación automática de amenazas contra múltiples motores antivirus.
- **Modos de Acción:** Elige entre poner en `Cuarentena`, `Eliminar` o solo `Reportar`.
- **Notificaciones Multi-canal:** Email, Discord, Slack y Telegram.
- **Inteligente:** Ignora archivos gigantes, carpetas basura (`node_modules`, `.git`) y archivos ya analizados (caché de hashes).
- **Reportes:** Historial CSV detallado y logs de auditoría.

## 🔑 Requisitos

1. **VirusTotal API Key:** Gratuita en [VirusTotal](https://www.virustotal.com).
2. **Dependencias del Sistema:**
   ```bash
   sudo apt update
   sudo apt install clamav clamav-daemon mailutils
   ```

## 📦 Instalación

```bash
# Instalar paquete
sudo dpkg -i scanvt_1.1_all.deb

# Recargar servicios
sudo systemctl daemon-reload
sudo systemctl enable --now scanvt-generate.service scanvt.timer
```

## ⚙️ Configuración Avanzada

Edita el archivo `/etc/scanvt/config` para personalizar el comportamiento.

### Básico
```bash
VT_API_KEY="tu_clave_api_obligatoria"
SCAN_DIRS=("/home" "/var/www")
```

### Comportamiento y Seguridad
```bash
# Cuántos motores deben confirmar virus para actuar (Recomendado: 2)
VT_THRESHOLD=2

# Qué hacer con el malware: "quarantine" (defecto), "delete", "report"
ACTION_MODE="quarantine"

# Ignorar archivos grandes (MB) para no saturar el sistema
MAX_FILE_SIZE_MB=500

# Excluir carpetas basura
EXCLUDE_DIRS=("node_modules" ".git" "tmp" "venv")
```

### Notificaciones Modernas
Descomenta las líneas en el archivo config para activarlas:

```bash
# Discord
DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/..."

# Telegram
TELEGRAM_BOT_TOKEN="123456:ABC-DEF..."
TELEGRAM_CHAT_ID="987654321"
```

## 🧪 Rutas Importantes

- **Configuración:** `/etc/scanvt/config`
- **Cuarentena:** `/var/quarantine`
- **Logs:** `/var/log/scanvt/scan.log`
- **Reportes CSV:** `/root/scanvt/`

## 🔧 Mantenimiento

Mantenedor: **Juan Manuel Biglia**  
Contacto: `juanma.biglia@gmail.com`
