import json
import pandas as pd
import csv
import time
from kafka import KafkaProducer


def main():
    # Create a Kafka producer
    producer = KafkaProducer(
        bootstrap_servers='localhost:9092',
        value_serializer=lambda v: json.dumps(v).encode('utf-8')
    )

    csv_file = 'green_tripdata_2019-10.csv'  # change to your CSV file path if needed
    t0 = time.time()
    with open(csv_file, 'r', newline='', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            # Each row will be a dictionary keyed by the CSV headers
            # Send data to Kafka topic "green-data"
            producer.send('green-data', value=row)

    # Make sure any remaining messages are delivered
    producer.flush()
    t1 = time.time()
    producer.close()
    print(t1-t0)


if __name__ == "__main__":
    main()






"""
def json_serializer(data):
    return json.dumps(data).encode('utf-8')

server = 'localhost:9092'

producer = KafkaProducer(
    bootstrap_servers=[server],
    # api_version=(0,11,5),
    value_serializer=json_serializer
)

producer.bootstrap_connected()

df = pd.read_csv("green_tripdata_2019-10.csv", low_memory=False)
cols = ['lpep_pickup_datetime','lpep_dropoff_datetime', 'PULocationID','DOLocationID','passenger_count',
'trip_distance','tip_amount']
df = df[cols]
df_dict = df.to_dict(orient='records')

topic = 'green-trips'
t0 = time.time()

for item in df_dict:
    producer.send(topic, value=item)

producer.flush()

t1 = time.time()

took = t1 - t0

print(took)
"""