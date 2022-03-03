#!/usr/bin/python3
import pymysql

# Parameters and connect
miConexion = pymysql.connect(host='localhost', user='root',
                             passwd='', db='bdpythonapi')
cur = miConexion.cursor()

""" # Select
cur.execute("SELECT mail, passwd FROM users")
print("Resultados de tabla users:")
# After execute we can see the results using fetchall()
for mail, passwd in cur.fetchall():
    print("{} : {}".format(mail, passwd))
 """
# Insert
cur.execute("insert into category (cat_id, cat_nom, cat_desp) values(NUll,'audifonos','ninguna'), (NUll,'mouse','ninguna');")

""" # Update
cur.execute("update users set mail='ñaña@ñaña.com' where id=113;")
cur.execute("SELECT mail, passwd FROM users")
print("\nLuego de modificar\n")
for mail, passwd in cur.fetchall():
    print("{} : {}".format(mail, passwd))

# Delete
cur.execute("delete from users where id=113;")
print("\nLuego de eliminar\n")
cur.execute("SELECT mail, passwd FROM users")
for mail, passwd in cur.fetchall():
    print("{} : {}".format(mail, passwd))
 """
# Apply and close
miConexion.commit()
miConexion.close()
