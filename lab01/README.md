# 🧩 Vaja 1: Osnove dela v Linux okolju

## 🎯 Namen vaje
Cilj te vaje je spoznati osnovne ukaze in delo v ukazni vrstici Linux operacijskega sistema.  
Pogledali bomo kako:
- ustvarjati mape in datoteke,  
- izpisovati vsebino datotek in imenikov,  
- pridobivati sistemske informacije,  
- uporabljati osnovne mrežne ukaze.

---

## 🧱 Predpogoji

Vajo opravite na **Linux strežniku**.  
Vse ukaze v tej vaji izvajate v mapi `lab01`.

### GitHub Codespaces

1. Najprej **forkajte** repozitorij na svoj GitHub račun (gumb **Fork**).
2. Odprite **svoj fork** in v njem ustvarite Codespace: **Code → Codespaces → Create codespace**.
3. V terminalu Codespaces se premaknite v mapo vaje:

   ```bash
   cd lab01
   ```

### Linux strežnik

1. Ustvarite Linux strežnik (npr. Ubuntu Server) in se nanj povežite preko SSH:

   ```bash
   ssh uporabnisko_ime@ip_naslov
   ```

2. Klonirajte repozitorij in se premaknite v mapo vaje:

   ```bash
   git clone https://github.com/rpritr/SSI-Vaje.git
   cd SSI-Vaje/lab01
   ```

Če terminal kasneje odprete znova, se pred nadaljevanjem vrnite v mapo `lab01`.

---

## 🧮 Vaja 1.1: Uporaba osnovnih Linux ukazov

Ukaze izvajajte v mapi `lab01`.

1. Izpišite trenutni imenik in preverite, da ste v `lab01`:
   ```bash
   pwd
   ```
2. V mapi `lab01` ustvarite mapo `vaje` in v njej podmapo `vaja1`:
   ```bash
   mkdir -p vaje/vaja1
   ```
3. Ustvarite datoteko `vaja1.txt`:
   ```bash
   touch vaje/vaja1/vaja1.txt
   ```
4. V datoteko `vaja1.txt` kopirajte besedilo navodil za vajo.  
5. Izpišite vsebino datoteke v terminal:
   ```bash
   cat vaje/vaja1/vaja1.txt
   ```
6. Izpišite vsebino korenskega imenika:
   ```bash
   ls /
   ```
7. Preverite velikost datoteke `vaja1.txt`:
   ```bash
   ls -lh vaje/vaja1/vaja1.txt
   ```
8. Ustvarite datoteko `log.txt` in vanjo zapišite seznam datotek v imeniku `vaja1`:
   ```bash
   ls vaje/vaja1 > vaje/vaja1/log.txt
   ```
9. V isto datoteko dodajte izhod ukaza `df -h`:
   ```bash
   df -h >> vaje/vaja1/log.txt
   ```
10. Preverite dosegljivost strežnika `vss.scv.si`:
    ```bash
    ping -c 5 vss.scv.si
    ```
    Če ukaz `ping` ni na voljo (paket ni nameščen), ga namestite:
    ```bash
    sudo apt update
    sudo apt install iputils-ping
    ```
11. Zapišite IP naslov strežnika v datoteko `vaja1.txt`.
12. Rezultate konzolnega izpisa shranite v datoteko:
    ```
    ime_priimek_vaja1_1.txt
    ```
    in jo oddaj v spletno učilnico.

---

## 💻 Vaja 1.2: Pridobivanje podatkov o sistemu

Ukaze izvajajte v mapi `lab01`.

1. Izpišite osnovne informacije o sistemu:
   ```bash
   uname -a > system_info.txt
   ```
2. Dodajte trenutni datum in čas:
   ```bash
   date >> system_info.txt
   ```
3. Dodajte informacijo o trenutno prijavljenih uporabnikih:
   ```bash
   who >> system_info.txt
   ```
4. Dodajte informacijo, koliko časa je sistem aktiven:
   ```bash
   uptime >> system_info.txt
   ```
5. Preglejte vsebino datoteke:
   ```bash
   cat system_info.txt
   ```
6. Ustvarite datoteko `user_list.txt` s seznamom vseh uporabnikov:
   ```bash
   cat /etc/passwd > user_list.txt
   ```
7. Preverite vsebino datoteke:
   ```bash
   cat user_list.txt
   ```
8. Rezultate konzolnega izpisa shranite v datoteko:
   ```
   ime_priimek_vaja1_2.txt
   ```

---

## ⚙️ Vaja 1.3: Pridobivanje podatkov o strojni opremi

Ukaze izvajajte v mapi `lab01`.

1. Preverite, da ste v mapi `lab01` (`pwd`).  
2. Ustvarite novo datoteko `strojna_oprema.txt`.  
3. V datoteko dodajte rezultate naslednjih ukazov:
   ```bash
   lscpu >> strojna_oprema.txt          # podatki o procesorju
   free -m >> strojna_oprema.txt        # podatki o pomnilniku
   cat /proc/interrupts >> strojna_oprema.txt  # prekinitve naprav
   lshw >> strojna_oprema.txt           # podrobnosti o strojni opremi
   lsblk >> strojna_oprema.txt          # bločne naprave
   df -h >> strojna_oprema.txt          # uporaba prostora
   lspci >> strojna_oprema.txt          # PCI naprave
   lsusb >> strojna_oprema.txt          # USB naprave
   ```
4. Preglejte vsebino datoteke:
   ```bash
   cat strojna_oprema.txt
   ```
5. Rezultate konzolnega izpisa shranite v datoteko:
   ```
   ime_priimek_vaja1_3.txt
   ```
---

## 🔗 Viri in namigi
- [Ubuntu – Ukazna vrstica](https://help.ubuntu.com/community/UsingTheTerminal)  
- [Prepoznavanje strojne opreme v Ubuntuju (sl)](https://sl.ubunlog.com/prepozna-strojno-opremo-v-ubuntuju/)  
- [Osnovni Linux ukazi](https://linuxcommand.org/lc3_learning_the_shell.php)

---
