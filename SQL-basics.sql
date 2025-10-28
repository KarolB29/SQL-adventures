/*
Napisz zapytania, które wyświetlą informacje (sakila.rental) na podstawie poniższych kryteriów:
Write queries that will select informations about:
    o wypożyczeniach z roku 2005,
      /rentals from the year 2005                   */

SELECT *
FROM sakila.rental
WHERE DATE_FORMAT(rental_date, '%Y') = 2005
ORDER BY rental_date DESC;

#       o wypożyczeniach z dnia 2005-05-24, /rentals from a day

SELECT *
FROM sakila.rental
WHERE rental_date >= '2005-01-01 00:00:00' AND rental_date <= '2005-12-31 23:59:59'
ORDER BY rental_date;
#OR
SELECT *
FROM sakila.rental
WHERE rental_date BETWEEN '2005-05-25 00:00:00' AND '2005-05-25 23:59:59';

#       o wypożyczeniach po 2005-06-30, /rentals after 2005-06-30


SELECT *
FROM sakila.rental
WHERE rental_date > '2005-06-30 23:59:59'
ORDER BY rental_date;
#OR
SELECT *
FROM sakila.rental
WHERE rental_date >= '2005-07-01 00:00:00'
ORDER BY rental_date;

/*      o wypożyczeniach w trakcie wakacji, tj. pomiędzy 2005-06-30 a 2005-08-31
            od pracownika Jon'a (sprawdź najpierw jaki ma staff_id w sakila.staff).
        /rentals from summer holidays (between 2005-06-30 and 2005-08-31) and from employee name Jon    */

SELECT first_name,
       staff_id
FROM sakila.staff; /* Jon has staff_id = 2 */

SELECT *
FROM sakila.rental
WHERE rental_date BETWEEN '2005-06-30 00:00:00' AND '2005-08-31 23:59:59' AND staff_id = 2;

/*
2. Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
/Write queries that will show informations from sakila.customer:

    wszystkich aktywnych klientów,  /about all active customers
    wszystkich aktywnych klientów albo tych, którzy zaczynają się od 'ANDRE'. /all active customers or that names starts with 'ANDRE'


3. Napisz kwerendy, które wyświetlą informację z sakila.customer do następujących pytań:
/Write queries to find informations about:
    wszystkich nieaktywnych klientów ze store_id= 1
        /all inactive customers from store of id= 1
    klientów, którzy mają adres email w innej domenie niż sakilacustomer.org. Czy istnieją tacy?
        /all customers that have emails in another domain than sakilacustomer.org. Are there any?
    unikalne wartości w kolumnie create_date.
        /all unique values in column create_date        */
################### AD 2.1: ######################
# SELECT *
# FROM sakila.customer
# WHERE active IS NULL; /* check if any of record in column "active" includes NULL. No nulls so: */

SELECT *
FROM sakila.customer
WHERE active = 1;

################### AD 2.2: ######################
SELECT *
FROM sakila.customer
WHERE active = 1 XOR first_name LIKE 'ANDRE%'
ORDER BY first_name;
/* IMO this has no sense bcs we excluded active customers
that name starts with "ANDRE". A strange thing to do,
but only for exercise to study the difference between OR and XOR */

################### AD 3.1: ######################
SELECT *
FROM sakila.customer
WHERE active = 0 AND store_id = 1;

################### AD 3.2: ######################
SELECT *
FROM sakila.customer
WHERE email NOT LIKE '%@sakilacustomer.org';
/* There are no such customers. Probably when creating account it creates email acount as well. */

################### AD 3.2: ######################
SELECT DISTINCT create_date
FROM sakila.customer;
###################################################

#       Sformatuj kolumnę payment_date z tabeli sakila.payment, zgodnie ze standardem USA.
#       Tak powstałą kolumnę nazwij payment_date_usa_formatted.
#       Convert column 'payment_date' from sakila.payment to USA format and name it 'payment_date_usa_formatted'.

SELECT payment_id,
       amount,
       payment_date,
       DATE_FORMAT(payment_date, GET_FORMAT(DATE, 'USA')) payment_date_usa_formatted
FROM sakila.payment;