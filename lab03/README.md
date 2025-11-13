# Vaja: Uporaba več ukazov in preusmeritev za obdelavo podatkov

V tej vaji boš uporabil več osnovnih ukazov v Linux lupini za delo z datotekami in številskimi zaporedji:  
`seq`, `sort`, `wc`, `grep`, `find`, `echo`, `bc`, preusmeritve (`>`, `>>`), cevi (`|`), `paste` in logične povezave (`&&`).

---

## 1. Generiranje in obdelava zaporedij s `seq`, `sort` in `wc`

1. Uporabi ukaz **`seq`**, da generiraš zaporedje števil od 1 do 100 in ga shraniš v datoteko `numbers.txt`:

```bash
seq 1 100 > numbers.txt
```

2. Preštej število vrstic v datoteki `numbers.txt` z uporabo ukaza **`wc`**:

```bash
wc -l numbers.txt
```

3. Uporabi ukaz **`sort`**, da razvrstiš datoteko `numbers.txt` v padajočem vrstnem redu in rezultat shraniš v novo datoteko `numbers_sorted.txt`:

```bash
sort -nr numbers.txt > numbers_sorted.txt
```

*(Opcijsko lahko prepišeš izvorno datoteko, a za vajo je pregledneje imeti novo datoteko.)*

---

## 2. Filtriranje in iskanje z `grep` in `find`

1. Uporabi ukaz **`grep`**, da iz datoteke `numbers_sorted.txt` prikažeš samo vrstice, ki vsebujejo števila večja od 90:

Primer z razširjenimi regularnimi izrazi:

```bash
grep -E '9[1-9]|100' numbers_sorted.txt
```

2. Uporabi ukaz **`find`**, da poiščeš vse datoteke, ki se končajo z `.txt` v trenutni mapi:

```bash
find . -maxdepth 1 -type f -name "*.txt"
```

---

## 3. Preusmeritev izhoda z `echo`, `>`, `>>` in uporabo `bc`

1. Ustvari datoteko `math_results.txt` z nekaj preprostimi izrazi in njihovimi rezultati.

### a) Zapiši izraz v datoteko (prepiše vsebino)

```bash
echo "2+2" > math_results.txt
echo "3*5" >> math_results.txt
echo "10/4" >> math_results.txt
```

### b) Uporabi `bc`, da izračunaš vrednosti izrazov

Uporabi ukazno lupino tako, da vsak izraz pošlješ v `bc` in rezultat dodaš v datoteko:

```bash
echo "2+2" | bc >> math_results.txt
echo "3*5" | bc >> math_results.txt
echo "10/4" | bc >> math_results.txt
```

2. Odpri datoteko `math_results.txt` in preveri rezultate:

```bash
cat math_results.txt
```

---

## 4. Uporaba cevi `|`, ukaza `paste` in logične povezave `&&`

1. Generiraj dve ločeni zaporedji števil od 1 do 10 in ju shrani v `seq1.txt` in `seq2.txt`:

```bash
seq 1 10 > seq1.txt
seq 1 10 > seq2.txt
```

2. Združi datoteki `seq1.txt` in `seq2.txt` v eno datoteko z ukazom **`paste`** (ustvari npr. `combined.txt`):

```bash
paste seq1.txt seq2.txt > combined.txt
```

3. Uporabi **`grep`** in cev **`|`**, da iz datoteke `combined.txt` prikažeš samo vrstice, ki vsebujejo število `5`:

```bash
grep "5" combined.txt
```

4. Uporabi logično povezavo **`&&`**, da prikažeš sporočilo *»Datoteka je bila uspešno ustvarjena«*, če je bila datoteka `combined.txt` uspešno ustvarjena:

```bash
[ -f combined.txt ] && echo "Datoteka je bila uspešno ustvarjena"
```

---

## 5. Uporaba `wc` za analizo datotek

1. Uporabi ukaz **`wc`**, da prešteješ število vrstic, besed in znakov v datoteki `combined.txt`:

```bash
wc combined.txt
```

2. Uporabi cev **`|`**, da najprej izpišeš vse vrstice, ki vsebujejo število `7` v datoteki `combined.txt`, in nato prešteješ te vrstice z ukazom `wc -l`:

```bash
grep "7" combined.txt | wc -l
```

---

## Dodatna vprašanja za razmislek

- Kakšna je razlika med preusmeritvijo `>` in `>>`?
- Kdaj je bolj smiselno uporabiti cev `|` namesto preusmeritve v datoteko?
- Kako bi razširil to vajo, da bi obdeloval tudi nizi (besedilo) in ne samo števil?
