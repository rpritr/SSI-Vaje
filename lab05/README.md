# Vaja 5: Naprednejše Bash skripte (funkcije, vnos podatkov, izračuni)

V tej vaji bomo uporabili funkcije, delo z uporabniškim vnosom, izračuni ter rekurzijo v Bash skriptah. Na koncu so dodane še dodatne naloge za izziv.

---

## **Vaja 1: Prikaz časa, datuma in prijavljenih uporabnikov**

1. Ustvarite skripto `system_info.sh`, ki izpiše:
   - trenutni datum
   - trenutni čas
   - aktivne prijavljene uporabnike

Primer skripte:

```bash
#!/bin/bash

echo "Trenutni datum: $(date +%Y-%m-%d)"
echo "Trenutni čas: $(date +%H:%M:%S)"
echo "Prijavljeni uporabniki:"
who
```

Zaženite skripto:

```bash
chmod +x system_info.sh
./system_info.sh
```

---

## **Vaja 2: Izračun povprečja ocen**

1. Ustvarite skripto `grades.sh`, ki:
   - omogoča uporabniku vnos poljubnega števila ocen
   - zaključi vnos, ko uporabnik vnese `0`
   - izračuna povprečje vseh vnesenih ocen (razen 0)

Primer skripte:

```bash
#!/bin/bash

sum=0
count=0
grade=1

echo "Vnašaj ocene (0 za konec):"

while [ $grade -ne 0 ]
do
    read grade
    if [ $grade -ne 0 ]; then
        sum=$((sum + grade))
        count=$((count + 1))
    fi
done

if [ $count -gt 0 ]; then
    echo "Povprečna ocena: $((sum / count))"
else
    echo "Ni vnešenih ocen."
fi
```

---

## **Vaja 3: Rekurzivna funkcija – Fakulteta**

Ustvarite skripto `fakulteta.sh`, ki:

1. prebere število od uporabnika  
2. uporabi **rekurzivno funkcijo**, ki izračuna fakulteto  
3. izpiše rezultat  

Primer:

```bash
#!/bin/bash

fakulteta() {
    if [ $1 -le 1 ]; then
        echo 1
    else
        local prev=$(fakulteta $(( $1 - 1 )))
        echo $(( $1 * prev ))
    fi
}

echo "Vnesi število:"
read num

rezultat=$(fakulteta $num)
echo "Fakulteta od $num je: $rezultat"
```

---

# **Dodatne vaje (za višji nivo)**

## **Dodatna vaja 1: Najdite največje vneseno število**

1. Ustvarite skripto `max_number.sh`, ki:
   - sprejema števila, dokler uporabnik ne vnese `stop`
   - shrani največje vneseno število
   - izpiše rezultat

---

## **Dodatna vaja 2: Preštejte pojavitev besede v datoteki**

Ustvarite skripto, ki:

- vpraša uporabnika za ime datoteke
- vpraša uporabnika za iskano besedo
- izpiše, kolikokrat se beseda pojavi v datoteki (grep + wc)

---

## **Dodatna vaja 3: Izpis vseh datotek z ekstenzijo**

Ustvarite skripto, ki:

- prebere ekstenzijo (npr. txt)
- izpiše vse datoteke s to končnico v trenutni mapi (find)

---

## **Dodatna vaja 4: Mini kalkulator**

Ustvarite skripto z menijem:

```
1 – seštevanje
2 – odštevanje
3 – množenje
4 – deljenje
0 – izhod
```

Skripta naj omogoča več izvajanj, dokler uporabnik ne izbere `0`.

---