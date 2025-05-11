CREATE TABLE dim_customer
(
    customer_key SERIAL PRIMARY KEY,
    customer_id  INTEGER NOT NULL UNIQUE,
    first_name   VARCHAR(255),
    last_name    VARCHAR(255),
    age          INTEGER,
    email        VARCHAR(255),
    country      VARCHAR(255),
    postal_code  VARCHAR(255)
);



CREATE TABLE dim_seller
(
    seller_key  SERIAL PRIMARY KEY,
    seller_id   INTEGER NOT NULL UNIQUE,
    first_name  VARCHAR(255),
    last_name   VARCHAR(255),
    email       VARCHAR(255),
    country     VARCHAR(255),
    postal_code VARCHAR(255)
);



CREATE TABLE dim_supplier
(
    supplier_key SERIAL PRIMARY KEY,
    name         VARCHAR(255) NOT NULL UNIQUE,
    contact      VARCHAR(255),
    email        VARCHAR(255),
    phone        VARCHAR(255),
    address      VARCHAR(255),
    city         VARCHAR(255),
    country      VARCHAR(255)
);



CREATE TABLE dim_store
(
    store_key SERIAL PRIMARY KEY,
    name      VARCHAR(255) NOT NULL UNIQUE,
    location  VARCHAR(255),
    city      VARCHAR(255),
    state     VARCHAR(255),
    country   VARCHAR(255),
    phone     VARCHAR(255),
    email     VARCHAR(255)
);



CREATE TABLE dim_product
(
    product_key  SERIAL PRIMARY KEY,
    product_id   INTEGER NOT NULL UNIQUE,
    name         VARCHAR(255),
    category     VARCHAR(255),
    price        NUMERIC(10, 2),
    weight       NUMERIC(10, 2),
    color        VARCHAR(255),
    size         VARCHAR(255),
    brand        VARCHAR(255),
    material     VARCHAR(255),
    description  TEXT,
    rating       NUMERIC(3, 1),
    reviews      INTEGER,
    release_date DATE,
    expiry_date  DATE
);



CREATE TABLE dim_pet
(
    pet_key SERIAL PRIMARY KEY,
    type    VARCHAR(60)  NOT NULL,
    breed   VARCHAR(255) NOT NULL,
    UNIQUE (type, breed)
);



CREATE TABLE fact_sales
(
    sales_key        SERIAL PRIMARY KEY,
    sale_date        DATE    NOT NULL,
    customer_key     INTEGER NOT NULL,
    seller_key       INTEGER NOT NULL,
    supplier_key     INTEGER,
    store_key        INTEGER NOT NULL,
    product_key      INTEGER NOT NULL,
    pet_key          INTEGER,
    sale_quantity    INTEGER,
    sale_total_price NUMERIC(10, 2),
    FOREIGN KEY (customer_key) REFERENCES dim_customer (customer_key),
    FOREIGN KEY (seller_key) REFERENCES dim_seller (seller_key),
    FOREIGN KEY (supplier_key) REFERENCES dim_supplier (supplier_key),
    FOREIGN KEY (store_key) REFERENCES dim_store (store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product (product_key),
    FOREIGN KEY (pet_key) REFERENCES dim_pet (pet_key)
);


CREATE INDEX idx_fact_sales_customer_key ON fact_sales (customer_key);
CREATE INDEX idx_fact_sales_seller_key ON fact_sales (seller_key);
CREATE INDEX idx_fact_sales_supplier_key ON fact_sales (supplier_key);
CREATE INDEX idx_fact_sales_store_key ON fact_sales (store_key);
CREATE INDEX idx_fact_sales_product_key ON fact_sales (product_key);
CREATE INDEX idx_fact_sales_pet_key ON fact_sales (pet_key);


CREATE INDEX idx_fact_sales_sale_date ON fact_sales (sale_date);
