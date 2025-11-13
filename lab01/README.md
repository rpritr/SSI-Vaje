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
- Ustvarjen Linux strežnik (npr. Ubuntu Server) v **Microsoft Azure** okolju  
- Dostop do strežnika preko **SSH protokola**

---

## 🧮 Vaja 1.1: Uporaba osnovnih Linux ukazov

1. Preko SSH se povežite na svoj strežnik:
   ```bash
   ssh uporabnisko_ime@ip_naslov
   ```
2. Prijavite se s svojim uporabniškim imenom in geslom.
3. Izpišite trenutni imenik:
   ```bash
   pwd
   ```
4. V domačem imeniku ustvarite mapo `vaje` in v njej podmapo `vaja1`:
   ```bash
   mkdir -p ~/vaje/vaja1
   ```
5. Ustvarite datoteko `vaja1.txt`:
   ```bash
   touch ~/vaje/vaja1/vaja1.txt
   ```
6. V datoteko `vaja1.txt` kopirajte besedilo navodil za vajo.  
7. Izpišite vsebino datoteke v terminal:
   ```bash
   cat ~/vaje/vaja1/vaja1.txt
   ```
8. Izpišite vsebino korenskega imenika:
   ```bash
   ls /
   ```
9. Preverite velikost datoteke `vaja1.txt`:
   ```bash
   ls -lh ~/vaje/vaja1/vaja1.txt
   ```
10. Ustvarite datoteko `log.txt` in vanjo zapišite seznam datotek v imeniku `vaja1`:
    ```bash
    ls ~/vaje/vaja1 > ~/vaje/vaja1/log.txt
    ```
11. V isto datoteko dodajte izhod ukaza `df -h`:
    ```bash
    df -h >> ~/vaje/vaja1/log.txt
    ```
12. Preverite dosegljivost strežnika `vss.scv.si`:
    ```bash
    ping -c 5 vss.scv.si
    ```
13. Zapišite IP naslov strežnika v datoteko `vaja1.txt`.
14. Iz izpisa `ping` zabeleži **min, max in avg** vrednosti ter število poslanih in prejetih paketov.
15. Rezultate konzolnega izpisa shranite v datoteko:
    ```
    ime_priimek_vaja1_1.txt
    ```
    in jo oddaj v spletno učilnico.

---

## 💻 Vaja 1.2: Pridobivanje podatkov o sistemu

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

1. Povežite se na svoj Linux strežnik preko SSH.  
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
