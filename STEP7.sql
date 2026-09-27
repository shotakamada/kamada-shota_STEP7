--設問１
SELECT
    *
FROM
    `users`;

--設問2
SELECT
    *
FROM
    `users`
WHERE
    created_at LIKE '2024%';

--設問3
SELECT
    *
FROM
    `users`
WHERE
    `age` > 30 AND `gender` = 'female';

--設問4
SELECT
    `product_name`, `price`
FROM
    `products`;

--設問5
SELECT
    `name` AS 'ユーザー名',
    `order_date` AS '注文日',
FROM
    `users`
JOIN
    `orders`;

--設問6
SELECT
    `product_name.name` AS '商品名',
    `order_items.quantity` AS '数量',
    `products.price` AS '単価',
    `product.price` * `order_items.quantity` AS '金額'
FROM
    `order_items`
JOIN
    `products`
ON
    `order_items.product_id` = `products.id`;

--設問7
SELECT
    `users`. `id` AS 'ユーザー名',
    COUNT(`oders`. `id`) AS '注文件数'
FROM
    `users`
JOIN
    `orders`
ON
    `users`. `id` = `orders`. `user_id`
GROUP BY
    `users`. `id`;

--設問8
SELECT
    `users`. `name` AS 'ユーザー名',
    SUM(`products`. `price` * `order_items`. `quantity`) AS '総購入金額'
FROM
    `users`
JOIN
    `orders`
ON
    `users`. `id` = `orders`. `user_id`
JOIN
    `order_items`
ON
    `orders`. `id` = `order_items`. `order_id`
JOIN
    `products`
ON
    `order_items`. `product_id` = `products`. `id`
GROUP BY
    `users`. `name`;

--設問9
SELECT
    users.name AS 'ユーザー名',
    MAX(products.price * order_items.quantity) AS '注文金額'
FROM
    users
JOIN
    orders
ON
    users.id = orders.user_id
JOIN
    order_items
ON
    orders.id = order_items.order_id
JOIN
    products
ON
    product_id = order_items.product_id
GROUP BY
    users.id, users.name
ORDER BY
    '注文金額' DESC
LIMIT 1;

--設問10
SELECT
    products.product_name AS '商品名',
    COUNT(order_items.id) AS '注文回数'
FROM
    products
JOIN
    order_items
ON
    products.id = order_items.product_id
GROUP BY
    products.id, products.product_name
ORDER BY
    '注文回数' DESC;

--設問11
SELECT
    users.name AS 'ユーザー名'
FROM
    users
LEFT JOIN
    orders
ON
    users.id = orders.user_id
WHERE
    orders.id IS NULL;

--設問12
SELECT
    orders.id AS '注文ID'
FROM
    orders
JOIN
    order_items
ON
    orders.id = order_items.order_id
GROUP BY
    orders.id
HAVING
    COUNT(DISTINCT order_items.product_id) >= 2;

--設問13
SELECT
    users.name AS 'ユーザー名',
FROM
    users
JOIN
    orders
ON
    users.id = orders.user_id
JOIN
    order_items
ON
    orders.id = order_items.order_id
JOIN
    products
ON
    order_items.product_id = products.id
WHERE
    products.product_name = 'テレビ';

--設問14
SELECT
    orders.order_date AS '注文日',
    users.name AS 'ユーザー名',
    products.product_name AS '商品名',
    order_items.quantity AS '数量',
    products.price * order_items.quantity AS '合計金額'
FROM
    order_items
JOIN
    orders
ON 
    order_items.order_id = orders.id
JOIN
    users
ON
    orders.user_id = users.id
JOIN
    products
ON
    order_items.product_id = products.id

--設問15
SELECT
    products.product_name AS '商品名',
FROM
    products
JOIN
    order_items
ON
    product_id = order_items.product_id
GROUP BY
    products.id, products.product_name
ORDER BY
    SUM(order_items.quantity) DESC
LIMIT 1;

--設問16
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS '月'、
    COUNT(*) AS '注文件数'
FROM
    orders
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY
    月;

--設問17
SELECT
    products.product_name AS '注文がない商品'
FROM
    products
LEFT JOIN
    order_items
ON
    product.id = order_items.product_id
WHERE
    order_items.id IS NULL;

--設問18
CREATE INDEX idx_name ON order_items (product_id);

--設問19
SELECT
    users.name AS 'ユーザー名',
    AVG(products.price * order_items.quantity) AS '平均注文金額'
FROM
    users
JOIN
    orders
ON
    users.id = oders.user_id
JOIN
    order_items
ON
    orders.id = order_items.order_id
JOIN
    products
ON
    order_items.product_id = products.id
GROUP BY
    users.id, users.name;

--設問20
SELECT
    users.name AS 'ユーザー名',
    MAX(orders.order_date) AS '最近注文日'
FROM
    users
JOIN
    orders
ON 
    users.id = oders.user_id
GROUP BY
    users.id, users.name;

--設問21
INSERT INTO
    `users` (`id`, `name`, `age`, `gender`, `created_at`)
VALUES
    (6, '中村愛', 25, 'female', '2025-06-01');

--設問22
INSERT INTO
    products (id, product_name, price)
VALUES
    (6, 'エアコン', 60000);

--設問23
INSERT INTO
    orders (id, user_id, order_date)
VALUES
    (10, 1, '2025-06-10');

--設問24
INSERT INTO
    order_items (id, order_id, product_id, quantity)
VALUES
    (10, 1, 6, 1);

--設問25
UPDATE
    users
SET
    age = 24
WHERE
    id = 4;

--設問26
UPDATE
    products
SET
    price = price * 1.1;

--設問27
UPDATE
    oders
SET
    order_date = '2024-05-01'
WHERE
    order_date <= '2024-05-01';

--設問28
DELETE
FROM
    users
WHERE
    name = '高橋健一';

--設問29
DELETE
FROM
    order_items
WHERE
    order_id = 5;

--設問30
DELETE
FROM
    products
WHERE
    NOT EXISTS (SELECT 1 FROM order_items WHERE order_items.product_id = products.id);

