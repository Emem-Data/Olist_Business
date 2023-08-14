# Olist Business Data Cleaning

In this documentation, we outline the meticulous process undertaken to ensure the accuracy and reliability of the data within the context of the Olist e-commerce business. Olist, a prominent Brazilian e-commerce platform, serves as a vital conduit linking small and medium-sized enterprises with customers throughout Brazil. The subsequent sections provide an insight into the rigorous cleaning procedures adopted to refine the data and guarantee its integrity, thereby fortifying the foundation upon which informed business decisions are predicated.

The dataset used for our analysis consists of data from orders placed between January 2017 and August 2018. It's divided into 9 tables, each holding different types of information. These tables include details about customers, locations, items ordered, payments made, customer reviews, orders, products, sellers, and translated product categories.

I chose Azure Data Studio as my editor for this task. After adding the SQL Server Import extension, I set up a new database and used the extension to bring in my data.

STEP 1                                                                                                       |  STEP 2  
-------------------------------------------------------------------------------------------------------------|------------------------- 
![Inked1](https://github.com/Emem-Data/Olist_Business/assets/103915142/a47e019f-396f-46ed-9ae3-a85da72550d6) | ![2](https://github.com/Emem-Data/Olist_Business/assets/103915142/25008660-208c-4589-8146-32429e5b8b59)


STEP 3(Change datatype where necessary)                                                                 |  STEP 4
--------------------------------------------------------------------------------------------------------|----------------------------- 
![3](https://github.com/Emem-Data/Olist_Business/assets/103915142/78282060-2b21-4fda-b9ef-6fe7d4b51f2a) | ![4](https://github.com/Emem-Data/Olist_Business/assets/103915142/617a85bc-4a99-45f9-b631-975f52a66b91)

![5](https://github.com/Emem-Data/Olist_Business/assets/103915142/234def28-39a0-4cf5-a345-43894632c733)


## 1. CUSTOMER TABLE CLEANING

![DC-cust1](https://github.com/Emem-Data/Olist_Business/assets/103915142/826a1d30-9393-4651-8054-becea0ae83ab)
   
a. **CHECK FOR MISSING DATA ACROSS EACH COLUMN**

![DC-cust2](https://github.com/Emem-Data/Olist_Business/assets/103915142/37943d4f-b0fc-449f-adf8-f4779ce61af8)

We confirmed that the Customers table has no missing data. However, we identified a potential issue: the 'customer_state' column uses abbreviations, which could complicate our analysis. Additionally, entries in the 'customer_city' column are in lowercase. Our upcoming task involves improving this by replacing state abbreviations with full names and capitalizing city names.

b. **CAPITALIZE THE CUSTOMER CITY COLUMN**

![DC-cust3](https://github.com/Emem-Data/Olist_Business/assets/103915142/ac532688-2327-427e-b270-2ba6f9ad10df)

c. **CREATE A FUNCTION TO CHANGE STATE ABBREVIATIONS TO FULL NAMES**

We developed a function called 'GetFullCountryName' to substitute abbreviations in the 'customer_state' column with their corresponding full names. Despite the name confusion (it should have been 'GetFullStateName'), this function serves a vital purpose. It streamlines the cleaning process for other tables that encounter similar issues, reducing the need to rewrite the code each time

![DC-cust4](https://github.com/Emem-Data/Olist_Business/assets/103915142/a8bef347-e8ac-4543-9247-3db657fc391a)

d. **REFINED TABLE:**

![DC-cust5](https://github.com/Emem-Data/Olist_Business/assets/103915142/cc981a41-5d51-48e1-85e2-414e4d2fb963)

## 2. GEOLOCATION TABLE CLEANING

![DC-geo1A](https://github.com/Emem-Data/Olist_Business/assets/103915142/c541ca2f-c331-4c92-a595-49d8d88dc5e6)

a. **REMOVE ACCENT**

In the geolocation table, we observed an issue with accents and special characters in the 'geolocation_city' column. To address this, we established a function named 'RemoveAccentChars.' This function replaces accents with appropriate letters and eliminates special characters. Its utility extends to other tables encountering similar problems, streamlining the cleaning process across the dataset.

![DC-geo1](https://github.com/Emem-Data/Olist_Business/assets/103915142/f2338983-0bb9-4d41-bbc1-e376425df3c5)

b. **CAPITALIZE THE GEOLOCATION CITY, AND REUSE THE FUNCTION 'GETFULLCOUNTRYNAME' TO REPLACE THE GEOLOCATION STATE WITH FULL NAMES**

![DC-geo2](https://github.com/Emem-Data/Olist_Business/assets/103915142/d6243c40-7238-4263-8eeb-05b965abf3b3)

c. **CHECK FOR MISSING DATA ACROSS EVERY COLUMN**

![DC-geo4](https://github.com/Emem-Data/Olist_Business/assets/103915142/18fca759-be7f-4126-bfea-6078b7ed467e)

There are no missing data in the Geolocation table

d. **REFINED TABLE:**

![DC-geo3](https://github.com/Emem-Data/Olist_Business/assets/103915142/7734b477-6bcf-4937-8a61-0bd6199653ad)


## GENERAL CHECK FOR OTHER TABLES: Check for Missing Data across every column


RESULT 1                                                                                                     | RESULT 2
-------------------------------------------------------------------------------------------------------------|------------------------- 
![RESULT_missingValues](https://github.com/Emem-Data/Olist_Business/assets/103915142/915613e5-59ea-44c1-bb6c-2fa483e3c02c) | ![RESULT_missingValuesTwo](https://github.com/Emem-Data/Olist_Business/assets/103915142/b14147f1-fc9a-40f1-a09c-aa3454a0e62d)


After examining missing values across all tables, we found that the Order_items, Order_payments, Sellers, and Product_category_name_translation tables are complete without any missing entries.
However, the Orders table has 3 columns with missing data, the Products table has 8 columns with missing data, and the Review table has 2 columns with missing data.


## 3. PRODUCT TABLE CLEANING

![DC-prodd2](https://github.com/Emem-Data/Olist_Business/assets/103915142/bfbf773c-337e-437b-bd54-c0058ce5816f)

a. **WE REPLACE NULL VALUES IN "product_category_name" WITH 'NA'**

![DC-prodd1](https://github.com/Emem-Data/Olist_Business/assets/103915142/801aa263-25f1-4e1c-a49a-3c34a76fb736)

b. **WE REPLACE REMAINING 7 COLUMNS WITH 0**

Among the 8 columns with missing data in the Products table, 7 columns are of the INT data type. To address this, we replaced the null values in these columns with 0.

![DC-prodd1A](https://github.com/Emem-Data/Olist_Business/assets/103915142/ce6eed21-b061-4d07-b3ff-fb13ee91c0b2)

c. **REPLACE “product_category_name” IN PRODUCT TABLE WITH THE TRANSLATION FROM THE product_category_name_english TABLE**

![DC-prodd3](https://github.com/Emem-Data/Olist_Business/assets/103915142/25f3e801-2642-4627-8b3a-b8eec735ae57)

d. **REFINED TABLE:**

![DC-prodd4](https://github.com/Emem-Data/Olist_Business/assets/103915142/7088aa10-7464-40e0-be0c-f7a6a11e8cd5)

## 4. SELLER TABLE CLEANING

![DC-sell1](https://github.com/Emem-Data/Olist_Business/assets/103915142/07d09135-ccd1-4fb8-accb-88b06ceeb6e8)

a. **CAPITALIZE THE GEOLOCATION CITY COLUMN AND REPLACE GEOLOCATION STATE COLUMN WITH THE FULL NAMES USING THE CREATED FUNCTIONS**

![DC-sell2](https://github.com/Emem-Data/Olist_Business/assets/103915142/dd4e56a5-1bba-45c8-8e50-5401bbb4a44d)

b. **FIX MISREPRESENTATION IN SELLER_CITY**

While examining the Sellers table, we identified discrepancies in city names such as 'Sao paulo -sp' and 'Sao paulop,' which inaccurately represent the city 'Sao Paulo.' To establish consistency, we employed the CASE clause to update the city column, replacing various misrepresentations with the correct city name 'Sao Paulo' across the table.

![misspells1](https://github.com/Emem-Data/Olist_Business/assets/103915142/125a3632-af79-4593-85ac-196099d4f2d0)


![DC-sell3](https://github.com/Emem-Data/Olist_Business/assets/103915142/1b62c399-c3c7-4e94-9977-19e4bec0438d)

![InkedDC-sell3A](https://github.com/Emem-Data/Olist_Business/assets/103915142/29a9abdf-5866-4cb5-92e0-08a5509cf139)

c. **LASTLY, WE USE THE "REMOVEACCENTCHARS" FUNCTION WE CREATED EARLIER TO ELIMINATE ANY ACCENT AND THE TRIM FUNCTION TO REMOVE EXTRA WHITESPACES**

![DC-sell4](https://github.com/Emem-Data/Olist_Business/assets/103915142/7a2754b8-13dd-4ce9-83bc-678753d1ddac)

d. **REFINED TABLE:**

![DC-sell5](https://github.com/Emem-Data/Olist_Business/assets/103915142/f5ff4520-f360-4205-b32d-7eddc909b84e)

## 5. REVIEW TABLE CLEANING

![DC-review2](https://github.com/Emem-Data/Olist_Business/assets/103915142/66b87dbf-91a1-43f0-8d8c-9ffa37c1f2af)

In the Review table, a substantial number of missing entries was encountered, with over 80 thousand in the Review_title column and about 58 thousand in the Review_message column. As part of the cleaning process, I chose to remove the Review_title column. However, I plan to retain the Review_message column for future sentiment analysis.

![DC-review1](https://github.com/Emem-Data/Olist_Business/assets/103915142/f617e273-2af7-4f83-af6e-b04764d31376)


# CONCLUSION
And that's a wrap on our data-cleaning journey for the Olist e-commerce dataset! We've taken each table by the hand, tidied up the mess, and made sure everything fits just right. We've sorted out tricky abbreviations, waved goodbye to missing data where needed, and even given a makeover to city names. With our trusty 'GetFullCountryName' and 'RemoveAccent' helpers, we've turned confusion into clarity. While we bid adieu to the 'Review_title' column, we're keeping the 'Review_message' for some exciting sentiment analysis down the road. So now, our dataset is looking sharp, all set for insightful explorations and cool insights. As we sign off from this cleaning escapade, we're all geared up to make the most of our shiny, polished data!
