# Testing Out Database Admin Applications

## dbeaver.io

Was unable to isntall within 5 minutes of trying.

## pgAdmin III

* Installable from within the system.  Search "database" from discover app, and it is a default app that pops up.

```

# psql Scripts

```
Connect via Docker...

$ sudo docker-compose exec db psql --username=hello_flask --dbname=hello_flask_dev                                        

psql (13.1)                                                                                                                                                                      
Type "help" for help.                                                                                                                                                            
                                                                                                                                                                                 

* connect to database

hello_flask_dev=# \c hello_flask_dev

* List databases

\l

* List tables

\dt

* Describe table

\d table_name

* List Schema

\dn

* List Functions

\df

* Get help

\?

Exit

\q

```
