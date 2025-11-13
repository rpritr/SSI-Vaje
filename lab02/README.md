# Vaja 2: Dovoljenja in delo z arhivi v Linuxu

## Vaja 1: CHMOD tabele

Izpolnite tabelo za spodnje primere ukazov:

### Pretvorba CHMOD ukazov v simbolni zapis

| Ukaz | Simbolne pravice |
|------|------------------|
| `chmod 121 primer1.txt` | ---w--x--x |
| `chmod 355 primer2` | -wxr-xr-x |
| `chmod 057 primer3.txt` | ----rwxrwx |
| `chmod 645 primer3` | rw-r--r-x |
| `chmod 771 primer4.txt` | rwxrwx--x |
| `chmod 237 primer5.txt` | -w--wxrwx |

### Pretvorba iz simbolnih pravic v oktalno vrednost

| Simbolne pravice | Oktalna vrednost |
|------------------|------------------|
| `-rwxr--r-- primer1.txt` | 744 |
| `-rw-r--rwx primer2.txt` | 457 |
| `-rwxrw-r-- primer3.txt` | 764 |
| `drw-r--r-- primer4` | 640 |
| `-r-xr--r-- primer5.txt` | 544 |
| `-rw-rwxr-- primer6.txt` | 674 |
| `dr--rwxr-x primer7` | 356 |
| `-rwxrw-r-x primer8.txt` | 675 |
| `-r--rw-rwx primer9.txt` | 467 |
| `-rw-r-xrwx primer10.txt` | 457 |

---

## Vaja 2: Osnovna uporaba ukaza chmod

### 1. Ustvarite datoteko
```bash
touch test.txt
```

### 2. Preverite dovoljenja
```bash
ls -l test.txt
```
**Kaj pomenijo deli izpisa?**
- 1. znak: tip (npr. `-` datoteka, `d` mapa)
- Nato 3× po 3 znaki: pravice za **lastnika**, **skupino**, **ostale**
- Nato: lastnik, skupina, velikost, datum, ime

### 3. Odstranite dovoljenja pisanja za vse uporabnike
```bash
chmod a-w test.txt
ls -l test.txt
```

### 4. Dovolite pravice samo lastniku (rwx) — oktalno
```bash
chmod 700 test.txt
```

---

## Upravljanje dovoljenj za skupino

### 1. Ustvarite mapo
```bash
mkdir my_folder
```

### 2. Nastavite dovoljenja (lastnik: rw-, skupina: r-x, ostali: ---)
```bash
chmod u=rw,g=rx,o= my_folder
```

---

## Uporaba chmod z mapo in podmapami

### 1. Ustvarite mapo in datoteke
```bash
mkdir project
touch project/file1.txt project/file2.txt
```

### 2. Rekurzivno dodelite vsem uporabnikom rw
```bash
chmod -R 666 project
```

---

## Vaja 3: Uporaba ukaza zip in unzip

### Ustvarite arhiv
```bash
mkdir archive_test
touch archive_test/file1.txt archive_test/file2.txt archive_test/file3.txt
zip -r archive.zip archive_test
zip -l archive.zip
```

### Razpakirajte arhiv
```bash
unzip archive.zip -d extracted_archive
```

---

## Vaja 4: Uporaba ukaza tar

### Ustvarite tar arhiv
```bash
mkdir tar_test
touch tar_test/file1.txt tar_test/file2.txt
tar -cvf archive.tar tar_test
```

---

## Vaja 5: Uporaba head in tail

### Prikaz prvih vrstic
```bash
head long_text.txt
head -n 20 long_text.txt
```

### Prikaz zadnjih vrstic
```bash
tail long_text.txt
tail -n 5 long_text.txt
```

---

## Vaja 6: Razmislek in vprašanja

1. Kako preverite dovoljenja za datoteko?  
   → `ls -l <ime>`

2. Razlika med simbolnim in oktalnim načinom chmod:  
   - *Simbolni*: `chmod u+r,g-w`  
   - *Oktalni*: `chmod 754`

3. Razlika med zip in tar:  
   - **zip** kompresira vsako datoteko posebej,  
   - **tar** samo zapakira; kompresija je ločena (`tar.gz`).

4. Kako prepoznati tip datoteke?  
   → `file <ime>`

5. Kako prikazati vrstice 11–20?  
   → `head -n 20 file | tail -n 10`

