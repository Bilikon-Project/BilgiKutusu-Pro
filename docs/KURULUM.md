# Güvenli Kurulum Rehberi

Bu depo örnek yapılandırmalar içerir. Betikler mevcut Raspberry Pi ağını, SSH ayarlarını veya servis yapılandırmalarını otomatik olarak değiştirmez.

## 1. Ön kontroller

```bash
bash scripts/check-system.sh
```

Bu betik sistem, bellek, depolama, ağ arabirimleri, servisler ve portal dosyalarının durumunu görüntüler. Ayar değiştirmez. Çıktıyı herkese açık paylaşmadan önce IP adreslerini ve donanım bilgilerini kontrol edin.

## 2. Portalı kurma

```bash
sudo bash scripts/install-web.sh
```

Kurulum betiği web dosyalarını `/var/www/bilgikutusu/` dizinine hazırlar ve hedefi tek seferde yerleştirir. Hedef dizin zaten varsa işlemi durdurur; mevcut dosyaların üzerine yazmaz. Güncelleme yapmadan önce mevcut portalı kendiniz yedekleyin ve hedef dizini güvenli biçimde taşıyın.

Betik Nginx yapılandırmasını değiştirmez ve servisi yeniden başlatmaz.

## 3. Nginx

`config/nginx/bilgikutusu.conf.example` dosyasını inceleyin. Örnek portal `8081`, Kiwix upstream'i `127.0.0.1:8080` adresini kullanır. Portların sisteminizde boş ve uygun olduğunu doğrulayın.

Yapılandırmayı sisteminizin Nginx dizilimine uyarladıktan sonra:

```bash
sudo nginx -t
```

Test başarılı olmadan Nginx'i yeniden yüklemeyin. Mevcut sunucu bloklarıyla port veya `server_name` çakışmalarını kontrol edin.

## 4. Kiwix

Kiwix ayrı kurulur ve yerel ZIM dosyalarıyla çalıştırılır. `config/systemd/kiwix-serve.service.example` yalnızca örnektir. İçindeki ZIM dosya adını, Kiwix ikili dosyasının yolunu ve servis kullanıcısını kendi sisteminize göre değiştirin.

`www-data` kullanıcısının ZIM dosyasını okuyabildiğinden emin olun. Servis örneği Kiwix'i `127.0.0.1:8080` üzerinde dinletmeyi hedefler; böylece doğrudan ağa açmak yerine Nginx üzerinden erişim sağlanır.

Nginx ve systemd örnekleri `/kiwix/` önekini birlikte kullanır: Kiwix `--urlRootLocation=/kiwix/` ile başlatılır ve Nginx isteğin yol önekini upstream'e koruyarak iletir. Kiwix belgelerinde bu seçenek, içeriğin hangi URL kökü altında sunulacağını belirler. Kurulu sürümünüzde `/kiwix/` adresinin ve içerik bağlantılarının doğru çalıştığını test edin.

## 5. Wi-Fi ve ağ

`config/network/README.md` yalnızca tasarım notlarıdır; çalışan bir erişim noktası kurmaz. NetworkManager veya kablosuz arayüz ayarlarını değiştirmek SSH bağlantısını kesebilir. Mümkünse Ethernet üzerinden çalışın, yedek erişim ve geri dönüş planı hazırlayın. Gerçek parolaları Git deposuna eklemeyin.

## 6. Dosya kütüphanesi

Nginx örneği `/kutuphane/` yolunu `/mnt/BilgiKutusu/` dizinine eşler. Klasör listelemesi kapalıdır. Kategori klasörleri için güvenli statik katalog sayfaları oluşturmak üzere şu betiği kullanabilirsiniz:

```bash
sudo python3 scripts/build-library-index.py /mnt/BilgiKutusu
```

Betiği içerik ekledikten veya kaldırdıktan sonra yeniden çalıştırın. Yalnızca normal dosya ve klasörleri listeler; gizli dosyaları ve sembolik bağlantıları atlar. Kendi oluşturduğu `bilgikutusu-index.html` dosyalarını günceller, aynı adlı elle hazırlanmış dosyaların üzerine yazmaz. Nginx örneği bu dosyayı klasör varsayılanı olarak kullanır.

## 7. Test

Servisler kurulu ve çalışır durumdaysa:

```bash
curl -I http://127.0.0.1:8081/
curl -I http://127.0.0.1:8080/
curl -I http://127.0.0.1:8081/kiwix/
```

Bu adresler yalnızca ilgili servisler belirtilen portlarda çalışıyorsa yanıt verir. İstemci cihazdan erişirken Pi'nin bağlandığınız ağdaki IP adresini kullanın. Farklı Wi-Fi arabirimlerinin farklı IP adresleri olabilir.
