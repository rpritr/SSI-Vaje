# 🧩 Vaja 7: Namestitev LAMP (Apache2, MySQL, PHP) in skripta za Virtual Host

## 🎯 Namen vaje
Vzpostaviti osnovni spletni strežnik (LAMP sklad) na Ubuntu strežniku ter pripraviti **skripto za avtomatsko ustvarjanje Apache VirtualHost** konfiguracij za nove domene/projekte.

---

## 🧱 Predpogoji

Vajo opravite na **Linux strežniku**.  
Ukaze izvajate v mapi `lab08`. Veljaven DNS zapis za domeno ni potreben.

### GitHub Codespaces

1. Najprej **forkajte** repozitorij na svoj GitHub račun (gumb **Fork**).
2. Odprite **svoj fork** in v njem ustvarite Codespace: **Code → Codespaces → Create codespace**.
3. V terminalu se premaknite v mapo vaje:

   ```bash
   cd lab08
   ```

Codespaces nima **systemd**. Storitve zaženite z `sudo service ... start`, ne s `systemctl`.  
Po ponovnem odprtju Codespaces Apache in MySQL znova zaženite z ukazoma `sudo service apache2 start` in `sudo service mysql start`.

Spletno stran v Codespaces odprete tako, da v zavihku **Ports** ročno vpišete vrata **80** (gumb **Forward a Port** → v polje vpišite `80`). Vrstica se pojavi na seznamu; stran odprete z ikono globusa v tej vrstici. Naslova ne sestavljajte na roko. Požarnega zidu UFW v Codespaces ne vklapljajte.

### Linux strežnik preko SSH

1. Ustvarite Linux strežnik (npr. Ubuntu Server) in se nanj povežite preko SSH:

   ```bash
   ssh uporabnisko_ime@ip_naslov
   ```

2. Klonirajte repozitorij in se premaknite v mapo vaje:

   ```bash
   git clone https://github.com/rpritr/SSI-Vaje.git
   cd SSI-Vaje/lab08
   ```

Če strežnik uporablja systemd, lahko storitve omogočite ob zagonu (`sudo systemctl enable apache2` in `sudo systemctl enable mysql`). Stran odprete na `http://<IP_STREZNIKA>/`.

---

## 🧮 Vaja 2.1: Namestitev Apache2, MySQL in PHP (LAMP)

1) Posodobi seznam paketov in namesti **Apache2**:
```bash
sudo apt update
sudo apt -y install apache2
sudo service apache2 start
```

2) Če na strežniku teče požarni zid **UFW**, odpri dostop za Apache:
```bash
sudo ufw allow 'Apache Full'
sudo ufw status
```

3) Namesti **MySQL** in ga zaženi:
```bash
sudo apt -y install mysql-server
sudo service mysql start
sudo mysql_secure_installation
```
> V čarovniku nastavite geslo za **root** (oz. izberite varnostne nastavitve po navodilih).  
> Na Ubuntu se lahko v MySQL prijavite tudi brez gesla: `sudo mysql` (prijava prek sistemskega uporabnika). Če čarovnik javi napako, nadaljujte s tem ukazom.

4) (Neobvezno) Ustvari bazo in uporabnika za prihodnji projekt:
```bash
sudo mysql -e "CREATE DATABASE projekt_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'projekt_user'@'localhost' IDENTIFIED BY 'ZamenjajMocnoGeslo#1';"
sudo mysql -e "GRANT ALL PRIVILEGES ON projekt_db.* TO 'projekt_user'@'localhost'; FLUSH PRIVILEGES;"
```
> Geslo mora ustrezati politiki MySQL: velike in male črke, številka in poseben znak. Znaka `!` ne uporabljajte. Bash ga v dvojnih narekovajih razume kot sklic na zgodovino (`event not found`), ukaz se prekine in uporabnik se ne ustvari. `GRANT` nato javi napako, ker uporabnika še ni.

5) Namesti **PHP** in povezovalne module:
```bash
sudo apt -y install php libapache2-mod-php php-mysql php-cli php-curl php-xml php-mbstring
sudo service apache2 restart
php -v
```

6) Preveri PHP s testno datoteko:
```bash
echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/info.php > /dev/null
curl -I http://127.0.0.1/info.php
```
- V brskalniku odprite `http://<IP_STREZNIKA>/info.php`.
- Če strežnik nima javnega naslova: v zavihku **Ports** vpišite `80` (**Forward a Port**), odprite naslov z ikono globusa in na konec dodajte `/info.php`.

---

## ⚙️ Vaja 2.2: Skripta za ustvarjanje VirtualHost (vhost)

V tej nalogi boš pripravil skripto **create-vhost.sh**, ki:
- ustvari **/etc/apache2/sites-available/<domena>.conf**,
- pripravi projektno mapo **/var/www/<domena>/public_html**,
- ustvari testni *index.html*,
- omogoči stran (`a2ensite`), vklopi **mod_rewrite**, preveri konfiguracijo in **reload**-a Apache.

> **Opomba o preusmeritvi (>>):** `sudo echo "...">> /etc/...` pogosto **ne deluje**, ker `>>` izvede lupina brez sudo. Uporabite **heredoc** s `sudo tee`.

Ustvari datoteko in vanjo prilepi vsebino:

```bash
nano create-vhost.sh
```

Vsebina skripte (izboljšana, idempotentna in z validacijami):

```bash
#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Uporaba: sudo $0 domena.tld [document_root]"
  exit 1
fi

DOMAIN="$1"
DOCROOT="${2:-/var/www/$DOMAIN/public_html}"
SITES_AVAILABLE="/etc/apache2/sites-available"
CONF_FILE="$SITES_AVAILABLE/$DOMAIN.conf"

echo ">>> Ustvarjam VirtualHost za: $DOMAIN"
echo ">>> DocumentRoot: $DOCROOT"

# Ustvari document root
sudo mkdir -p "$DOCROOT"

# Osnovna vsebina strani
if [[ ! -f "$DOCROOT/index.html" ]]; then
  echo "<!doctype html><title>$DOMAIN</title><h1>$DOMAIN</h1>" | sudo tee "$DOCROOT/index.html" >/dev/null
fi

# Nastavi lastništvo in pravice (po potrebi prilagodi uporabnika)
sudo chown -R "$USER":www-data "/var/www/$DOMAIN"
sudo find "/var/www/$DOMAIN" -type d -exec chmod 755 {} \;
sudo find "/var/www/$DOMAIN" -type f -exec chmod 644 {} \;

# Ustvari VirtualHost .conf
sudo tee "$CONF_FILE" >/dev/null <<EOF
<VirtualHost *:80>
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN
    DocumentRoot $DOCROOT

    ErrorLog \${APACHE_LOG_DIR}/${DOMAIN}_error.log
    CustomLog \${APACHE_LOG_DIR}/${DOMAIN}_access.log combined

    <Directory $DOCROOT>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF

echo ">>> Omogočam mod_rewrite in stran..."
sudo a2enmod rewrite >/dev/null
sudo a2ensite "$DOMAIN.conf" >/dev/null

echo ">>> Preverjam sintakso Apache..."
sudo apache2ctl configtest

echo ">>> Reload Apache..."
sudo service apache2 reload

echo ">>> Končano. Preveri: http://$DOMAIN/"
echo ">>> Na strežniku v /etc/hosts dodaj  127.0.0.1  $DOMAIN www.$DOMAIN  in preveri s curl."
echo ">>> Na svojem računalniku lahko v /etc/hosts dodaš  <IP_STREZNIKA>  $DOMAIN www.$DOMAIN"
```

Skripto naredi izvršljivo in jo zaženi (z **sudo**):
```bash
chmod +x create-vhost.sh
sudo ./create-vhost.sh primer.test
```

Preverite VirtualHost **na strežniku**:

```bash
echo "127.0.0.1 primer.test www.primer.test" | sudo tee -a /etc/hosts
curl -I http://primer.test/
```

Isto domeno lahko odprete tudi v brskalniku na svojem računalniku. V `/etc/hosts` na računalniku dodajte:

```bash
echo "<IP_STREZNIKA> primer.test www.primer.test" | sudo tee -a /etc/hosts
```

Če stran odpirate prek zavihka **Ports**, brskalnik ne uporabi imena `primer.test`. Da vidite stran VirtualHosta, onemogočite privzeto stran (Apache jo nato uporabi za vsak zahtevek na vratih 80):

```bash
sudo a2dissite 000-default.conf
sudo service apache2 reload
```

Nato v zavihku **Ports** znova odprite vrata **80** (če jih na seznamu ni, jih vpišite z **Forward a Port**). V brskalniku se pokaže `index.html` domene `primer.test`. Datoteka `/info.php` je na privzeti strani v `/var/www/html` in po tem koraku ni več prikazana.

### ✅ Dodatno (neobvezno): onemogoči privzeto stran in omogoči HTTPS

```bash
sudo a2dissite 000-default.conf
sudo service apache2 reload

# Če ima domena javni DNS in je dostopna iz interneta:
# sudo apt -y install certbot python3-certbot-apache
# sudo certbot --apache -d primer.tld -d www.primer.tld
```

Certbot uporabite le, če ima domena javni DNS. Če stran odpirate prek zavihka **Ports**, je povezava že šifrirana.

---

## 🧪 Preverjanje delovanja
- `curl -I http://primer.test/` mora vrniti **HTTP/1.1 200 OK**
- Dnevnik napak: `/var/log/apache2/<domena>_error.log`
- Dnevnik dostopov: `/var/log/apache2/<domena>_access.log`
- PHP test: `/info.php` (v brskalniku `http://<IP_STREZNIKA>/info.php`, oziroma v zavihku **Ports** vpišite `80`)

---

## 📦 Oddaja
1. V konzolo izpiši ključne korake in rezultate (namestitev paketov, `apache2ctl configtest`, uspešen reload).
2. Shrani izpis v datoteko **ime_priimek_vaja2.txt** (npr. z `script` ali preusmeritvijo `2>&1 | tee`).
3. Oddaj **ime_priimek_vaja2.txt** in **create-vhost.sh** v spletno učilnico.

---

## 🧰 Reševanje pogostih težav
- `System has not been booted with systemd` → ste v Codespaces. Namesto `systemctl` uporabite `sudo service apache2 start` in `sudo service mysql start`.
- Po ponovnem odprtju Codespaces storitvi ne tečeta sami od sebe. Znova ju zaženite z `service`.
- Brskalnik javi, da strani ni → v zavihku **Ports** vpišite `80` (**Forward a Port**) in odprite naslov z ikono globusa. Apache mora teči (`sudo service apache2 start`).
- `sudo echo ... >> /etc/...` ne deluje → uporabi **sudo tee** z **heredoc** (kot v skripti).
- `AH00558: apache2: Could not reliably determine the server's fully qualified domain name` → nastavi `ServerName` globalno v `/etc/apache2/apache2.conf` ali v vhost.
- **403 Forbidden** → preveri pravice in `<Directory>` blok v vhostu.
- **500 / .htaccess** → preveri sintakso `.htaccess` ter omogočen `AllowOverride All`.
- Po spremembah vedno: `sudo apache2ctl configtest && sudo service apache2 reload`.

---

## Opombe

**Uporaba AI:** Pri razvoju vsebine in pripravi dokumentacije je bilo uporabljeno orodje ChatGPT (OpenAI), ki je služilo kot pomoč pri generiranju idej, optimizaciji kode in oblikovanju besedil.  
Vse končne rešitve so bile pregledane, preverjene in po potrebi prilagojene s strani avtorja projekta.

## Reference

OpenAI, (2025), *ChatGPT* (Aug 2025) [Large language model], https://chat.openai.com/