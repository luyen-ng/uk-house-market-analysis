from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import timedelta, datetime
import sys

AIRFLOW_HOME = '/opt/airflow/'

if str(AIRFLOW_HOME) not in sys.path:
    sys.path.insert(0, str(AIRFLOW_HOME))

from scripts.bronze_ingest import run_bronze_ingest
from scripts.silver_transform import run_silver_transform
from scripts.gold_aggregate import run_gold_aggregate


default_args = {
    "owner": "airflow",
    "retries": 0,
    "retry_delay": timedelta(minutes=5),
    "start_date": datetime(2025, 6, 25)
}

with DAG(
    dag_id='house_price_medallion_pipeline',
    default_args=default_args,
    schedule_interval=None,
    catchup=False
) as dag:
    bronze = PythonOperator(
        task_id='bronze_ingest',
        python_callable=run_bronze_ingest
    )

    silver = PythonOperator(
        task_id='silver_transform',
        python_callable=run_silver_transform
    )

    gold = PythonOperator(
        task_id='gold_aggregate',
        python_callable=run_gold_aggregate
    )

    bronze >> silver >> gold

# if __name__ == "__main__":
#     dag.test()