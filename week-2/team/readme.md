# Week 2 – Meeskonnatöö

## Eesmärk

Week 2 eesmärk oli hinnata UrbanStyle andmebaasi andmete kvaliteeti, leida andmeprobleemid ning valmistada andmestik ette usaldusväärseks analüüsiks.

## Meeskonna tulemused

Meeskonnana kontrollisime erinevaid andmevaldkondi ning leidsime järgmised probleemid:

- Müügiandmetes esines 5116 duplikaatset kirjet ja 1487 puuduvat kliendiviidet.
- Kliendiandmetes puudus 380 kliendil e-posti aadress.
- Tooteandmetes leiti 12 korduvat tootenime.
- Ristvalideerimisel tuvastati 592 klienti ilma ostudeta ja 12 toodet, mida ei olnud kunagi müüdud.

## Minu panus

Minu ülesandeks oli analüüsida **customers** tabeli andmete kvaliteeti. Kontrollisin NULL-väärtusi ja andmete täielikkust ning leidsin, et **380 kliendil puudub e-posti aadress**, kuid kõigil klientidel on telefoninumber olemas. Tulemused lisati meeskonna andmekvaliteedi raportisse ning neid kasutati edasiste analüüside planeerimisel.