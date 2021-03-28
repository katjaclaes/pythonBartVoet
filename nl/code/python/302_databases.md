## Data opslaan met databases (sql-primer)

Software-applicatie dienen in de meeste gevallen data op te slagen, we noemen dit process ook wel **persisteren**.  

Een eerste manier is data opslagen via een file (zoals eerder gezien).   
Als we echter veel of complexe data willen opslagen kunnen we gebruik maken van databases.  

### Wat is een database

Een **database** is een apart stuk **software of service** dat:

* **data** kan opslaan
* op een **gestructureerde manier** 
* op een **duurzame** manier (**persisteren**)
* en deze nadien terug kan **ondervragen** of **querien**

#### CRUD en queries

Een database voorziet voor het opslagen van data in **CRUD**-operaties:

* **C**reate: je kan **nieuwe data** aanmaken
* **R**ead: je kan deze data opnieuw **opvragen** via **zoekopdrachten** of **queries**
* **U**pdate: je kan deze data - die je eerder hebt gecreerd - opnieuw **wijzigen**
* **D**elete: je kan de data ook (selectief indien nodig) verwijderen

### Relationele databases

Er bestaan verschillende soorten database; **relationele**, **grafische**, **document-gebaseerde**, ...  

De database-technologie die wij gaan gebruiken zijn **relationele databases**, of ook wel **RDBMS** (relational database management system) genoemt.

Zo'n database is in de **kern** gebaseerd op een aantal **basisprincipes**:

* Data wordt gestructuureerd opgeslagen in **tabellen**
* Deze tabellen bestaan uit **kolommen** of **velden**
* Men kan **relaties** ofverbanden leggen **tussen** deze **tabellen**  
  dit is het **relationeel** gedeelte...
* Om deze **verbanden** te kunnen leggen maakt men gebruik van **sleutels** of **keys**
* Men kan een aantal **regels** of constraints toekennen op deze tabellen of velden
* Deze data kan worden ondervraagd via **SQL** (Structured Query Language)

#### Tabellen, kolommen en rijen

Een database bestaat uit **1 of meerdere tabellen**:

* Een tabel kan je best vergelijken met een tabel zoals je ze uit documenten of excels kent
* Zo'n tabel definieert **kolommen of velden**, die hebben een **naam** en een **type**
* Dataéénheden noemen we **rijen**, deze bevatten een waarde voor elke kolom-definitie

Ter illustratie zie je hier een voorbeeld van een tabel **student** met 3 kolommen en 5 rijen met (studenten-)data.

~~~
        Tabel: student
            kolom 1         kolom 2          kolom 3
            type: text      type: int        type: int 
               |               |                |
         +---------------+---------------+---------------+
         | student_name  |      lab      |     theory    |
         +---------------+---------------+---------------+  
  rij -- |  Bart Voet    |      15       |      16       |
         +---------------+---------------+---------------+  
  rij -- | Jan Janssens  |      17       |      14       |
         +---------------+---------------+---------------+
  rij -- | Piet Pieters  |      15       |      14       |
         +---------------+---------------+---------------+
  rij -- | Korneel Kos   |      11       |      12       |
         +---------------+---------------+---------------+
  rij -- | Joris Jos     |      10       |      14       |
         +---------------+---------------+---------------+
~~~

#### Sleutels, relaties en verbanden

Een database is vanzelfsprekend niet beperkt tot 1 tabel.  
Er kunnen meerdere tabellen worden gedefinieerd en gebruikt

Stel dat je 

~~~
         +---------------+                                                      
         | student       | 
         +---------------+---------------+---------------+---------------++--------------+---------------+     
         | student_name  |      lab      |     theory    |  class_name   |    Teacher    |     Room      |
         +---------------+---------------+---------------+---------------+---------------+---------------+  
         |  Bart Voet    |      15       |      16       |      1        |    Wim        |      A        |
         +---------------+---------------+---------------+---------------+---------------+---------------+
         | Jan Janssens  |      17       |      14       |      1        |    Wim        |      A        |
         +---------------+---------------+---------------+---------------+---------------+---------------+
         | Piet Pieters  |      15       |      14       |      2        |    Thierry    |      B        |
         +---------------+---------------+---------------+---------------+---------------+---------------+
         | Korneel Kos   |      11       |      12       |      2        |    Thierry    |      B        |
         +---------------+---------------+---------------+---------------+---------------+---------------+
         | Joris Jos     |      10       |      14       |      2        |    Thierry    |      B        |
         +---------------+---------------+---------------+---------------+---------------+---------------+
~~~


In onderstaand voorbeeld voegen we een tabel class toe die informatie bevat over de klas zelf.  






~~~
         +---------------+                                                      
         | student       | 
         +---------------+---------------+---------------+---------------+     
         | student_name  |      lab      |     theory    |  class_name   |
         +---------------+---------------+---------------+---------------+  
         |  Bart Voet    |      15       |      16       |      1        +------+
         +---------------+---------------+---------------+---------------+      |
         | Jan Janssens  |      17       |      14       |      1        +------+
         +---------------+---------------+---------------+---------------+      |
         | Piet Pieters  |      15       |      14       |      2        +--+   |
         +---------------+---------------+---------------+---------------+  |   |
         | Korneel Kos   |      11       |      12       |      2        +--+   |
         +---------------+---------------+---------------+---------------+  |   |
         | Joris Jos     |      10       |      14       |      2        +--+   |
         +---------------+---------------+---------------+---------------+  |   |
                                                                            |   |
+--------------------------------------<------------------------------------+   |
|                                                                               |
|   +----------------------------------<----------------------------------------+
|   |   
|   |    +---------------+                                                      
|   |    |    class      |                                                      
|   |    +---------------+---------------+---------------+                      
|   |    | class_name    |    Teacher    |     Room      |                      
|   |    +---------------+---------------+---------------+                      
|   +--->|      1        |      Wim      |      A        |
|        +---------------+---------------+---------------+
+------->|      2        |    Thierry    |      B        |
         +---------------+---------------+---------------+

~~~

### SQL?

SQL of **Structured Query Language** is een taal die we gebruiken om met een **database** te praten.  
Deze SQL bestaat uit 3 onderdelen

* **DDL** - Data Definition Language  => Beschrijven van datastructuren in ons geval tabellen
* **DML** - Data Modification Language => Ondervragen en wijzigen van data
* **DCL** - Data Control Language => Controleren van toegang tot de data

We gaan ons **grotendeels** bezig houden met **DML** (en een **beetje** met **DDL**).

> Nota: er bestaan nog andere manieren naast SQL, daar komen we later nog op terug

### Client-server vs embedded databases

**DBMS** (Database Management Systemen) zijn meestal beschikbaar als een **client-server-service** op een netwerk en worden gedeeld door meerdere gebruikers.

#### Client-server

Zo'n applicatie maakt dan over het **netwerk** **verbinding** met een **database** om data op te vragen of te manipuleren (via SQL) en krijgt data terug.

~~~
+-------------------+  NETWORK   +----------------+
|                   |            |                |
|                   +----------->|                |
|                 A |    SQL     |                |
|  Applicatie     P |            |    Database    |
|                 I |    DATA    |                |
|                   |<-----------+                |
|                   |            |                |
+-------------------+            +----------------+
~~~

Bekende voorbeelden van zulke databases zijn bijvoorbeeld MySQL, MariaDB, Oracle DB, SqlServer, ...  

#### SQL-api's

Een applicatie gaat meestal **niet rechtstreeks** praten met de database, om complexiteit te verbergen (netwerk-verbinding, sql en parameters aanbrengen, ....) bieden de meeste datatabases een **API** (en/of **driver**) aan om de **communicatie** te verzorgen met de database.

~~~
+---------------+---+  NETWORK   +----------------+
|               |   |            |                |
|               |   +----------->|                |
|               | A |    SQL     |                |
|  Applicatie   | P |            |    Database    |
|               | I |    DATA    |                |
|               |   |<-----------+                |
|               |   |            |                |
+---------------+---+            +----------------+
~~~

#### Embedded databases

In vele gevallen kan het zijn dat de data niet noodzakelijk moet gedeeld worden tussen verschillende applicaties or devices op het netwerk.  
Een voorbeeld is een Smartphone (of een applicatie of de smartphone) die wat lokale applicatie-gegevens of configuratie wenst bij te houden, de historiek van een browser, ...

Deze tegenhanger van  **client-server-systemen** noemen we een **embedded database**.  
In dit geval draait de database **op dezelfde machine** en in **meeste gevallen** is de database ook **ingebed** (embedded) is in dezelfde **applicatie**.

~~~
+---------------+---+------------+----------------+
|               |   |            |                |
|               |   +----------->|                |
|               | A |    SQL     |                |
|  Applicatie   | P |            |    Database    |
|               | I |    DATA    |                |
|               |   |<-----------+                |
|               |   |            |                |
+---------------+---+------------+----------------+
~~~

### Sqlite (een relationele database in praktijk)

Eén van de belangrijkste (of toch meest gebruikte) is **Sqlite** (https://www.sqlite.org/index.html).

Deze wordt binnen de industrie gebruikt door verschillende toepassingen:

* Storage voor Android-systeem en -applicaties
* Office-toepassingen
* CAD-systemen
* History voor internetbrowsers
* Embedded Systemen
* Configuratie van desktop-toepassingen
* Educationele redenen als deze applicatie
* ...


### "Getting started" met SQL

In dit deel van de cursus maken we hier van gebruik vanwege de **gebruiksvriendelijkheid** en de **snelheid van ontwikkeling**.  

* Als **eerste stap** is leren **werken met SQL**, hier voor gebruiken we een sql-browser-tool
* Vervolgens gaan we een **database** gebruiken vanuit **Python** door middel van een **api** 

### Sqlitebrowser

Om met Sqlite te werken starten we met het gebruik van een handige tool om sql-commando's toe te passen op deze database.

Download sqlitebrowser vanaf https://sqlitebrowser.org/ of via de packagemanager van je Linux-distro.  

### Database aanmaken

Zo'n sqlite-database betaat uit **1 file**.    

Onze eerste stap is zo'n nieuwe database aan te maken, hiervoor open je de sqlite-browser die we eerder hebben gedownloaded

Binnen dit scherm selecteer je linksboven de optie nieuwe database (zie screenshot)

![](../../pictures/sqlite_new_db.png)

Bij het bewaren geef je deze de naam **students.db** (meest gebruikte extensie voor sqlite-databases)

### Werken met SQL

We gaan SQL gebruiken om de database te manipuleren.  
Om **SQL-scripts** uit te voeren selecteer je (na het opstarten van sqlitebrowser) de tab "Execute SQL".  

Binnen dit venster kan je dan SQL-commando's (of queries) typen om je database te ondervragen (select) of te wijzigen (insert, update, delete)

![](../../pictures/sqlite_exec_sql.png)

### Tabellen aanmaken (DDL)

We gaan dus **van start**, **stap 1** is het aanmaken van **tabellen** die je eerst moet definieren vooraleer deze te gebruiken.

In de eerdere hoofdstukken hadden we een studenten-applicatie gemaakt.  
We gaan van start met een tabel aan te maken om **studenten-data op te slaan** 

Deze tabel zal dan de data bevatten van 
Ter herhaling, de klasse student bevat 3:

* Naam
* Labo-punten
* Theorie-punten

Deze velden gaan we aanmaken binnen een **tabel** en noemen we ook wel een **kolom**.  
Een  tabel bestaat uit:

* Kollommen of de velden die zo'n tabel bevat (projectie)
* Rijen van data, in het voorbeeld hieronder bevat de tabal al 2 lijnen or rijen met studenten-data

~~~
+---------------+---------------+---------------+
| student_name  |      lab      |     theory    |
+---------------+---------------+---------------+  
|  Bart Voet    |      15       |      16       |
+---------------+---------------+---------------+  
| Jan Janssens  |      17       |      14       |
+---------------+---------------+---------------+
~~~


#### Poging 1

Om deze structuur aan te namen gebruiken we een create-statement:

* Dit start met de **"create table"**
* Gevolgd door een **naam** voor deze structuur (student in dit geval)
* Gevolgd door **haakjes-paar**
* En gevolgd door een **;**

> Nota: sql is wat betreft syntax (niet data) case-insensitive...

~~~sql
CREATE TABLE student 
(

);
~~~

We klikken vervolgens op de play-button om dit statement uit te voeren ... en we krijgen een error

![](../../pictures/sql_error.png)


Deze error is logisch want dit is nog geen geldig statement, een tabel moet echtern minstens 1 kolom/veld bevatten.

~~~
Result: near ")": syntax error
At line 1:
CREATE TABLE student 
(

)
~~~

#### Poging 2: velden toevoegen

Deze velden kan je toevoegen tussen de haakjes:

* Zijn gescheiden door komma's
* Bevatten een type (text of integer)

(er zijn vanzelfsprekend meerdere types maar we beperken ons voorlopig hier toe)

~~~sql
CREATE TABLE student 
(
    student_name TEXT,
    lab INTEGER,
    theory INTEGER
);
~~~

![](../../pictures/sql_success.png)

Deze poging is successvol en duidt aan dat de tabel is gecreerd:

~~~
Result: query executed successfully. Took 1ms
At line 1:
CREATE TABLE student 
(
    student_name TEXT,
    lab INTEGER,
    theory INTEGER
);
~~~

Als je navigeert naar de tab "Database Structure" zie je ook dat deze tabel is aangemaakt

![](../../pictures/sql_structure.png)

### Data toevoegen via insert

We keren ondertussen terug naar het sql-venster om te zien hoe we data moeten toevoegen.  
Om data toe te voegen gebruiken we een insert-statement:

~~~sql
insert into student(student_name,lab,theory) values("Bart Voet",15,16);
~~~

Als dit successvol is krijg je een vergelijkbare input:

~~~
Result: query executed successfully. Took 0ms, 1 rows affected
At line 1:
insert into student(student_name,lab,theory) values("Bart Voet",15,16)
~~~

Dit statement bestaat uit:

* De **keyword**-combo **insert into**
* Gevolgd door de **tabel-naam** student
* De **velden** die je wil **updaten** (tussen de haakjes gescheiden door komma's)
* Gevolgd door de het **keyword** **values**
* En daarna de **waarden** tussen **haakjes**, ook **gescheiden door komma's**

Bemerk ook dat **string** hier ook worden gemarkeerd door **quotes**, net zoals we in Python gewoon zijn.  
Om de volgende stappen te doen voegen we nog een **2de rij** toe aan de database via:

~~~sql
insert into student(student_name,lab,theory) values("Jan Janssens",17,14);
~~~

met als **restulaat**

~~~
Result: query executed successfully. Took 0ms, 1 rows affected
At line 1:
insert into student(student_name,lab,theory) values("Jan Janssens",17,14);
~~~


### Lezen van data met SQL

Om de data (die we zojuist hebben geinjecteerd) te kunnen **lezen** gebruiken we een 2de soort SQL-statements, namelijk **select-statments**.  
Typ het volgende statement in de sql-editor:

~~~sql
select * from student;
~~~

Deze bestaat uit 3 onderdelen:

* "select"-keyword
* een \* om aan te gevan dat je **alle velden** wil selecteren

Als dit succesvol is krijg je data zien zoals hieronder:

![](../../pictures/sql_select.png)

De data die je ziet in het raster stemt dan overeen met de date die je hebt toegevoegd via de voorgaande **insert-statements**

~~~
student_name  lab         theory    
------------  ----------  ----------
Bart Voet     15          16        
Jan Janssens  17          14  
~~~

### Beperken van de velden (projectie)

Als je niet alle velden nodig hebt kan je ook de de velden die je wil zien gescheiden door een komma (ipv een) \*)

~~~sql
select student_name, lab from student;
~~~

In dit geval zal je zien dat enkel de naam en de de labo-punten worden **geprojecteerd**

~~~
student_name  lab       
------------  ----------
Bart Voet     15        
Jan Janssens  17
~~~

Dit bepalen of beperken van de kolommen is wat we noemen een **projectie**.


### Gebruik van where-clausules (selectie)

Naast de **projectie** kunnen we ook de **selectie** gaan beperken.  

Dit doen we via een **where-clausule** toe te voegen...  
We passen bijvoobeeld de vorige query aan om de studenten te selecteren met meer dan 16 punten

~~~sql
select student_name, lab from student where lab > 16;
~~~

Het resultaat wordt filterd en we krijgen enkel de student te zien met meer meer dan 16 punten.

~~~
student_name  lab       
------------  ----------
Jan Janssens  17  
~~~

Dit filteren of beperken van het aantal rijen is wat we noemen binnen **SQL** (en relationele algebra) een **selectie**.  
Je kan voor dit filteren verschillende operatoren gebruiken zoals:

~~~
=	Gelijk aan	
>	Groter dan	
<	Kleiner dan	
>=	Groter dan of gelijk aan
<=	Kleiner dan of gelijk aan	
<>	Niet gelijk aan
~~~

Deze zijn  - met **uitzondering** van **<>** dat overeenkomt met != in Python - **hetzelfde** zoals je deze in **Python-code** zou gebruiken voor condities en loops.  
Als je de statement omdraait...

~~~sql
select student_name, lab from student where lab < 16;
~~~

... krijg je dan ...

~~~
student_name  lab       
------------  ----------
Bart Voet     15    
~~~

### Where combineren met and of or

Om de volgende oefeningen te kunnen verder zetten voegen we nog wat rijen toe:

~~~sql
insert into student(student_name,lab,theory) values("Piet Pieters",9,12);
insert into student(student_name,lab,theory) values("Joris Jorissen",11,12);
~~~


Je kan (net zoals in Python) ook **condities** **combineren** met **and** of **or**.  
Bijvoorbeeld willen we de studenten die meer (of gelijk) aan 15 op hun theorie hebben

~~~sql
select student_name, lab from student where lab > 14 or theory >= 14;
~~~

Krijg je meer studenten geselecteerd (die zowel op labo als theorie hoger scoren als 14):

~~~
student_name  lab       
------------  ----------
Bart Voet     15        
Jan Janssens  17  
~~~

De 2 nieuwe studenten krijg je niet te zien, als we nu een combineren met and om de studenten te zien die zowel op theorie als labo minder hebben dan 14...

~~~sql
select student_name, lab, theory from student where lab < 14 and theory < 14;
~~~

... krijg je ...

~~~
student_name  lab         theory    
------------  ----------  ----------
Piet Pieters  9           12        
Joris Joriss  11          12    
~~~

### Update

Tot nog toe kunnen we:

* Een tabel aanmaken met een **create-statement**
* Data injecteren met **insert-statements**
* Data ophalen via **select** 
* Filteren via een **where-clausule**

De volgende vraag, wat als je data wil aanpassen in een bestaande rij, dit kan je via een update-statement.

~~~sql
update student set lab = 10 where student_name = "Piet Pieters";
~~~

Als we nadien de tabel bekijken zien we dat de betreffende student (Piet Pieters) zijn labo-punten zijn aangepast (9 -> 10)

~~~
student_name  lab         theory    
------------  ----------  ----------
Bart Voet     15          16        
Jan Janssens  17          14        
Piet Pieters  10          12        
Joris Joriss  11          12  
~~~

De syntax is hier:

* keyword **update**
* gevolgd door de tabel-naam
* dan het keyword **set**
* gevolgd door de eigenlijke update met de vorm **column-name = waarde**
* en als laaste een **where-conditie** die aangeeft welke rijen moeten worden geupdated

> **Waarshuwing:**  
> Als je deze where-conditie of clausule vergeet loop je het **risico** alle rijen aan te **passen**

### Update meerdere velden

Je kan ook meerdere velden te gelijk updaten, hiervoor voeg je een nieuwe update-deel toe (gescheiden door een komma)

~~~sql
update student set lab = 16, theory=15 where student_name = "Jan Janssens";
~~~

Hier wordt zowel het labo als de theorie van Jan Janssens aangepast.

~~~
student_name  lab         theory    
------------  ----------  ----------
Bart Voet     15          16        
Jan Janssens  16          15        
Piet Pieters  10          12        
Joris Joriss  11          12   
~~~


### Update meerdere rijen

Meerdere rijen tegelijk is ook mogelijk (zelfs alle rijen).  
Stel dat we alle studenten een punt will bij geven op het labo (die minder dan 12 hebben), wegens goed medewerking in de klass

~~~sql
update student set lab = lab +1 where lab < 12;
~~~

... zien we alle student met minder dan 12 een update krijgen

~~~
student_name  lab         theory    
------------  ----------  ----------
Bart Voet     15          16        
Jan Janssens  16          15        
Piet Pieters  11          12        
Joris Joriss  12          12  
~~~

Een 2de voorbeeld, we willen studenten die meer labo-punten hebben dan theori een puntje bij geven op theorie...

~~~sql
update student set theory = theory +1 where lab > theory;
~~~

~~~
student_name  lab         theory    
------------  ----------  ----------
Bart Voet     15          16        
Jan Janssens  16          16        
Piet Pieters  11          12        
Joris Joriss  12          12   
~~~

### CRUD

De operaties die we tot nog toe hebben gedaan via SQL resorteren eigelijk onder **CRUD**.  
CRUD staat voor de vier **basisoperaties** die op date kunnen uitgevoerd kunnen worden zoals:

* **Create** (of insert): Toevoegen van nieuwe data.
* **Read** (of select): Opvragen van gegevens.
* **Update**: Wijzigen van gegevens.
* **Delete**: Verwijderen van gegevens.

### Delete

De laatste operatie die we nog niet in SQL hebben gezien is **delete**, net zoals bij **update** die, je een where-clausule (eigenlijk niet verplicht maar anders verwijder je alle gegevens).

Bijvoorbeedl, stel dat de student "Bart Voet" onrechtmatig toegang heeft gekregen tot de cursus kan je deze verwijderen als volgt:

~~~sql
delete from student where student_name = "Bart Voet";
~~~

...nadien zie je dat deze student verdwenen is uit de database

~~~
student_name  lab         theory    
------------  ----------  ----------
Jan Janssens  16          16        
Piet Pieters  11          12        
Joris Joriss  12          12   
~~~

> **Waarschuwing:**  
> Opnieuw dezelfde waarschuwing als bij update, pas op dat je
> where-clausule correct is gefinieerd want je kan meerdere 
> studenten tot en met de hele tabel deleten.

### Tabel verwijderen via drop

De voorgaande crud-statements (select, insert, update, delete) verwijzen we als DML (Data Modification Language).  
Om een tabel aan te maken hebben we eerder gebruik gemaakt van een create-statement, dit is wat verwijzen als een DDL (Data Definition Language).  

Een andere DDL-statement (naast create) is **drop**.  
Dit kan men gebruiken om een tabel te verwijderen uit een database.

We gaan dit vervolgens doen om daarna de tabel terug aan te maken (om primary en foreign keys te demonsteren)

~~~sql
drop table student;
~~~

Als je dan probeert de tabel te querien krijg je de melding geen data meer te hebben.

~~~
sqlite> select * from student;
Error: no such table: student
~~~

> **Waarschuwing:**  Dit verwijdert vanzelfsprekend ook de data...

### Primary key

Tot nu gebruikte we de name-kolom om een student uniek te identifieren.  
Je kan zorgen dat je database controleerd dat deze naam uniek is via een **"primary key"-constraint**:

* **Primary key** slaagt op het feit dat deze kolom uniek is en de primaire sleutel is om een record op te zoeken
* **Constraints** zijn controles of voorwaardes die een database voor jou kan controlleren en forceren

> Nota: dit kan ook via een "unique-key"-constraint, daar komen we later nog op terug...

We maken een nieuwe create-statement aan:

~~~sql
CREATE TABLE student 
(
    name TEXT PRIMARY KEY,
    lab INTEGER,
    theory INTEGER
);
~~~

We hebben hier een keyword **PRIMARY KEY** toegevoegd aan de 1ste kolom.  
Vervolgens voegeven we 2 nieuwe studenten toe:

~~~sql
insert into student(name,lab,theory) values("Bart Voet",15,16);
insert into student(name,lab,theory) values("Jan Janssens",17,14);
~~~

Tot nog toe zien we het zelfde resulatat als voorheen, 2 lijnen toegevoegd:

~~~
name        lab         theory    
----------  ----------  ----------
Bart Voet   15          16        
Jan Jansse  17          14      
~~~

Daarna voegen we een student toe, let wel deze student bestaat reeds in de database...

~~~sql
insert into student(name,lab,theory) values("Bart Voet",17,18);
~~~

De database zal dit echter niet toestaan door de constraint die je eerder hebt toegevoegd.

~~~
Error: UNIQUE constraint failed: student.name
~~~

### Automatische primary-keys

1 van de problemen die je kan hebben met voorgaande approach is dat het technisch wel mogelijk is van 2 studenten te hebben met dezelfde naam.  
Wat daarom veel wordt gedaan is gebruik maken van numerieke id's om op zich de verschillende studenten een unieke nummer te geven (een beetje zoals jullie studenten nummers)

Om dit te doen voegen we een veld/kolom **student_id** toe en maken we definieren we deze als unieke identifier. 

~~~sql
drop table student;

CREATE TABLE IF NOT EXISTS student 
(
    student_id INTEGER PRIMARY KEY,
    name TEXT,
    lab INTEGER,
    theory INTEGER
);
~~~

Deze nieuwe id kan je toevoegen aan je insert-statement maar kan automatisch worden aangemaakt door de databasse...  


~~~sql
insert into student(name,lab,theory) values("Bart Voet",15,16);
insert into student(name,lab,theory) values("Jan Janssens",17,14);
insert into student(name,lab,theory) values("Piet Pieters",9,12);
insert into student(name,lab,theory) values("Joris Jorissen",11,12);
~~~

Als we in de databasqe kijken zien we dat dit veld automatisch wordt aangevult

~~~
student_id  name        lab         theory    
----------  ----------  ----------  ----------
1           Bart Voet   15          16        
2           Jan Jansse  17          14        
3           Piet Piete  9           12        
4           Joris Jori  11          12   
~~~


Zulk een auto-increment-mechanisme bestaat voor elke datbase (mysql, postgres, sqlserver, ...) maar het mechanisme om dit te definieren kan verschillen per database.   
Hier wordt nog op teruggekomen als we met postgres-sql gaan werken als gedeelde database.


Deze autoincrement-feature houdt niet tegen dat je deze waarde meegeeft (we hardcoderen 8)

~~~sql  
insert into student(student_id,name,lab,theory) values(8,"Piet Pieters",9,12);
~~~

~~~
student_id  name        lab         theory    
----------  ----------  ----------  ----------
1           Bart Voet   15          16        
2           Jan Jansse  17          14        
3           Piet Piete  9           12        
4           Joris Jori  11          12        
8           Piet Piete  9           12        
~~~

Als je nadien terug een student zonder id toevoegt zal ded hoogste id terug opnieuw worden geincrementeerd.

~~~sql
insert into student(name,lab,theory) values("Korneel Kortens",9,12);
~~~


~~~
student_id  name        lab         theory    
----------  ----------  ----------  ----------
1           Bart Voet   15          16        
2           Jan Jansse  17          14        
3           Piet Piete  9           12        
4           Joris Jori  11          12        
8           Piet Piete  9           12        
9           Korneel Ko  9           12  
~~~
