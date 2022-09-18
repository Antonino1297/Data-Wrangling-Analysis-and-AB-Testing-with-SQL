--1.  Return email addresses, but only for non-deleted users.

SELECT
email_address,
id
FROM dsv1069.users
WHERE deleted_at is NULL

--2.  Use the items table to count the number of items for sale in each category.

SELECT
COUNT(name) AS items_for_sale,
category
FROM dsv1069.items
GROUP BY category

--3.  Select all of the columns from the result when you JOIN the users table to the orders table.

SELECT *
FROM dsv1069.orders o
INNER JOIN dsv1069.users u
ON u.id = o.user_id

--4.  Count the number of viewed_item events.

SELECT
COUNT(DISTINCT event_id) AS events
FROM dsv1069.events
WHERE event_name = 'view_item'

--5.  Compute the number of items in the items table which have been ordered.

SELECT
COUNT(DISTINCT orders.item_id) AS item_count
FROM dsv1069.orders 

--6.  For each user figure out IF a user has ordered something, and when their first purchase was.

SELECT
  users.id AS user_id,
  MIN(orders.paid_at) AS min_paid_at
FROM dsv1069.users
LEFT JOIN dsv1069.orders
ON orders.user_id = users.id
GROUP BY users.id

--7.  Figure out what percent of users have ever viewed the user profile page.

SELECT
(CASE WHEN first_view ISNULL THEN false
      ELSE true END) AS has_viewed_profile_page,
COUNT(user_id) AS users
FROM
(
  SELECT
    users.id AS user_id,
    MIN(event_time) AS first_view
  FROM
    dsv1069.users
  LEFT JOIN
    dsv1069.events
  ON
    events.user_id = users.id
  AND
    event_name = 'view_user_profile'
  GROUP BY 
	users.id
) first_profile_views
GROUP BY
  (CASE WHEN first_view ISNULL THEN false
      ELSE true END)
