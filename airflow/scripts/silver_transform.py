import sqlalchemy as sa
import os
from airflow.providers.postgres.hooks.postgres import PostgresHook
from urllib.parse import quote_plus

def run_silver_transform():
    # connect to PostgreSQL db
    pg_hook = PostgresHook(postgres_conn_id='property_db')
    conn = pg_hook.get_connection('property_db')

    db_user = quote_plus(conn.login) if conn.login else ''
    db_pass = quote_plus(conn.password) if conn.password else ''
    db_host = conn.host
    db_port = conn.port
    db_name = conn.schema

    connection_uri = f"postgresql://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}"

    engine = sa.create_engine(connection_uri)

    # read and execute the SQL transformation script
    current_dir = os.path.dirname(os.path.abspath(__file__))
    sql_path = os.path.join(current_dir, '../sql/silver_transform.sql')
    print(f"Executing SQL file from: {sql_path}")
    
    try:
        with open(sql_path, 'r') as f:
            sql_script = f.read()

        with engine.begin() as connection:
            connection.execute(sa.text(sql_script))
            
        print("Data transformation completed successfully using SQL.")
        
    except FileNotFoundError:
        print(f"Error: Could not find SQL file at {sql_path}")
        raise
    except Exception as e:
        print(f"Error executing SQL: {e}")
        raise

# if __name__ == "__main__":
#     run_silver_transform()