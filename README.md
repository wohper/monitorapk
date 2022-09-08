# Monitora Pocket Knife

`MonitoraPK` è un progetto complementare a [MonitoraPA](https://github.com/MonitoraPA/monitorapa) e nato per fornire strumenti veloci e di supporto per il monitoraggio dei siti della PA. 

MonitoraPK è aperto a contributi e tutto il codice distribuito secondo i termini di [GPLv3](LICENSE).

# I dataset in input

Il dataset può essere ottenuto con lo script `get.dataset.php`:

```
php get.dataset.php /tmp/dataset.$(date --iso).tsv
...
Ho trovato 22884 record. 753 non hanno un sito associato
Ho rimosso i file temporanei
Il tuo dataset è disponibile qui: `/tmp/dataset.2022-09-08.tsv`.
```

I dataset possono essere costruiti come un file di testo del tipo:

```
CODICE  Web URL SITO
CODICE  Email INDIRIZZO E-MAIL
```
Es. 

```
PCM	Web	http://www.governo.it
PCM	Email	usg@mailbox.governo.it
```

È quindi possibile creare manualmente il proprio dataset per puntare gli script su specifici target.

# Script disponibili

Oltre altri script, è anche disponibile una pagina di [suggerimenti e idee](TIPS.md).

## check.mx.sh

Verifica dove sono puntati gli MX del dominio target (linea Web). Va alla ricerca di servizi ospitati da Google e Microsoft. Restituisce una lista facilmente parsabile.

```
bash check.mx.sh /yourpath/dataset.tsv | tee -a /yourpath/mx.log
```

## check.iplocation.sh

Per seguire lo script è necessario impostare il proprio TOKEN nel file `.env`, per fare questo basta eseguire:

```sh
$ echo 'TOKEN="il tuo token"' > .env
```

Verifica attraverso un servizio esterno la collacazione fisica e il fornitore del dominio target (linea Web). 

Restituisce un file per ogni dominio analizzato che contiene un JSON. Lo script si appoggia al servizio ipinfo.io che offre free tier sufficiente per analizzare tutti i domini nel dataset enti.

```
$ mkdir -p /yourpath/outputdir
$ bash check.iplocation.sh /yourpath/dataset.tsv /yourpath/outputdir
```

# Analisi dei dati raccolti

I dati raccolti possono essere facilmente analizzati con strumenti standard come grep, sed e awk. 
