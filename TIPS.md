# Tips

## Usare un motore di ricerca per trovare trasferimenti illeciti (e altro)

Lo scraping di migliaia di siti è un'operazione piuttosto onerosa, così come sviluppare script che vadano alla ricerca di specifici servizi. L'idea di questa tip è utilizzare gli indici già esistenti dei motori di ricerca (e in particolare DuckDuckGo) per facilitare il compito.

DuckDuckGO può essere utilizzato convenientemene da linea di comando e produrre risultati in JSON comodi da parsare. Lo strumento chiave è [ddgr](https://github.com/jarun/ddgr). Una volta installato sarà possibile eseguire ricerche per parole chiave e ottenere specifici target.

Senza questo approccio, scovare un servizio che opera trasferimenti illeciti all'interno di un sito può essere difficile, perché il servizio, per esempio un video Youtube o un formulario Google Form potrebbero non essere presenti sulla homepage, che è il target classico dei dataset.

Per esempio qui è possibile ottere alcune pagine che contengono Youtube sul sito del Governo:

```
ddgr --json --site "governo.it" youtube
```

Qui si cerca Google Forms in tutti i siti \*.edu.it

```
ddgr --json --site "edu.it" "forms.google.com"
```

Scoprendo per esempio che una scuola chiede [informazioni sulla vaccinazione](https://www.comprensivogalilei.edu.it/comunicazioni-ed-eventi/comunicazioni-scuola-famiglia/430-comunicazione-sulla-vaccinazione-alunni-5-11-anni.html) ([copia permanente](https://web.archive.org/web/20220907213800/https://www.comprensivogalilei.edu.it/comunicazioni-ed-eventi/comunicazioni-scuola-famiglia/430-comunicazione-sulla-vaccinazione-alunni-5-11-anni.html))via Google Forms e altre amenità

Una volta ottenute una serie di pagine target, le stesse possono essere oggetto di monitoraggio per identificare più precisamente i servizi e procedere alle conseguenti azioni.
