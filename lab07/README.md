# Vaja 7: Napredna Bash skripta – delo z datotekami, filtri in orodji ukazne vrstice

Cilj te vaje je, da ponovimo delo z Bash in uporabimo znanje za kreiranje malce bolj **napredne skripte**.

➡️ Vaša naloga je napisati **eno ukazno skripto**, npr. `vaja3.sh`, ki **zaporedno izvede vse spodnje naloge**.

Lahko si pomagate tako, da za vsako nalogo najprej pripravite svojo skripto, nato pa jih združite v eno samo glavno skripto.

---

## Naloga 1: Ustvarjanje datotek

1. Ustvarite direktorij z imenom `VajaBash`.
2. V tem direktoriju ustvarite **5 praznih datotek** z imeni:
   - `file1.txt`
   - `file2.txt`
   - `file3.txt`
   - `file4.txt`
   - `file5.txt`

Datotek **ne ustvarjajte ročno**, ampak jih generirajte s skripto s pomočjo **sekvence**.

Primer (znotraj skripte):

```bash
mkdir -p VajaBash

for i in {1..5}
do
    touch "VajaBash/file${i}.txt"
done
```

---

## Naloga 2: Preimenovanje datotek

Preimenujte vse datoteke v mapi `VajaBash` tako, da jim dodate pripono `_old` **pred končnico** `.txt`.

Primer:  
`file1.txt` → `file1_old.txt`

Primer rešitve:

```bash
cd VajaBash

for f in file*.txt
do
    mv "$f" "${f%.txt}_old.txt"
done

cd ..
```

---

## Naloga 3: Izpis direktorija

Izpišite vsebino direktorija `VajaBash` v datoteko `seznam_datotek.txt`.

```bash
ls VajaBash > seznam_datotek.txt
```

---

## Naloga 4: Dodajanje vsebine v datoteke

V direktoriju `VajaBash`:

1. V datoteko `file1_old.txt` dodajte niz:

```bash
echo "Vsebina za iskanje z grep." >> VajaBash/file1_old.txt
```

2. Z ukazom `wget` ali `curl` pridobite vsebino iz naslova:

`http://metaphorpsum.com/paragraphs/3/5`

in to **dopiši** v `file1_old.txt`:

```bash
wget -qO- http://metaphorpsum.com/paragraphs/3/5 >> VajaBash/file1_old.txt
# ali
curl -s http://metaphorpsum.com/paragraphs/3/5 >> VajaBash/file1_old.txt
```

3. V `file2_old.txt` zapišite niz:

```bash
echo "Poglejte me z grep." >> VajaBash/file2_old.txt
```

4. V `file3_old.txt` zapišite niz:

```bash
echo "Šteje me z wc." >> VajaBash/file3_old.txt
```

5. V `file4_old.txt` zapišite niz:

```bash
echo "Računam s bc -l" >> VajaBash/file4_old.txt
```

6. V `file5_old.txt` zapišite niz:

```bash
echo "Spreminjam s tr." >> VajaBash/file5_old.txt
```

---

## Naloga 5: Filtriranje in obdelava z grep, find, wc, bc in tr

1. Uporabite `grep`, da poiščete **vse datoteke** v `VajaBash`, ki vsebujejo besedo `"grep"`, in rezultate zapišite v `grep_rezultati.txt`:

```bash
grep -r "grep" VajaBash > grep_rezultati.txt
```

2. Uporabite `find` (v kombinaciji z `grep`), da poiščete **vse datoteke**, ki vsebujejo niz `"bc -l"`, in jih zapišite v `bc_datoteke.txt`:

```bash
find VajaBash -type f -exec grep -l "bc -l" {} \; > bc_datoteke.txt
```

3. Uporabite `wc`, da preštejete število besed v `file3_old.txt` in rezultat zapišeš v `stevilo_besed_file3.txt`:

```bash
wc -w VajaBash/file3_old.txt > stevilo_besed_file3.txt
```

4. Uporabite `bc` oziroma `bc -l`, da izračunate **kvadratni koren števila 16** in rezultat zapišeš v `kvadratni_koren.txt`:

```bash
echo "sqrt(16)" | bc -l > kvadratni_koren.txt
```

5. Uporabite `tr`, da v datoteki `file5_old.txt` **spremenite vse črke `a` v `A`**:

```bash
tr 'a' 'A' < VajaBash/file5_old.txt > VajaBash/file5_old_tmp.txt
mv VajaBash/file5_old_tmp.txt VajaBash/file5_old.txt
```

---

## Naloga 6: Izpis vsebine datotek (head in tail)

1. Uporabite `head`, da izpišete **prvi 2 vrstici** datoteke `file1_old.txt` in rezultat zapišete v `prve_dve_vrstici.txt`:

```bash
head -n 2 VajaBash/file1_old.txt > prve_dve_vrstici.txt
```

2. Uporabite `tail`, da izpišeš **zadnje 3 vrstice** datoteke `file2_old.txt` in rezultat zapišete v `zadnje_tri_vrstice.txt`:

```bash
tail -n 3 VajaBash/file2_old.txt > zadnje_tri_vrstice.txt
```

---

## Naloga 7: Povprečna dolžina znakov datotek z `old` v imenu

1. V datoteki `seznam_datotek.txt` poiščite vse datoteke, ki vsebujejo `old` v imenu.
2. Za vsako izmed teh datotek izračunajte **dolžino znakov**.
3. Rezultate zapišite v `povprecna_dolzina.txt`.
4. Na koncu izračunajte **povprečno dolžino znakov** in jo dopišite v isto datoteko.

Namig – možen pristop:

```bash
files=$(grep "old" seznam_datotek.txt)

> povprecna_dolzina.txt
total=0
count=0

for f in $files
do
    len=$(wc -m < "VajaBash/$f")
    echo "$f $len" >> povprecna_dolzina.txt
    total=$((total + len))
    count=$((count + 1))
done

if [ $count -gt 0 ]; then
    avg=$((total / count))
    echo "Povprečna dolžina: $avg" >> povprecna_dolzina.txt
fi
```

---

## Naloga 8: Arhiviranje datotek

1. Ustvarite direktorij `Arhiv`:

```bash
mkdir -p Arhiv
```

2. Kopirajte vse datoteke v `VajaBash`, ki imajo v imenu niz `old`, v direktorij `Arhiv`:

```bash
cp VajaBash/*old* Arhiv/
```

3. Ustvarite ZIP arhiv vseh datotek v direktoriju `VajaBash` z imenom `arhiv.zip`:

```bash
zip -r arhiv.zip VajaBash
```

---

## Preverjanje pravilnosti

Za preverjanje vaje uporabite skripto `preveri.sh`, ki jo pridobite z:

```bash
wget -O preveri.sh https://pastebin.com/raw/ygTeNuSg
```

Pred zagonom je potrebno popraviti **CRLF endline**:

```bash
sed -i 's/
$//' preveri.sh
```

Nato skripto zaženite:

```bash
bash preveri.sh
```

📤 **Oddaja:**  
Oddajte vsebino izpisa skripte `preveri.sh` (npr. prekopirano iz terminala ali preusmerjeno v datoteko).
