INSERT INTO dim_customer (customer_id, first_name, last_name, age, email, country, postal_code)
SELECT DISTINCT sale_customer_id,
                customer_first_name,
                customer_last_name,
                customer_age,
                customer_email,
                customer_country,
                customer_postal_code
FROM raw_data_pet_sales ON CONFLICT (customer_id) DO NOTHING;


INSERT INTO dim_seller (seller_id, first_name, last_name, email, country, postal_code)
SELECT DISTINCT sale_seller_id,
                seller_first_name,
                seller_last_name,
                seller_email,
                seller_country,
                seller_postal_code
FROM raw_data_pet_sales ON CONFLICT (seller_id) DO NOTHING;


INSERT INTO dim_supplier (name, contact, email, phone, address, city, country)
SELECT DISTINCT supplier_name,
                supplier_contact,
                supplier_email,
                supplier_phone,
                supplier_address,
                supplier_city,
                supplier_country
FROM raw_data_pet_sales ON CONFLICT (name) DO NOTHING;


INSERT INTO dim_store (name, location, city, state, country, phone, email)
SELECT DISTINCT store_name,
                store_location,
                store_city,
                store_state,
                store_country,
                store_phone,
                store_email
FROM raw_data_pet_sales ON CONFLICT (name) DO NOTHING;


INSERT INTO dim_product (product_id, name, category, price, weight, color, size, brand, material, description, rating,
                         reviews, release_date, expiry_date)
SELECT DISTINCT sale_product_id,
                product_name,
                product_category,
                product_price,
                product_weight,
                product_color,
                product_size,
                product_brand,
                product_material,
                product_description,
                product_rating,
                product_reviews,
                product_release_date,
                product_expiry_date
FROM raw_data_pet_sales ON CONFLICT (product_id) DO NOTHING;


INSERT INTO dim_pet (type, breed)
SELECT DISTINCT customer_pet_type,
                customer_pet_breed
FROM raw_data_pet_sales ON CONFLICT (type, breed) DO NOTHING;


INSERT INTO fact_sales (sale_date, customer_key, seller_key, supplier_key, store_key, product_key, pet_key,
                        sale_quantity, sale_total_price)
SELECT rd.sale_date,
       c.customer_key,
       s.seller_key,
       sup.supplier_key,
       st.store_key,
       p.product_key,
       pt.pet_key,
       rd.sale_quantity,
       rd.sale_total_price
FROM raw_data_pet_sales rd

         JOIN dim_customer c
              ON rd.sale_customer_id = c.customer_id

         JOIN dim_seller s
              ON rd.sale_seller_id = s.seller_id

         LEFT JOIN dim_supplier sup
                   ON rd.supplier_name = sup.name

         JOIN dim_store st
              ON rd.store_name = st.name

         JOIN dim_product p
              ON rd.sale_product_id = p.product_id

         LEFT JOIN dim_pet pt
                   ON rd.customer_pet_type = pt.type
                       AND rd.customer_pet_breed = pt.breed;
