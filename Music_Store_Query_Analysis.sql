--  Q1. who is the senior most employee based on the job?

SELECT * FROM employee
order by levels desc 
limit 1;


/* Q2: Which countries have the most Invoices? */

select count(*) as c ,billing_country 
from invoice
group by billing_country
order by c desc ;


/* Q3: What are top 3 values of total invoice? */

select total from invoice
order by total desc
limit 3;



/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select sum(total) as invoice_total , billing_city
from invoice
group by billing_city
order by invoice_total desc;




/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT customer.customer_id, customer.first_name, customer.last_name, 
       SUM(invoice.total) AS total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total DESC
LIMIT 1;



/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */



/*Method 1 */

select distinct email , first_name,last_name
from customer 
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
where track_id in (
     select track_id from track 
     join genre on track.genre_id=genre.genre_id
     where genre.name like "Rock"
)
order by email;



/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */


SELECT artist.artist_id, artist.name, COUNT(track.track_id) AS number_of_songs
FROM track
JOIN album2 ON album2.album_id = track.album_id
JOIN artist ON artist.artist_id = album2.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock'
GROUP BY artist.artist_id, artist.name
ORDER BY number_of_songs DESC
LIMIT 10;



/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select name,milliseconds
from track
where milliseconds > 
      (select avg(milliseconds) as avg_song_length
      from track)
 order by milliseconds desc;     


