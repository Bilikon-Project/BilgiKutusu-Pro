<div align="center">

# BilgiKutusu Pro

**Access to knowledge without an internet connection.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Raspberry%20Pi%204-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)
[![Web](https://img.shields.io/badge/Web-Nginx-009639?logo=nginx&logoColor=white)](https://nginx.org/)
[![Knowledge](https://img.shields.io/badge/Knowledge-Kiwix-4D8B72)](https://kiwix.org/)

**Languages:** English | [Türkçe](README.tr.md)

</div>

---

## About the project

**BilgiKutusu Pro** is a portable digital library project running on a Raspberry Pi that aims to serve offline knowledge resources to devices on a local network.

The goal is to simplify access to encyclopedias, books, educational materials, and other local resources in areas with limited internet access, in schools, and for everyday use. The portal consists of static files that do not require an internet connection. Kiwix and Nginx run as separate services.

> This project is under active development. The configurations in this repository are examples and should not be applied directly to every Raspberry Pi setup without review.

## Architecture

| Layer | Technology | Role |
|---|---|---|
| Hardware | Raspberry Pi 4 Model B | Main server |
| Operating system | Raspberry Pi OS Lite | Lightweight Linux environment |
| Web server | Nginx | Serves the portal and local files |
| Knowledge archive | Kiwix | ZIM-based offline content |
| Management | SSH | Remote system administration |
| Storage | USB SSD | Large content archives |

## Features

- Access over a local Wi-Fi or Ethernet network.
- Browser compatibility across phones, tablets, and computers.
- Portal search with support for Turkish characters.
- Offline encyclopedia access via Kiwix.
- Content categories including books, agriculture, education, maps, and media.
- Headless server setup requiring no graphical desktop environment.

Running two separate wireless networks (e.g., `BilgiKutusu` and `BilgiKutusu-Dahili`) is an optional hardware/network configuration; this repository does not create them automatically.

## Content library

The portal provides links to the following collections:

- Wikipedia and Kiwix
- Books
- Agriculture
- Fishing
- Educational videos
- Maps
- Web archive
- Media

For these links to work, the corresponding ZIM files or media must be present on the Raspberry Pi and Nginx paths must be configured properly. ZIM files and copyrighted media are not included in this repository. Check distribution licenses when adding content.

## Quick start

Read the [safe installation guide](docs/KURULUM.md) first. This repository does not automatically modify your existing network, SSH connection, or services.

```bash
# Inspect system information in read-only mode
bash scripts/check-system.sh

# Install portal files under /var/www/bilgikutusu
sudo bash scripts/install-web.sh

# Generate static catalog pages for content directories
sudo python3 scripts/build-library-index.py /mnt/BilgiKutusu
```

Nginx example: `config/nginx/bilgikutusu.conf.example`

Kiwix systemd example: `config/systemd/kiwix-serve.service.example`

## Hardware

See [DONANIM.md](docs/DONANIM.md) for recommended/example hardware and storage details.

## Security notes

- Back up your existing configuration files before applying any example configurations.
- Do not commit real Wi-Fi passwords, SSH keys, or personal information to the repository.
- Library directory listing is disabled by default; controlled catalog pages can be generated using the script.
- Configure Nginx and Kiwix to listen only on the required network interfaces.
- Keep in mind the risk of losing connection when modifying network settings over SSH.

## Contributing

You can open an Issue to report bugs or suggest improvements, and submit your changes as a Pull Request. See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License

This project is released under the [MIT License](LICENSE).

---

> **方針:**
> プロジェクトを立ち上げただけで責任を放棄し、「Linuxが使えるから」という理由で作業や後処理をすべて押し付ける行為には一切応じない。私は誰の便利屋でもない。各自が自分の尻拭いをすること。これ以上の関与は終了する。





