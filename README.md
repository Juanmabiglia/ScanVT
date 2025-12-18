# scanvt

`scanvt` es una herramienta de escaneo de malware automatizado para sistemas Linux. Utiliza **ClamAV** para el análisis de archivos y **VirusTotal** para confirmar si las amenazas detectadas son reales o falsos positivos.

**Novedad v1.1:** El núcleo ha sido reescrito en **Python 3** para mayor robustez y velocidad, integrándose nativamente con el daemon de ClamAV (`clamdscan`) para escaneos ultrarrápidos.

## ✨ Características

- **Alto Rendimiento:** Integración con `clamav-daemon` para escaneos instantáneos (sin tiempos de carga de DB).
- **Inteligencia:** Consulta a la API de VirusTotal para verificar detecciones y reducir falsos positivos.
- **Automatización:** Escaneo de archivos recientes o completos, gestionado por `systemd`.
- **Seguridad:** Aislamiento inmediato de amenazas en cuarentena.
- **Gestión de Falsos Positivos:** Restauración automática y Whitelist local si VirusTotal lo confirma limpio.
- **Reportes:** Logs detallados, informes CSV y alertas por correo electrónico.

## 🔑 Cómo obtener tu API key de VirusTotal

1. Regístrate gratis en [VirusTotal](https://www.virustotal.com/gui/join-us).
2. Ve a tu perfil > **API Key**.
3. Copia la clave en `/etc/scanvt/config`:

```bash
VT_API_KEY="tu_clave_api_aqui"
```

## 📦 Instalación

### Requisitos Previos

El sistema ahora requiere Python 3 (instalado por defecto en la mayoría de distros) y se recomienda encarecidamente `clamav-daemon` para velocidad.

```bash
sudo apt update
sudo apt install clamav clamav-daemon mailutils -y
```

### Instalación del Paquete

```bash
sudo dpkg -i scanvt_1.1_all.deb
sudo systemctl daemon-reload
sudo systemctl enable --now scanvt-generate.service scanvt.timer
```

## ⚙️ Configuración

Archivo: `/etc/scanvt/config`

```bash
# API Key de VirusTotal (Obligatorio)
VT_API_KEY="tu_api_key_virustotal"

# Directorios a vigilar
SCAN_DIRS=("/home" "/var/www")

# Escanear archivos modificados en los últimos X días
SCAN_DAYS=10

# Hora del escaneo diario
SCAN_HOUR="03:00"

# Días de ejecución
SCAN_DAYS_OF_WEEK="Mon,Tue,Wed,Thu,Fri"

# Email para alertas
MAIL_DEST="admin@tudominio.com"

# Días para retener archivos en cuarentena (0 = nunca borrar)
QUAR_RETENTION_DAYS=7
```

## 🧪 Resultados

- **Cuarentena:** `/var/quarantine`
- **Logs:** `/var/log/scanvt/scan.log`
- **Whitelist:** `/var/cache/scanvt/whitelist.txt`
- **Reportes CSV:** `/root/scanvt/`

## 🔧 Mantenimiento

Mantenedor: **Juan Manuel Biglia**  
Contacto: `juanma.biglia@gmail.com`