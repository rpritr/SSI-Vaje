# Vaja 4: Osnove Bash skript

V tej vaji bomo spoznali osnove ustvarjanja, zagona in uporabe Bash skript v Linux okolju.

---

## Vaja 1: Osnovni zagon Bash skripte

1. Ustvarite skripto `hello.sh`, ki izpišete:

```bash
echo "Pozdravljen svet!"
```

2. Naredite skripto zagonsko:

```bash
chmod +x hello.sh
```

3. Zaženite jo:

```bash
./hello.sh
```

---

## Vaja 2: Vnos in branje podatkov

1. Ustvarite skripto `user_input.sh`.

2. Naj uporabnika vpraša za ime in izpiše pozdrav:

```bash
#!/bin/bash

echo "Vnesi svoje ime:"
read ime
echo "Pozdravljen, $ime!"
```

---

## Vaja 3: Uporaba argumentov

1. Ustvarite skripto `greet.sh`, ki sprejme argument – ime uporabnika.

```bash
#!/bin/bash
echo "Pozdravljen, $1!"
```

2. Zaženite skripto:

```bash
./greet.sh Janez
```

---

## Vaja 4: Spremenljivke in aritmetika

1. Ustvarite skripto `math.sh`, ki zahteva dve števili:

```bash
#!/bin/bash

echo "Vnesi prvo število:"
read a
echo "Vnesi drugo število:"
read b

echo "Vsota: $((a + b))"
echo "Razlika: $((a - b))"
echo "Produkt: $((a * b))"
echo "Kvocient: $((a / b))"
```

---

## Vaja 5: If stavek

1. Ustvarite skripto `compare.sh`:

```bash
#!/bin/bash

echo "Vnesi prvo število:"
read a
echo "Vnesi drugo število:"
read b

if [ $a -gt $b ]; then
    echo "Prvo število je večje"
else
    echo "Drugo število je večje ali enako"
fi
```

---

## Vaja 6: For zanka

1. Ustvarite skripto `for_loop.sh`:

```bash
#!/bin/bash

for i in {1..10}
do
    echo $i
done
```

---

## Vaja 7: While zanka

1. Ustvarite skripto `while_loop.sh`:

```bash
#!/bin/bash

number=0

while [ $number -ne 10 ]
do
    echo "Vnesi število:"
    read number
done

echo "Vnesel si 10. Izhod iz skripte."
```

---