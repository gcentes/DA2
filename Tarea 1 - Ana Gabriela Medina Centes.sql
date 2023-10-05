-- Query del Ejercicio #1
SELECT * 
FROM FILM
WHERE REPLACEMENT_COST/RENTAL_RATE<4


-- Query del Ejercicio #2
SELECT DISTINCT F.FILM_ID, F.TITLE
FROM FILM F
JOIN FILM_CATEGORY FC ON FC.FILM_ID=F.FILM_ID
JOIN CATEGORY C ON FC.CATEGORY_ID=C.CATEGORY_ID
WHERE F.RELEASE_YEAR=2006
AND F.RENTAL_RATE IN (0.99, 2.99)
AND F.REPLACEMENT_COST<19.99
AND F.LENGTH BETWEEN 90 AND 150
AND F.RATING IN ('G','PG','PG-13')
AND F.RENTAL_DURATION<6
AND C.NAME IN ('Comedy','Family','Children')

-- Query del Ejercicio #3
SELECT 	TO_CHAR(R.RENTAL_DATE,'DD-MON-YYYY') AS "Fecha de Renta",
		TO_CHAR(R.RENTAL_DATE,'HH24:MI') AS "Hora de Renta",
		F.TITLE AS "Titulo",
		C.FIRST_NAME ||' '|| C.LAST_NAME AS "Nombre del Cliente",
		C.EMAIL AS "Email del Cliente",
		A.PHONE AS "Telefono del Cliente",
		A.ADDRESS ||'. '|| A.DISTRICT ||', '|| A.POSTAL_CODE ||'. '|| CIT.CITY ||', '|| CO.COUNTRY ||'.' AS "Direccion Completa del Cliente",
		S.FIRST_NAME ||' '|| S.LAST_NAME AS "Nombre del Empleado"
FROM RENTAL R
JOIN INVENTORY I ON R.INVENTORY_ID=I.INVENTORY_ID
JOIN FILM F ON I.FILM_ID=F.FILM_ID
JOIN CUSTOMER C ON R.CUSTOMER_ID=C.CUSTOMER_ID
JOIN ADDRESS A ON C.ADDRESS_ID=A.ADDRESS_ID
JOIN CITY CIT ON A.CITY_ID=CIT.CITY_ID
JOIN COUNTRY CO ON CIT.COUNTRY_ID=CO.COUNTRY_ID
JOIN STAFF S ON R.STAFF_ID=S.STAFF_ID
WHERE R.RENTAL_DATE>='2005-07-31' AND R.RENTAL_DATE < '2005-08-01'
ORDER BY R.RENTAL_DATE

-- Query del Ejercicio #4
SELECT 	TO_CHAR(R.RENTAL_DATE,'DD-MON-YYYY') AS "Fecha de Renta",
		TO_CHAR(R.RENTAL_DATE,'HH24:MI') AS "Hora de Renta",
		C.FIRST_NAME ||' '|| C.LAST_NAME AS "Nombre Completo del Cliente",
		AD.PHONE AS "Teléfono del Cliente",
		COC.COUNTRY AS "Pais de Residencia del Cliente",
		S.FIRST_NAME ||' '|| S.LAST_NAME AS "Nombre Completo del Empleado",
		AST.PHONE AS "Telefono del Empleado",
		COS.COUNTRY AS "Pais de Residencia del Empleado"
FROM RENTAL R
JOIN CUSTOMER C ON R.CUSTOMER_ID=C.CUSTOMER_ID
JOIN ADDRESS AD ON C.ADDRESS_ID= AD.ADDRESS_ID
JOIN CITY CIC ON AD.CITY_ID=CIC.CITY_ID
JOIN COUNTRY COC ON CIC.COUNTRY_ID=COC.COUNTRY_ID
JOIN STAFF S ON R.STAFF_ID=S.STAFF_ID
JOIN ADDRESS AST ON S.ADDRESS_ID=AST.ADDRESS_ID
JOIN CITY CIS ON AST.CITY_ID=CIS.CITY_ID
JOIN COUNTRY COS ON CIS.COUNTRY_ID=COS.COUNTRY_ID
WHERE R.RENTAL_DATE >='2005-07-31' AND R.RENTAL_DATE < '2005-08-01'
ORDER BY R.RENTAL_DATE

-- Query del Ejercicio #5
SELECT R.RENTAL_DATE, F.TITLE, F.RENTAL_RATE, P.AMOUNT
FROM RENTAL R
JOIN PAYMENT P ON P.RENTAL_ID=R.RENTAL_ID
JOIN INVENTORY I ON R.INVENTORY_ID=I.INVENTORY_ID
JOIN FILM F ON I.FILM_ID=F.FILM_ID
WHERE EXTRACT(YEAR FROM R.RENTAL_DATE)=2005
AND EXTRACT(MONTH FROM R.RENTAL_DATE)=8
AND F.RENTAL_RATE<>P.AMOUNT
ORDER BY R.RENTAL_DATE