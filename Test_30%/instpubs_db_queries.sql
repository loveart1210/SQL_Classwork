USE pubs;

SELECT a.au_id, a.au_fname, a.au_lname, COUNT(ta.title_id) AS SoDauSach
FROM authors a
JOIN titleauthor ta ON a.au_id = ta.au_id
GROUP BY a.au_id, a.au_fname, a.au_lname
HAVING COUNT(ta.title_id) >= 2;

SELECT t.title_id, t.title, t.royalty
FROM titles t
WHERE t.royalty < (SELECT AVG(r.royalty) FROM roysched r) - 10;

SELECT t.title_id, t.title, a.au_id, a.au_fname, a.au_lname
FROM titles t
JOIN titleauthor ta ON t.title_id = ta.title_id
JOIN authors a ON ta.au_id = a.au_id
ORDER BY a.au_id DESC;

SELECT e.emp_id, e.fname, e.hire_date
FROM employee e
JOIN publishers p ON e.pub_id = p.pub_id
WHERE p.pub_name = 'Scootney Books';

SELECT s.stor_id, s.stor_name, SUM(sa.qty) AS TongSoLuong
FROM stores s
JOIN sales sa ON s.stor_id = sa.stor_id
GROUP BY s.stor_id, s.stor_name
ORDER BY s.stor_name DESC;

SELECT t.title_id, t.title, t.price, SUM(sa.qty) AS TongBan
FROM titles t
JOIN sales sa ON t.title_id = sa.title_id
JOIN stores s ON sa.stor_id = s.stor_id
WHERE t.price > 17 AND s.state = 'CA'
GROUP BY t.title_id, t.title, t.price
HAVING SUM(sa.qty) < 1000;

SELECT t.title_id, t.title, SUM(sa.qty) AS TongBan
FROM titles t
JOIN sales sa ON t.title_id = sa.title_id
GROUP BY t.title_id, t.title
ORDER BY TongBan ASC;

SELECT t.title_id, t.title, s.stor_id, s.stor_name, SUM(sa.qty) AS SoLuongStore
FROM titles t
JOIN sales sa ON t.title_id = sa.title_id
JOIN stores s ON sa.stor_id = s.stor_id
GROUP BY t.title_id, t.title, s.stor_id, s.stor_name
HAVING SUM(sa.qty) > 0.95 * (
    SELECT AVG(qty)
    FROM sales sa2
    WHERE sa2.title_id = t.title_id
);
