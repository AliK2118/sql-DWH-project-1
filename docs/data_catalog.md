# Data Dictionary for Gold Layer

## Overview

The Gold Layer is the business-level data representation, structured to support analysis and reporting use cases.
It consists of **dimension tables** and a **fact table** for specific business metrics.

---

### 1. gold.dim_customers
- Purpose: stores customer details enrichted with demographic and geographic data
- columns:
  
  | **Column Name**  | **Data Type** |   **Description** |  
  |----------------- | :------------- | ------------------|
  | customer_key     | INT | Aurrogate key uniquely indentifies each customer record in the dimension table.
  | customer_id      | INT | Unique numerical identifier assigned to each customer.
  | customer_number  | NVARCHAR(50) | Alphanumeric identifier representing the customer, used for tracking and referencing.
  |  first_name      | NVARCHAR(50) | The customer's first name as recorded in the system
  | last_name        | NVARCHAR(50) | The customer's last name or family name
  | country          | NVARCHAR(50) | The customer's country of residence (e.g United Kingdom)
  | marital_status   | NVARCHAR(50) | The marital status of the customer (e.g Married, Single)
  | gender   | NVARCHAR(50) | The gender of ther customer (i.e. Male, Female or n/a)
  |birthdate | DATE | The date of birth of the customer, formatted ad YYYY.MM.DD (eg 1976.01.12)
  |create_date | DATE | The date and time when the customer record was created in the system

---

  ### 2. gold.dim_products
  - Purpose: provides information about the products and their attributes
  - Columns:

    | **Column Name** | **Data Type** |  **Description**  |  
    |-----------------|----| ---|
    product_key | INT | surrogate key uniquely identifying each product record in the product dimension table
    product_id |INT | A unique identifier assigned to the product for interal tracking and referencing.
    product_number | NVARCHAR(50) | A structured alphanumeric code representing the product, oten used for categorization or inventory.
    product_name | NVARCHAR(50) | Descriptive name of the product, including key details such as type, color, and size.
    category_id | NVARCHAR(50) | A unique identifier for the product's category, linking to its high-level classification.
    category | NVARCHAR(50) | The broader classification of the product (e.g Bikes, Components) group related items.
    subcategory | NVARCHAR(50) | A more detailed classification of the product within the category, such  as product type....
    maintenance | NVARCHAR(50) | indicates whether the product requires maintenance (e.g. 'Yes', 'No').
    cost | INT | The cost or base price of the product, measured in monetary units.
    product_line | NVARCHAR(50) | The specific product line oro series to which the product belongs ( e.g. Road, Mountain).
    start_date | DATE | The date when the product became available for sale or use, stored

    ---

  ### 3. gold.fact_sales
  - Purpose: stores the transactional sales data for analytical purposes
  - Columns:

    |**Column Name** | **Data Type** |  **Description** |
    |---    |---- |-------|
    ordwer_number | NVARCHAR(50) | A unique alphanumeric identifier for each sales order (e.g 'SOS4496')
    product_key |INT | surrogate key linking the order to the product dimension table
    customer_key | INT | surrogate key linking the order to the customer dimension table
    order_date | DATE | The date when the order was placed
    shipping_date | DATE | The date when the order was shipped to the customer.
    due_date | DATE | The date when the order payment was due.
    sales_amount |INT | The total monetary value of the sale for the line item, in whole currency units (e.g 25)
    quantity | INT | The number of units of the product ordered for the line item (e.g 1)
    price | INT | The price per unit of the product for the line item, in whole currency units (e.g 25)
