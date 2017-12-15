#!/usr/bin/ruby

require 'pg'

begin

    con = PG.connect :dbname => 'dbruby', :user => 'postgres',
        :password => 'postgres'

    con.exec "DROP TABLE IF EXISTS Cars"
    con.exec "CREATE TABLE Cars(Id INTEGER PRIMARY KEY,
       Name VARCHAR(20), Price INT, Created_at timestamp with time zone)"
    con.exec "INSERT INTO Cars VALUES(1,'Audi',52642, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(2,'Mercedes',57127, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(3,'Skoda',9000, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(4,'Volvo',29000, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(5,'Bentley',350000, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(6,'Citroen',21000, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(7,'Hummer',41400, CURRENT_TIMESTAMP)"
    con.exec "INSERT INTO Cars VALUES(8,'Volkswagen',21600, CURRENT_TIMESTAMP)"
    rs = con.exec "SELECT * FROM Cars"

    rs.each do |row|
      puts "%s | %s | %s | %s" % [ row['id'], row['name'], row['price'], row['created_at'] ]
    end

rescue PG::Error => e

    puts e.message

ensure

    con.close if con

end
