import csv
import random
import os
import sys

NUM_ROWS = 50

COLUMNS = ["Product_name", "Price", "Quantity", "In_stock"]
num_rows = 100

def generate_row():

    return {
        "Product_name": random.choice(['Laptop', 'Phone', 'Tablet']),
        "Price": round(random.uniform(100, 2000), 2),
        "Quantity": random.randint(1, 100),
        "In_stock": random.choice([True, False]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)

