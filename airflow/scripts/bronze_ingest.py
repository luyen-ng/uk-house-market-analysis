from airflow.providers.postgres.hooks.postgres import PostgresHook
import pandas as pd
import glob
import sqlalchemy as sa
from urllib.parse import quote_plus

# import data from csv files to postgres db
def run_bronze_ingest():
    csv_dir = f'/opt/airflow/data/*.csv'
    csv_files = glob.glob(csv_dir)
    if not csv_files:
        print("No CSV files found in the specified directory.")
        return
    else:
        print(f"Found {len(csv_files)} CSV files to process.")

    #connect to postgres db
    pg_hook = PostgresHook(postgres_conn_id='property_db')
    conn = pg_hook.get_connection('property_db')

    db_user = quote_plus(conn.login) if conn.login else ''
    db_pass = quote_plus(conn.password) if conn.password else ''
    db_host = conn.host
    db_port = conn.port
    db_name = conn.schema

    connection_uri = f"postgresql://{db_user}:{db_pass}@{db_host}:{db_port}/{db_name}"
    print(f"Connecting to database with URI: {connection_uri}")
    
    engine = sa.create_engine(connection_uri)

    for csv_file in csv_files:
        df = pd.read_csv(csv_file, usecols=[0,1,2,3,4,5,6,9,10,11,12], header=None)

        df = df.rename(columns={
            0: 'transaction_unique_identifier',
            1: 'price',
            2: 'date_of_transfer',
            3: 'postcode',
            4: 'property_type',
            5: 'new_build',
            6: 'tenure',
            9: 'street',
            10: 'district',
            11: 'town_city',
            12: 'county'
        })

        df.to_sql(
            name='house_price',
            con=engine,
            schema='public',
            if_exists='append',
            index=False,
            method='multi',
            chunksize=10_000
        )

# if __name__ == "__main__":
    # run_bronze_ingest()