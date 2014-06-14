import csv
import math
'''
    CSV read/write helpers
'''

# Write a list of list into a csv file
def write_csv (csv_file, list_of_list):
    with open(csv_file, "wb") as f:
        writer = csv.writer(f)
        writer.writerows(list_of_list)


# Read a csv file into a list of list
def read_csv (csv_file):
    data = []
    with open(csv_file, "rU") as f:
        reader = csv.reader(f)
        for row in reader:
            data.append (row)
    return data


data = read_csv ("schedule.csv")
write_csv ("schedul2.csv", data)
