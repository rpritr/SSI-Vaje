#!/bin/bash

# Preverimo, ali obstaja direktorij "VajaBash"
if [ -d "VajaBash" ]; then
  echo "Naloga 1: Ustvarjanje datotek - Uspešno"
else
  echo "Naloga 1: Ustvarjanje datotek - Ni uspelo"
fi

# Preverimo, ali so datoteke v direktoriju "VajaBash" pravilno preimenovane
if [ -f "VajaBash/file1_old.txt" ] && [ -f "VajaBash/file2_old.txt" ] && [ -f "VajaBash/file3_old.txt" ] && [ -f "VajaBash/file4_old.txt" ] && [ -f "VajaBash/file5_old.txt" ]; then
  echo "Naloga 2: Preimenovanje datotek - Uspešno"
else
  echo "Naloga 2: Preimenovanje datotek - Ni uspelo"
fi

# Preverimo, ali obstaja datoteka "seznam_datotek.txt"
if [ -f "seznam_datotek.txt" ]; then
  echo "Naloga 3: Izpis direktorija - Uspešno"
else
  echo "Naloga 3: Izpis direktorija - Ni uspelo"
fi

# Preverimo, ali so datoteke ustrezno zapolnjene
if [ -f "VajaBash/file1_old.txt" ] && [ -f "VajaBash/file2_old.txt" ] && [ -f "VajaBash/file3_old.txt" ] && [ -f "VajaBash/file4_old.txt" ] && [ -f "VajaBash/file5_old.txt" ]; then
  echo "Naloga 4: Dodajanje vsebin v datoteke - Uspešno"
else
  echo "Naloga 4: Dodajanje vsebin v datoteke - Ni uspelo"
fi

# Preverimo, ali so rezultati iskanja z grep pravilni
if [ -f "grep_rezultati.txt" ] && [ $(grep -c "VajaBash/file2_old.txt" "grep_rezultati.txt") -eq 1 ]; then
  echo "Naloga 5.1: Uporaba grep - Uspešno"
else
  echo "Naloga 5.1: Uporaba grep - Ni uspelo"
fi

# Preverimo, ali so rezultati iskanja z find pravilni
if [ -f "bc_datoteke.txt" ] && [ $(cat bc_datoteke.txt | wc -l) -eq 1 ]; then
  echo "Naloga 5.2: Uporaba find - Uspešno"
else
  echo "Naloga 5.2: Uporaba find - Ni uspelo"
fi

# Preverimo, ali je rezultat štetja besed pravilen
if [ -f "stevilo_besed_file3.txt" ] && [ $(cat stevilo_besed_file3.txt) -eq 5 ]; then
  echo "Naloga 5.3: Uporaba wc - Uspešno"
else
  echo "Naloga 5.3: Uporaba wc - Ni uspelo"
fi

# Preverimo, ali je izračun kvadratni koren pravilen
if [ -f "kvadratni_koren.txt" ] && [ "$(cat kvadratni_koren.txt)" = "4.00000000000000000000" ]; then
  echo "Naloga 5.4: Uporaba bc -l - Uspešno"
else
  echo "Naloga 5.4: Uporaba bc -l - Ni uspelo"
fi

# Preverimo, ali so vse črke "a" spremenjene v "A" v datoteki
if [ -f "VajaBash/file5_old.txt" ] && [ "$(cat VajaBash/file5_old.txt)" = "SpreminjAm s tr." ]; then
  echo "Naloga 5.5: Uporaba tr - Uspešno"
else
  echo "Naloga 5.5: Uporaba tr - Ni uspelo"
fi

# Preverimo, ali so izpisi prvih dveh vrstic in zadnjih treh vrstic pravilni
if [ -f "prve_dve_vrstici.txt" ] && [ $(cat prve_dve_vrstici.txt | wc -l) -eq 2 ]; then
  echo "Naloga 6.1: Uporaba head - Uspešno"
else
  echo "Naloga 6.1: Uporaba head - Ni uspelo"
fi

if [ -f "zadnje_tri_vrstice.txt" ] && [ "$(cat zadnje_tri_vrstice.txt)" = "Poglejte me z grep." ]; then
  echo "Naloga 6.2: Uporaba tail - Uspešno"
else
  echo "Naloga 6.2: Uporaba tail - Ni uspelo"
fi

      i=1;
if [ -f "povprecna_dolzina.txt" ]; then
  while IFS= read -r line

  do
    # Uporabimo regularni izraz za prepoznavanje pravilnih vrstic
    if [[ $line =~ ^Povprečna\ dolžina\ vrstic\ v\ file[0-9]_old\.txt\ je\ [0-9]+\ znakov\.$ ]]; then
      echo "Naloga 7.$i: Poprečna dolžina vrstice $i - Uspešno"
      i=$(($i+1));
    else
      echo "Naloga 7.$i: Poprečna dolžina vrstice $i - Ni uspelo"
      i=$(($i+1));
    fi
  done < "povprecna_dolzina.txt"
fi

if [ -f "arhiv.zip" ]; then
  echo "Naloga 8: Obstaja datoteka arhiv.zip - Uspešno"
else
  echo "Naloga 8: Obstaja datoteka arhiv.zip - Ni uspelo"
fi

echo "Izpis vsebine"

for file in VajaBash/*
do
  ls $file
  cat $file
done

for file in *
do
  if [[ "$file" == *.txt ]]; then
    ls $file
    cat $file
  fi
done