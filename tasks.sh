PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align -c"

echo -e $($PSQL "DELETE FROM elements WHERE atomic_number=1000")

echo -e $($PSQL "DELETE FROM properties WHERE atomic_number=1000")

echo -e $($PSQL "ALTER TABLE properties DROP COLUMN type")

echo -e $($PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass")

echo -e $($PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius")

echo -e $($PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius")

echo -e $($PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL")

echo -e $($PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL")

echo -e $($PSQL "ALTER TABLE elements ADD UNIQUE(symbol)")

echo -e $($PSQL "ALTER TABLE elements ADD UNIQUE(name)")

echo -e $($PSQL "ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL")

echo -e $($PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL")

echo -e $($PSQL "ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number)")

echo -e $($PSQL "CREATE TABLE types(type_id SERIAL PRIMARY KEY, type VARCHAR NOT NULL)")

echo -e $($PSQL "INSERT INTO types(type) VALUES('metal'), ('nonmetal'), ('metalliod')")

echo -e $($PSQL "ALTER TABLE properties ADD COLUMN type_id INT")

echo -e $($PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id)")

echo -e $($PSQL "UPDATE properties SET type_id=3 WHERE atomic_number=5")

echo -e $($PSQL "UPDATE properties SET type_id=1 WHERE atomic_number=3 OR atomic_number=4")

echo -e $($PSQL "UPDATE properties SET type_id=2 WHERE type_id IS NULL")

echo -e $($PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL")

echo -e $($PSQL "UPDATE elements SET symbol=INITCAP(symbol)")

echo -e $($PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL")

echo -e $($PSQL "UPDATE properties SET atomic_mass=TRIM(TRAILING '0' FROM CAST(atomic_mass AS TEXT))::DECIMAL")

echo -e $($PSQL "INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine'), (10, 'Ne', 'Neon')")

echo -e $($PSQL "INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 18.998, -220, -188.1, 2), (10, 20.18, -248.6, -246.1, 2)")
