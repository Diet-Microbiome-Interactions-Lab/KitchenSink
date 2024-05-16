import csv
from utility import *

 # Create CSV file
def csv_write(args) -> int: #ADD measurements
    '''
    Parse arguments and write a csv file
    '''
    filename, measurements, treatments = args.filename, args.measurements, args.treatments
    # Optional arguments:
    blocks, repeat_measurement, repetition_integer = args.block, args.repeat_measurement, args.repetitions

    clean_filename = string_to_snake_case(filename)

    experimental_columns = experimental_design_columns(blocks,treatments,repeat_measurement)
    column_names = define_column_names(experimental_columns,measurements)
    
    # Define column values in dictionary
    column_values = experimental_design_dictionary(experimental_columns, repetition_integer)

    with open((clean_filename + ".csv"), 'w', newline='') as file:
        writer = csv.writer(file)
        # Insert experimental design column names
        writer.writerow(column_names)
        # Populate experimental design column values
        for combination in value_combinations(column_values):
            # Convert tuple to list and insert an empty string at the beginning
            print(f'Combination: {combination}')
            modified_combination = list(combination)
            modified_combination.insert(0, define_sample_id(combination))
            writer.writerow(modified_combination)


    print("Data collection sheet has been created!")
    return 0  # 0 is a success status code (1 is failure)


# TODO:
#   Populate CSV file 
#   Assign a sampleID
