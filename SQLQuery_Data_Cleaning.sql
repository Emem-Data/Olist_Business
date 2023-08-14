/*
## **CUSTOMER TABLE CLEANING**
*/

SELECT TOP(5) * 
FROM  [OlistBusiness].[dbo].[olist_customers_dataset]

-- Check for Missing Data across every columns

SELECT 
    SUM(CASE WHEN [customer_id] IS NULL THEN 1 ELSE 0 END) AS customer_id_missing_values,
    SUM(CASE WHEN [customer_unique_id] IS NULL THEN 1 ELSE 0 END) AS customer_unique_id_missing_values,
    SUM(CASE WHEN [customer_zip_code_prefix] IS NULL THEN 1 ELSE 0 END) AS customer_zip_missing_values,
    SUM(CASE WHEN [customer_city] IS NULL THEN 1 ELSE 0 END) AS customer_city_missing_values,
    SUM(CASE WHEN [customer_state] IS NULL THEN 1 ELSE 0 END) AS customer_state_missing_values
FROM 
    [OlistBusiness].[dbo].[olist_customers_dataset];

-- Capitalize the Customer City column
UPDATE [OlistBusiness].[dbo].[olist_customers_dataset]
SET [customer_city] = CONCAT(UPPER(LEFT([customer_city],1)), LOWER(RIGHT([customer_city], LEN([customer_city])-1)))
GO;
-- Change to Full State Names
CREATE FUNCTION dbo.GetFullCountryName (@abbreviation VARCHAR(50))
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @fullName VARCHAR(50)
    
    SET @fullName = 
        CASE 
            WHEN @abbreviation = 'AL' THEN 'Alagoas'
            WHEN @abbreviation = 'AP' THEN 'Amapa'
            WHEN @abbreviation = 'AM' THEN 'Amazonas'
            WHEN @abbreviation = 'BA' THEN 'Bahia'
            WHEN @abbreviation = 'CE' THEN 'Ceara'
            WHEN @abbreviation = 'DF' THEN 'Districto-Federal'
            WHEN @abbreviation = 'ES' THEN 'Espirito Santo'
            WHEN @abbreviation = 'GO' THEN 'Goias'
            WHEN @abbreviation = 'MA' THEN 'Maranhao'
            WHEN @abbreviation = 'MG' THEN 'Minas-Gerais'
            WHEN @abbreviation = 'MS' THEN 'Mato Grosso-d-Sul'
            WHEN @abbreviation = 'MT' THEN 'Mato-Grosso'
            WHEN @abbreviation = 'PA' THEN 'Para'
            WHEN @abbreviation = 'PB' THEN 'Paraiba'
            WHEN @abbreviation = 'PE' THEN 'Pernambuco' 
            WHEN @abbreviation = 'PI' THEN 'Piaui'
            WHEN @abbreviation = 'PR' THEN 'Parana'
            WHEN @abbreviation = 'RJ' THEN 'Rio-de-Janeiro'
            WHEN @abbreviation = 'RN' THEN 'Rio-Grande-d-Norte'
            WHEN @abbreviation = 'RO' THEN 'Rondonia'
            WHEN @abbreviation = 'RR' THEN 'Roraima'
            WHEN @abbreviation = 'RS' THEN 'Rio-Grande-d-Sul' 
            WHEN @abbreviation = 'SC' THEN 'Santa-Catarina'
            WHEN @abbreviation = 'SE' THEN 'Sergipe'
            WHEN @abbreviation = 'SP' THEN 'Sao-Paulo'
            WHEN @abbreviation = 'TO' THEN 'Tocantins'
            ELSE 'UNKNOWN'
        END
    
    RETURN @fullName
END
GO;

-- Change to Full Country Names2
UPDATE [OlistBusiness].[dbo].[olist_customers_dataset]
SET [customer_state] = dbo.GetFullCountryName([customer_state])

SELECT TOP(5) * FROM [OlistBusiness].[dbo].[olist_customers_dataset]

/*
## **GEOLOCATION TABLE CLEANING**
*/

SELECT TOP(30) * 

FROM  [OlistBusiness].[dbo].[olist_geolocation_dataset]
GO;

-- REMOVE ACCENT

CREATE FUNCTION [dbo].[RemoveAccentChars] (@p_OriginalString VARCHAR(50))

RETURNS VARCHAR(50) AS

BEGIN

  DECLARE @i INT = 1; -- must start from 1, as SubString is 1-based

  DECLARE @OriginalString VARCHAR(50) = @p_OriginalString COLLATE SQL_Latin1_General_CP1253_CI_AI;

  DECLARE @ModifiedString VARCHAR(50) = '';



  WHILE @i <= LEN(@OriginalString)

  BEGIN

    DECLARE @char VARCHAR(1) = SUBSTRING(@OriginalString, @i, 1);

    IF @char LIKE '[a-zA-Z]'

    BEGIN

      SET @ModifiedString = @ModifiedString + @char;

    END

    ELSE IF @char COLLATE Latin1_General_BIN = ' '

    BEGIN

      SET @ModifiedString = @ModifiedString + @char;

    END

    SET @i = @i + 1;

  END



  RETURN @ModifiedString;

END
GO;

UPDATE [OlistBusiness].[dbo].[olist_geolocation_dataset]

SET [geolocation_city] = TRIM(dbo.RemoveAccentChars([geolocation_city]))

-- Capitalize the Geolocation City column

UPDATE [OlistBusiness].[dbo].[olist_geolocation_dataset]

SET [geolocation_city] = CONCAT(UPPER(LEFT([geolocation_city],1)), LOWER(RIGHT([geolocation_city], LEN([geolocation_city])-1)))



-- -- Change to Full Country Names

UPDATE [OlistBusiness].[dbo].[olist_geolocation_dataset]

SET [geolocation_state] = dbo.GetFullCountryName([geolocation_state])

SELECT TOP(30) * 

FROM  [OlistBusiness].[dbo].[olist_geolocation_dataset]

-- Check for Missing Data across every column



SELECT 

    SUM(CASE WHEN [geolocation_zip_code_prefix] IS NULL THEN 1 ELSE 0 END) AS geolocation_zip_code_prefix_missing_values,

    SUM(CASE WHEN [geolocation_lat] IS NULL THEN 1 ELSE 0 END) AS geolocation_lat_missing_values,

    SUM(CASE WHEN [geolocation_lng] IS NULL THEN 1 ELSE 0 END) AS geolocation_lng_missing_values,

    SUM(CASE WHEN [geolocation_state] IS NULL THEN 1 ELSE 0 END) AS geolocation_state_missing_values,

    SUM(CASE WHEN [geolocation_city] IS NULL THEN 1 ELSE 0 END) AS geolocation_city_missing_values

FROM 

    [OlistBusiness].[dbo].[olist_geolocation_dataset];

/*
## GENERAL CHECK FOR OTHER TABLES

### Check for Missing Data across every column
*/

SELECT 

    SUM(CASE WHEN [order_id] IS NULL THEN 1 ELSE 0 END) AS order_id,

    SUM(CASE WHEN [order_item_id] IS NULL THEN 1 ELSE 0 END) AS order_item_id,

    SUM(CASE WHEN [product_id] IS NULL THEN 1 ELSE 0 END) AS product_id,

    SUM(CASE WHEN [seller_id] IS NULL THEN 1 ELSE 0 END) AS seller_id,

    SUM(CASE WHEN [shipping_limit_date] IS NULL THEN 1 ELSE 0 END) AS shipping_limit_date,

    SUM(CASE WHEN [price] IS NULL THEN 1 ELSE 0 END) AS price,

    SUM(CASE WHEN [freight_value] IS NULL THEN 1 ELSE 0 END) AS freight_value

FROM 

    [OlistBusiness].[dbo].[olist_order_items_dataset];

SELECT 

    SUM(CASE WHEN [order_id] IS NULL THEN 1 ELSE 0 END) AS order_id,

    SUM(CASE WHEN [order_id] IS NULL THEN 1 ELSE 0 END) AS order_id,

    SUM(CASE WHEN [payment_type] IS NULL THEN 1 ELSE 0 END) AS payment_type,

    SUM(CASE WHEN [payment_installments] IS NULL THEN 1 ELSE 0 END) AS payment_installments,

    SUM(CASE WHEN [payment_value] IS NULL THEN 1 ELSE 0 END) AS payment_value

FROM 

    [OlistBusiness].[dbo].[olist_order_payments_dataset];

SELECT 

    SUM(CASE WHEN [review_id] IS NULL THEN 1 ELSE 0 END) AS review_id,

    SUM(CASE WHEN [order_id] IS NULL THEN 1 ELSE 0 END) AS order_id,

    SUM(CASE WHEN [review_score] IS NULL THEN 1 ELSE 0 END) AS review_score,

    SUM(CASE WHEN [review_comment_title] IS NULL THEN 1 ELSE 0 END) AS review_comment_title,

    SUM(CASE WHEN [review_comment_message] IS NULL THEN 1 ELSE 0 END) AS review_comment_message,

    SUM(CASE WHEN [review_creation_date] IS NULL THEN 1 ELSE 0 END) AS review_creation_date,

    SUM(CASE WHEN [review_answer_timestamp] IS NULL THEN 1 ELSE 0 END) AS review_answer_timestamp

FROM 

    [OlistBusiness].[dbo].[olist_order_reviews_dataset];

SELECT 

    SUM(CASE WHEN [order_id] IS NULL THEN 1 ELSE 0 END) AS order_id,

    SUM(CASE WHEN [customer_id] IS NULL THEN 1 ELSE 0 END) AS customer_id,

    SUM(CASE WHEN [order_status] IS NULL THEN 1 ELSE 0 END) AS order_status,

    SUM(CASE WHEN [order_purchase_timestamp] IS NULL THEN 1 ELSE 0 END) AS order_purchase_timestamp,

    SUM(CASE WHEN [order_approved_at] IS NULL THEN 1 ELSE 0 END) AS order_approved_at,

    SUM(CASE WHEN [order_delivered_carrier_date] IS NULL THEN 1 ELSE 0 END) AS order_delivered_carrier_date,

    SUM(CASE WHEN [order_delivered_customer_date] IS NULL THEN 1 ELSE 0 END) AS order_delivered_customer_date,

    SUM(CASE WHEN [order_estimated_delivery_date] IS NULL THEN 1 ELSE 0 END) AS order_estimated_delivery_date

FROM 

    [OlistBusiness].[dbo].[olist_orders_dataset];

SELECT 

    SUM(CASE WHEN [product_id] IS NULL THEN 1 ELSE 0 END) AS product_id,

    SUM(CASE WHEN [product_category_name] IS NULL THEN 1 ELSE 0 END) AS product_category_name,

    SUM(CASE WHEN [product_name_lenght] IS NULL THEN 1 ELSE 0 END) AS product_name_lenght,

    SUM(CASE WHEN [product_description_lenght] IS NULL THEN 1 ELSE 0 END) AS product_description_lenght,

    SUM(CASE WHEN [product_photos_qty] IS NULL THEN 1 ELSE 0 END) AS product_photos_qty,

    SUM(CASE WHEN [product_weight_g] IS NULL THEN 1 ELSE 0 END) AS product_weight_g,

    SUM(CASE WHEN [product_length_cm] IS NULL THEN 1 ELSE 0 END) AS product_length_cm,

    SUM(CASE WHEN [product_height_cm] IS NULL THEN 1 ELSE 0 END) AS product_height_cm,

    SUM(CASE WHEN [product_width_cm] IS NULL THEN 1 ELSE 0 END) AS product_width_cm

FROM 

    [OlistBusiness].[dbo].[olist_products_dataset];

SELECT 

    SUM(CASE WHEN [seller_id] IS NULL THEN 1 ELSE 0 END) AS seller_id,

    SUM(CASE WHEN [seller_zip_code_prefix] IS NULL THEN 1 ELSE 0 END) AS seller_zip_code_prefix,

    SUM(CASE WHEN [seller_city] IS NULL THEN 1 ELSE 0 END) AS seller_city,

    SUM(CASE WHEN [seller_state] IS NULL THEN 1 ELSE 0 END) AS seller_state

FROM 

    [OlistBusiness].[dbo].[olist_sellers_dataset];

SELECT 

    SUM(CASE WHEN [product_category_name] IS NULL THEN 1 ELSE 0 END) AS product_category_name,

    SUM(CASE WHEN [product_category_name_english] IS NULL THEN 1 ELSE 0 END) AS product_category_name_english

FROM 

    [OlistBusiness].[dbo].[product_category_name_translation];

/*
 **order\_reviewsorder\_reviews, <span style="color: rgb(255, 255, 255); font-family: Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; white-space: pre;">orders_dataset, and </span> <span style="color: rgb(255, 255, 255); font-family: Consolas, &quot;Courier New&quot;, monospace; font-size: 12px; white-space: pre;">olist_products_dataset have Null Values</span>**
*/

/*
## **PRODUCT TABLE CLEANING**
*/

UPDATE [OlistBusiness].[dbo].[olist_products_dataset]

SET [product_category_name] = 'NA'

WHERE [product_category_name] IS NULL;



SELECT TOP(5) *

FROM [OlistBusiness].[dbo].[olist_products_dataset]

UPDATE [OlistBusiness].[dbo].[olist_products_dataset]

SET 

    product_name_lenght = COALESCE (product_name_lenght, 0),

    product_description_lenght = COALESCE (product_description_lenght, 0), 

    product_photos_qty = COALESCE (product_photos_qty, 0),

    product_weight_g = COALESCE (product_weight_g, 0), 

    product_length_cm = COALESCE (product_length_cm, 0),

    product_height_cm = COALESCE (product_height_cm, 0),

    product_width_cm = COALESCE (product_width_cm, 0);

-- Replace product_category_name in Product Table with the translation from the product_category_name_translation Table

UPDATE products

SET products.product_category_name = translation.product_category_name_english

FROM [OlistBusiness].[dbo].[olist_products_dataset] AS products

INNER JOIN [OlistBusiness].[dbo].[product_category_name_translation] AS translation

ON products.product_category_name = translation.product_category_name;







SELECT  TOP (5) *

FROM [OlistBusiness].[dbo].[olist_products_dataset]

/*
## **SELLER TABLE CLEANING**
*/

SELECT 

   TOP(5) *

FROM 

    [OlistBusiness].[dbo].[olist_sellers_dataset];

-- Capitalize the Customer City column

UPDATE [OlistBusiness].[dbo].[olist_sellers_dataset]

SET [seller_city] = CONCAT(UPPER(LEFT([seller_city],1)), LOWER(RIGHT([seller_city], LEN([seller_city])-1)))



-- Change to Full Country Names2

UPDATE [OlistBusiness].[dbo].[olist_sellers_dataset]

SET [seller_state] = dbo.GetFullCountryName([seller_state])

-- FIX MISSPPELT CITY NAMES

UPDATE [OlistBusiness].[dbo].[olist_sellers_dataset]

SET [seller_city] = CASE

    WHEN [seller_city] = '64482255' THEN 'rio de janeiro'

    WHEN [seller_city] = 'vendescreditpartscombr' THEN 'Maringo'

    WHEN [seller_city] = 'tabao de serra' THEN 'tabooo da serra'

    WHEN [seller_city] = 'seo sebastiao de granosp' THEN 'seo sebastiao'

    WHEN [seller_city] = 'sso jose dos pinhas' THEN 'seo jose dos pinhais' 

    WHEN [seller_city] = 'sao miguel doeste' THEN 'sao miguel do oeste'

    WHEN [seller_city] = 'santo andresao paulo' THEN 'santo andre'

    WHEN [seller_city] = 'pinhaispr' THEN 'pinhais'

    WHEN [seller_city] = 'mauaseo paulo' THEN 'maua'

    WHEN [seller_city] = 'loges so' THEN 'Lages' 

    WHEN [seller_city] = 'brasilio df' THEN 'brasilia'

    WHEN [seller_city] = 'belo horizont' THEN 'belo horizonte'

    WHEN [seller_city] = 'auriflamesp' THEN 'auriflame'

    WHEN [seller_city] = 'angra dos reis rj' THEN 'angra dos reis'

    WHEN [seller_city] = 'jaoarei sao paulo' THEN 'jocarei'

    WHEN [seller_city] = 'imbituva' THEN 'imbituba'

    WHEN [seller_city] = 'ferraz de Vasconcelos' THEN 'Ferraz de vasconcelos' 

    WHEN [seller_city] = 'congonhas' THEN 'congonhal'

    WHEN [seller_city] = 'cascavel' THEN 'cascavel'

    WHEN [seller_city] = 'cariacica es' THEN 'cariacica'

    WHEN [seller_city] = 'carapicuibe sao paulo' THEN 'carapicuiba'

    WHEN [seller_city] = 'barbacena minas gerais' THEN 'barbacena'

    WHEN [seller_city] = 'balenario camboriu' THEN 'balneario Camboriu'

    WHEN [seller_city] IN ('sao pauo', 'sp', 'sao paulop', 'seo paulo  sp', 'sao paulo sp', 'sao paulo sao paulo', 'paluo', 'sp sp') THEN 'Sao paulo'

    WHEN [seller_city] IN ('seo bernardo do capo', 'abcsp', 'abo') THEN 'seo bernardo do campo'

    WHEN [seller_city] IN ('santa barbara doeste', 'santa barbara d oeste') THEN 'santa Barbara do oeste'

    WHEN [seller_city] IN ('seo jose do rio pret', 'a jose do rio preto') THEN 'oo jose do rio preto' 

    WHEN [seller_city] IN ('rio de janeiro rio de janeiro brasil', 'rio de janeiro rio de janeiro', 'rio de janeiro rio de janeiro') THEN 'rio de janeiro'

    WHEN [seller_city] IN ('riberao preto', 'ribeirao pretp', 'ribeirao preto sao paulo') THEN 'ribeirao preto'

    WHEN [seller_city] IN ('mogi das cruzes ap', 'mogi das oruses') THEN 'nogi das cruzes'

ELSE [seller_city]

END;

UPDATE [OlistBusiness].[dbo].[olist_sellers_dataset]

SET [seller_city] = TRIM(dbo.RemoveAccentChars([seller_city]))

SELECT TOP (5) *

FROM [OlistBusiness].[dbo].[olist_sellers_dataset]

/*
## **REVIEW TABLE CLEANING**
*/

-- DELETE COMMENT TITLE COLUMN



ALTER TABLE [OlistBusiness].[dbo].[olist_order_reviews_dataset] DROP COLUMN [review_comment_title];

GO