<div align="center">

# BilgiKutusu Pro

**İnternet bağlantısı olmadan bilgiye erişim.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Raspberry%20Pi%204-C51A4A?logo=raspberrypi&logoColor=white)](https://www.raspberrypi.com/)
[![Web](https://img.shields.io/badge/Web-Nginx-009639?logo=nginx&logoColor=white)](https://nginx.org/)
[![Knowledge](https://img.shields.io/badge/Knowledge-Kiwix-4D8B72)](https://kiwix.org/)

</div>

---

## Proje hakkında

**BilgiKutusu Pro**, Raspberry Pi üzerinde çalışan ve yerel ağdaki cihazlara çevrimdışı bilgi kaynakları sunmayı hedefleyen taşınabilir bir dijital kütüphane projesidir.

Amaç; internet erişiminin sınırlı olduğu bölgelerde, okullarda ve günlük kullanımda ansiklopedi, kitap, eğitim materyali ve diğer yerel kaynaklara erişimi kolaylaştırmaktır. Portal internet bağlantısı gerektirmeyen statik dosyalardan oluşur. Kiwix ve Nginx ayrı servisler olarak çalışır.

> Proje geliştirme aşamasındadır. Depodaki yapılandırmalar örnektir; her Raspberry Pi kurulumuna doğrudan uygulanmamalıdır.

## Mimari

| Katman | Teknoloji | Görev |
|---|---|---|
| Donanım | Raspberry Pi 4 Model B | Ana sunucu |
| İşletim sistemi | Raspberry Pi OS Lite | Hafif Linux ortamı |
| Web sunucusu | Nginx | Portalı ve yerel dosyaları sunar |
| Bilgi arşivi | Kiwix | ZIM tabanlı çevrimdışı içerik |
| Yönetim | SSH | Uzaktan sistem yönetimi |
| Depolama | USB SSD | Büyük içerik arşivleri |

## Özellikler

- Yerel Wi-Fi veya Ethernet ağı üzerinden erişim.
- Telefon, tablet ve bilgisayarlarla tarayıcı uyumluluğu.
- Türkçe karakterleri dikkate alan portal araması.
- Kiwix üzerinden çevrimdışı ansiklopedi erişimi.
- Kitap, tarım, eğitim, harita ve medya gibi içerik kategorileri.
- Grafik masaüstü ortamı gerektirmeyen sunucu kurulumu.

İki ayrı kablosuz ağ (ör. `BilgiKutusu` ve `BilgiKutusu-Dahili`) isteğe bağlı bir donanım/ağ yapılandırmasıdır; depo bunları otomatik olarak oluşturmaz.

## İçerik kütüphanesi

Portal aşağıdaki koleksiyonlara bağlantı sağlar:

- Wikipedia ve Kiwix
- Kitaplar
- Tarım
- Balıkçılık
- Eğitim videoları
- Haritalar
- Web arşivi
- Medya

Bu bağlantıların çalışması için ilgili ZIM veya dosyaların Raspberry Pi üzerinde bulunması ve Nginx yollarının doğru ayarlanması gerekir. ZIM dosyaları ve telifli medya bu depoya dahil değildir. İçerik eklerken dağıtım lisanslarını kontrol edin.

## Hızlı başlangıç

Önce [güvenli kurulum rehberini](docs/KURULUM.md) okuyun. Bu depo mevcut ağınızı, SSH bağlantınızı veya servislerinizi otomatik olarak değiştirmez.

```bash
# Sistem bilgilerini salt okunur şekilde incele
bash scripts/check-system.sh

# Portal dosyalarını /var/www/bilgikutusu altına kur
sudo bash scripts/install-web.sh

# İçerik klasörleri için statik katalog sayfaları oluştur
sudo python3 scripts/build-library-index.py /mnt/BilgiKutusu
```

Nginx örneği: `config/nginx/bilgikutusu.conf.example`

Kiwix systemd örneği: `config/systemd/kiwix-serve.service.example`

## Donanım

Önerilen/örnek donanım ve depolama bilgileri için [DONANIM.md](docs/DONANIM.md) dosyasına bakın.

## Güvenlik notları

- Örnek yapılandırmaları uygulamadan önce mevcut dosyalarınızı yedekleyin.
- Gerçek Wi-Fi parolalarını, SSH anahtarlarını veya kişisel bilgileri depoya koymayın.
- Kütüphane dizin listelemesi varsayılan olarak kapalıdır; kontrollü katalog sayfaları betikle üretilebilir.
- Nginx ve Kiwix'i yalnızca ihtiyaç duyulan ağ arayüzlerinde dinleyecek şekilde yapılandırın.
- Ağ yapılandırmasını SSH üzerinden değiştirirken bağlantıyı kaybetme riskini hesaba katın.

## Katkıda bulunma

Hata bildirmek veya geliştirme önermek için Issue açabilir, değişikliklerinizi Pull Request olarak gönderebilirsiniz. Ayrıntılar için [CONTRIBUTING.md](CONTRIBUTING.md) dosyasına bakın.

## Lisans

Bu proje [MIT Lisansı](LICENSE) altında yayımlanır.
