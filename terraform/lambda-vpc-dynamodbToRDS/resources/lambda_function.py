import json
import psycopg2
from os import environ




def lambda_handler(event, context):
    conn = psycopg2.connect(
    dbname = environ['DB_NAME'],
    user = environ['DB_USER'],
    password = environ['DB_PASSWORD'],
    host = environ['DB_HOST'],
    port = environ['DB_PORT']
    )
    
    cursor = conn.cursor()
        # Create a cursor object using the cursor() method
    # Process each record in the DynamoDB stream event
    for record in event['Records']:
        # Extract the new image (the added item) from the DynamoDB stream record
        new_image = record['dynamodb']['NewImage']
        
        # Extract the data you want to write to the PostgreSQL database from the new image
        # For example, if your DynamoDB table has attributes 'id', 'name', and 'description', you can extract them like this:
        item_id = new_image['itemId']['S']
        print(item_id)
        
        # Write the data to the PostgreSQL database
        cursor.execute("CREATE TABLE IF NOT EXISTS my_table (itemId VARCHAR(15))")
        cursor.execute("INSERT INTO my_table (itemId) VALUES (%s)", (item_id,))
    
    # Execute the SELECT query
    cursor.execute("SELECT * FROM my_table")

    # Fetch all the results
    results = cursor.fetchall()

    # Print the results
    for row in results:
        print(row)
    
    # Commit the changes to the database
    conn.commit()
    
    # Close communication with the database
    cursor.close()
    conn.close()
