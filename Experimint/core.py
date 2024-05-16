import csv
from utility import *

 # Create CSV file
def csv_write(filename, blocks, treatments, repeat_measurement, repetition_integer, measurements): #ADD measurements
    # Define the file name
    file_name = string_to_snake_case(filename)
    # Define column names
    defined_column_names = define_column_names(experimental_design_columns(blocks,treatments,repeat_measurement),measurements)
    # Define column values in dictionary
    dictionary = experimental_design_dictionary(experimental_design_columns(blocks,treatments,repeat_measurement), repetition_integer)
    # Instantiate .csv file
    with open((file_name + ".csv"), 'w', newline='') as file:
        writer = csv.writer(file)
        # Insert experimental design column names
        writer.writerow(header for header in defined_column_names)
        # Populate experimental design column values
        for combination in value_combinations(dictionary):
            # Convert tuple to list and insert an empty string at the beginning
            modified_combination = list(combination)
            modified_combination.insert(0, define_sample_id(combination))
            writer.writerow(modified_combination)
        # Insert additional column names


    print("Data collection sheet has been created!")

# Populate CSV file 

# Assign a sampleID
