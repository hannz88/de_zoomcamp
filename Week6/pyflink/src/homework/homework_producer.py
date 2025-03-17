import json
import time
from kafka import KafkaProducer
import pandas as pd

df = pd.read_csv("green_tripdata_2019-10.csv", low_memory=False)
cols = ['lpep_pickup_datetime','lpep_dropoff_datetime', 'PULocationID','DOLocationID','passenger_count',
'trip_distance','tip_amount']
df = df[cols]
df_dict = df.to_dict(orient='index')


# def json_serializer(data):
#     return json.dumps(data).encode('utf-8')

server = 'localhost:9092'
topic = 'green-trips'

producer = KafkaProducer(
    bootstrap_servers=[server]
    # value_serializer=json_serializer
)

t0 = time.time()

for item in df_dict.items():
    producer.send(topic, value = item)

producer.flush()

t1 = time.time()

took = t1 - t0

print(f'took {(t1 - t0):.2f} seconds')
