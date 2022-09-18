--1.  Using any methods you like determine if you can you trust this events table.
SELECT
  DATE(event_time) AS date,
  COUNT(*) AS rows
FROM
  dsv1069.events_201701
GROUP BY DATE(event_time)

--    We cannot trust this table, because it's dated.

--2.  Using any methods you like, determine if you can you trust this events table.
SELECT
  date(event_time) as date,
  platform,
  COUNT(*)
FROM
  dsv1069.events_ex2
GROUP BY
  date(event_time),
  platform

--    We cannot trust this table, because data is missing before a certain date.

--3.  Imagine that you need to count item views by day. You found this table item_views_by_category_temp - should you use it to answer your questiuon?
SELECT
  *
FROM
  dsv1069.item_views_by_category_temp

--    No data column in it.

--4.  Using any methods you like, decide if this table is ready to be used as a source of truth.SELECT  date(event_time) AS date,  platform,  COUNT(user_id) AS usersFROM  dsv1069.raw_eventsGROUP BY  date(event_time),  platform--    For web events, the user_id is null.--5.   Is this the right way to join orders to users? Is this the right way this join.SELECT
  COUNT(*)
FROM
  dsv1069.orders
JOIN
  dsv1069.users
ON orders.user_id = COALESCE(users.parent_user_id, users.id)

--    Better use the COALESCE function with JOIN.