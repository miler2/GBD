use jardineria;
-- 1. Consulte cuáles son los índices que hay en la tabla producto utilizando las instrucciones SQL que nos permiten obtener esta información de la tabla.

show index from producto;


-- 2. Haga uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas y 
-- diga cuál de las dos consultas realizará menos comparaciones para encontrar el producto que estamos buscando. ¿Cuántas comparaciones se realizan en cada caso? ¿Por qué?.

-- En la primera sentencia se ha hecho solo una comparación, mientras que en la segunda se han hecho 276. La razón es porque a la hora e buscar el nombre, no sabe si es único, por lo que va a buscar todas las coincidencias. 
-- Sin embargo, buscando por código de producto, está buscando una única fila. 

explain SELECT *
FROM producto
WHERE codigo_producto = 'OR-114';

explain SELECT *
FROM producto
WHERE nombre = 'Evonimus Pulchellus';


-- 3. Suponga que estamos trabajando con la base de datos jardineria y queremos saber optimizar las siguientes consultas. ¿Cuál de las dos sería más eficiente?. 
-- Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.

-- Entre estas dos consultas, la primera, de nuevo, es la más rápida, ya que ésta no ha necesitado hacer filtros innecesarios (100 es el valor máximo de "filtered", que significa que no ha usado ningún filtro)
-- , y ha conseguido la misma información que la segunda consulta, que sí está usando filtros.

explain SELECT AVG(total)
FROM pago
WHERE YEAR(fecha_pago) = 2008;

explain SELECT AVG(total)
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago <= '2008-12-31';


-- 4. Optimiza la siguiente consulta creando índices cuando sea necesario. 
-- Se recomienda hacer uso de EXPLAIN para obtener información sobre cómo se están realizando las consultas.

SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE 'A%';

drop index nombre_cliente on cliente;
create index nombre_cliente on cliente(nombre_cliente);


-- 5. ¿Por qué no es posible optimizar el tiempo de ejecución de las siguientes consultas, incluso haciendo uso de índices?

-- Porque en este caso, a diferencia de el ejercicio anterior, estamos buscando varias personas, no solo una persona.

SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A%';

explain SELECT *
FROM cliente INNER JOIN pedido
ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE cliente.nombre_cliente LIKE '%A';


-- 6. Crea un índice de tipo FULLTEXT sobre las columnas nombre y descripcion de la tabla producto.

drop index descripcion_producto on producto;
create fulltext index descripcion_producto on producto(nombre, descripcion);


-- 7. Una vez creado el índice del ejercicio anterior realiza las siguientes consultas haciendo uso de la función MATCH, para buscar todos los productos que:

	-- Contienen la palabra planta en el nombre o en la descripción. Realice una consulta para cada uno de los modos de búsqueda full-text que existen en MySQL (IN NATURAL LANGUAGE MODE, IN BOOLEAN MODE y WITH QUERY EXPANSION) y 
	-- compare los resultados que ha obtenido en cada caso.

		-- He encontrado esta explicación online, creo que lo explica bien.
		-- IN NATURAL LANGUAGE MODE ... your search term will be treated as natural language (being human language). So no special characters here, except for the " (double quote). 
		-- All words on your stopword list will be excluded when searching!

		-- IN BOOLEAN MODE ... operators can be added to your search term. This means you can specify extra wishes regarding your search. The stopword list rule also applies of course, meaning they will be excluded from your search.

		-- WITH QUERY EXPANSION (or IN NATURAL LANGUAGE MODE WITH QUERY EXPANSION) ... is as this last name implies an expansion to IN NATURAL MODE. So it basically is the same as this first mode mentioned above, 
		-- except for this feature: the most relevant words found with your initial search term are added to your initial search term and the final search is performed. The query returns a broader result with your 
		-- search term and what might be interesting, if you agree with defining interesting in this way.
		select * from producto where match(nombre, descripcion) against ("planta");
		select * from producto where match(nombre, descripcion) against ("planta" in natural language mode);
		select * from producto where match(nombre, descripcion) against ("planta" in boolean mode);
		select * from producto where match(nombre, descripcion) against ("planta" with query expansion);

	-- Contienen la palabra planta seguida de cualquier carácter o conjunto de caracteres, en el nombre o en la descripción.
		-- ????

	-- Empiezan con la palabra "planta" en el nombre o en la descripción.
		select * from producto where match(nombre, descripcion) against ("Planta") and (descripcion like 'Planta%' or nombre like 'Planta%');

	-- Contienen la palabra "tronco" o la palabra "árbol" en el nombre o en la descripción.
		select * from producto where match(nombre, descripcion) against ("tronco") or match(nombre, descripcion) against ("árbol");
        
	-- Contienen la palabra "tronco" y la palabra "árbol" en el nombre o en la descripción.
		select * from producto where match (nombre, descripcion) against ("tronco") and match (nombre, descripcion) against ("árbol");

	-- Contienen la palabra "tronco" pero no contienen la palabra "árbol" en el nombre o en la descripción.
		select * from producto where match (nombre, descripcion) against ("tronco" in boolean mode) and match (nombre, descripcion) against ("-árbol" in boolean mode);

	-- Contiene la frase "proviene de las costas" en el nombre o en la descripción.
		select * from producto where match (nombre, descripcion) against ("proviene de las costas");


-- 8. Crea un índice de tipo INDEX compuesto por las columnas apellido_contacto y nombre_contacto de la tabla cliente.
drop index dos_columnas on cliente;
create index dos_columnas on cliente(apellido_contacto, nombre_contacto);


-- 9. Una vez creado el índice del ejercicio anterior realice las siguientes consultas haciendo uso de EXPLAIN:

	-- Busca el cliente Javier Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
    -- 1 fila.
		explain select *
		from cliente
		where apellido_contacto = 'Villar' and nombre_contacto = 'Javier';

	-- Busca el cliente anterior utilizando solamente el apellido Villar. ¿Cuántas filas se han examinado hasta encontrar el resultado?
    -- 1 fila.
		explain select *
		from cliente
		where apellido_contacto = 'Villar';

	-- Busca el cliente anterior utilizando solamente el nombre Javier. ¿Cuántas filas se han examinado hasta encontrar el resultado? ¿Qué ha ocurrido en este caso?
    -- 36 filas.
		explain select *
				from cliente
				where nombre_contacto = 'Javier';

-- 10. Calcula cuál podría ser un buen valor para crear un índice sobre un prefijo de la columna nombre_cliente de la tabla cliente. 
-- Tenga en cuenta que un buen valor será aquel que nos permita utilizar el menor número de caracteres para diferenciar todos los valores que existen en la columna sobre la que estamos creando el índice.

	-- En primer lugar calculamos cuántos valores distintos existen en la columna nombre_cliente. Necesitarás utilizar la función COUNT y DISTINCT.
		select count(distinct(nombre_cliente)) from cliente;

	-- Haciendo uso de la función LEFT ve calculando el número de caracteres que necesitas utilizar como prefijo para diferenciar todos los valores de la columna. 
	-- Necesitarás la función COUNT, DISTINCT y LEFT.
		select count(distinct left(nombre_cliente, 11)) from cliente;

	-- Una vez que hayas encontrado el valor adecuado para el prefijo, crea el índice sobre la columna nombre_cliente de la tabla cliente.
		drop index nombre_cliente_prefijo on cliente;
		create index nombre_cliente_prefijo on cliente(nombre_cliente,(11));

	-- Ejecuta algunas consultas de prueba sobre el índice que acabas de crear.
		explain select distinct nombre_cliente from cliente where nombre_cliente like 'Campohermoso';