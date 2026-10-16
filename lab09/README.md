# 🧩 Vaja 9: Projekt — Vzpostavitev dveh strežnikov v oblaku (Web + Work Server)

V zadnji vaji boste vzpostavili **dva popolnoma funkcionalna strežnika v oblaku**, konfigurirali spletni strežnik s CMS sistemom ter pripravili delovni/aplikativni strežnik z uporabniškimi skupinami, pravicami, deljenimi mapami, varnostnim kopiranjem ter orodjem za spremljanje delovanja.

Gre za celovit projekt, ki združuje vse vsebine predmeta.

---

# 🎯 **Cilji vaje**

- Vzpostaviti **dva Linux strežnika**
- Konfigurirati **spletni strežnik** z CMS (WordPress/Drupal/Joomla/Typo3…)
- Pripraviti **delovni strežnik** z uporabniki, skupinami, pravicami in skupnimi mapami
- Vzpostaviti **varnostne kopije med strežnikoma** (rsync + cron)
- Ustvariti skripte za kopiranje uporabniških podatkov
- Konfigurirati **firewall** in osnovne varnostne prakse
- Namestiti orodje za **network/statistics monitoring**
- Dokumentirati celoten potek z **zaslonskimi slikami in opisi**

---

# 🖥️ **STREŽNIK 1 — Web Server (Ubuntu 22.04 LTS)**

## 1. Vzpostavitev okolja
- Ustvari nov VM z Ubuntu 22.04 LTS
- Poskrbi za:
  - SSH dostop
  - posodobitve (`apt update && apt upgrade`)
  - namestitev firewalla (`ufw enable` + pravila)

## 2. Namestitev spletnega strežnika
Izberi eno izmed platform:

### ✔ LAMP (Apache2 + MariaDB + PHP)
ali  
### ✔ LEMP (Nginx + MariaDB + PHP-FPM)

## 3. Gostovanje CMS sistema

Izberi enega:
- **WordPress**
- Drupal
- Joomla
- Typo3

Naloge:
1. Ustvari domeno/poddomeno (lahko preko Okeanos DNS ali drugega DNS-ja)
2. Konfiguriraj VirtualHost
3. Namesti CMS
4. Poskrbi, da se stran naloži na naslov *http://moja-domena.tld*

## 4. Podpora za spletno trgovino
Izberi rešitev:
- WordPress → WooCommerce
- Drupal Commerce
- Joomla → VirtueMart
- Magento (če želiš napredno rešitev)

Namesti in preveri delovanje trgovine.

## 5. Firewall in varnost
- Dovoli: `80`, `443`, `22`
- Blokiraj vse ostalo
- Namesti **fail2ban**

---

# 🗄️ **STREŽNIK 2 — Work / Application Server (Ubuntu 20.04 LTS)**

## 1. Vzpostavitev okolja
- Nova VM z Ubuntu 20.04 LTS
- SSH dostop
- Posodobi sistem

## 2. Uporabniki in skupine

### Oddelki (skupine)
- vodstvo
- racunovodstvo
- operativa
- logistika
- proizvodnja
- informatika

### Uporabniki
Za vsakega zaposlenega:
- ustvari uporabnika
- dodaj ga v ustrezno skupino
- ustvari geslo
- omogoči dostop do domačega imenika

(Lahko pripraviš skripto npr. `users.sh`.)

## 3. Imeniki in pravice

### Struktura:
```
/srv/share/
    Vodstvo/
    Racunovodstvo/
    Operativa/
    Logistika/
    Proizvodnja/
    Informatika/
    skupno/
```

### Pravila:
- Vsaka mapa → dostop samo člani skupine
- Informatika → **sudo** + dostop do vsega
- `skupno/` → vsi lahko berejo in pišejo
- Lastništvo: `root:skupina`
- Pravice: `770` (razen skupno → `777` ali `775`)

---

# 🔄 **Varnostno kopiranje (Backup Sistem)**

Vzpostavi se na delovnem strežniku.

## 1. Dnevne, tedenske in mesečne kopije web strežnika

### Lokacije:
```
/root/backup/web/daily
/root/backup/web/weekly
/root/backup/web/monthly
/root/backup/log.txt
```

### Uporabi:
- `rsync`
- `cron`
- SSH ključe za avtomatski dostop

### Primer vnosa v cron:
Dnevno:
```
0 3 * * * rsync -avz root@WEB_SERVER:/var/www/ /root/backup/web/daily >> /root/backup/log.txt
```

Tedensko:
```
0 4 * * 1 rsync -avz root@WEB_SERVER:/var/www/ /root/backup/web/weekly >> /root/backup/log.txt
```

Mesečno:
```
0 5 1 * * rsync -avz root@WEB_SERVER:/var/www/ /root/backup/web/monthly >> /root/backup/log.txt
```

Log naj vsebuje:
- datum in uro
- tip kopije (daily/weekly/monthly)

---

# 👤 **Backup skripta za uporabnike**

Pripravi skripto:

`backup_user.sh USER`

Naloga skripte:
- sprejme ime uporabnika
- kopira njegov `/home/USER` v:

```
/root/backup/operational/USER/
```

- uporabi rsync
- zapiše log operacije

---

# 📡 **Monitoring strežnika**

Izberi orodje in ga namesti:
- **Netdata** (priporočeno – zelo enostavno)
- Zabbix agent
- Prometheus node exporter
- Glances

Argumentiraj:
- zakaj si izbral ravno to orodje
- kako omogoča spremljanje obremenitve, RAM, CPU, I/O, mreže …

---

# ✔️ **Končni rezultat**

Po zaključku mora biti vzpostavljeno:

### ■ Web Server:
- delujoča spletna stran (CMS)
- delujoča spletna trgovina
- pravilno nastavljen firewall
- HTTPS (priporočljivo Let's Encrypt)

### ■ Work Server:
- vsi uporabniki + skupine
- strukturirani imeniki z dovoljenji
- skupna mapa
- avtomatske varnostne kopije
- skripta za kopiranje uporabnikov
- monitoring sistem

### ■ Oba strežnika:
- dostopna prek SSH
- dokumentirana postavitev z zaslonskimi slikami

---

# 📝 **Oddaja**

Oddate:
- PDF dokumentacijo (opis + slike)
- glavne konfiguracijske datoteke
- skripte (npr. backup, users.sh)
- seznam uporabljenih ukazov
- IP naslova obeh strežnikov
- dostop (uporabnik + geslo ali ključ)