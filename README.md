# Monitora Pocket Knife

`MonitoraPK` è un progetto complementare a [MonitoraPA](https://github.com/MonitoraPA/monitorapa) e nato per fornire strumenti veloci e di supporto per il monitoraggio dei siti della PA. In generale, `MonitoraPK` è compatibile in input con i dataset di MonitoraPA.

Il progetto è aperto a contributi e tutto il codice distribuito secondo i termini di [GPLv3](LICENSE).

# Dove trovare i dataset

I dataset possono essere ottenuti dal succitato progetto MonitoraPA, ovvero seguendo queste istruzioni da aggiustare al caso.

```bash
sudo apt-get install python3 unzip curl
git clone https://github.com/MonitoraPA/monitorapa.git
cd monitorapa
pip install -r requirements.txt
python3 cli/data/enti/download.py
(restituisce un path tipo out/enti/1970-01-01/enti.tsv)
python3 cli/data/enti/normalize.py out/enti/1970-01-01/enti.tsv
(restituisce un path tipo out/enti/1970-01-01/dataset.tsv)
```

Il dataset ottenuto in `out/enti/1970-01-01/dataset.tsv` è un file composto di tre colonne separate da tab:

```
CODICE  Web URL SITO
CODICE  Email INDIRIZZO E-MAIL
```
Es. 

```
PCM	Web	http://www.governo.it
PCM	Email	usg@mailbox.governo.it
```

E' quindi possibile creare manualmente il proprio dataset per puntare gli script su specifici target.
