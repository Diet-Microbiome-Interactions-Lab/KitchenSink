import csv
import pandas as pd
#import fire
import re


# Function to transform text to snake case
def string_to_snake_case(string):
    # Replace non-word characters (anything not a letter, number, or underscore) with spaces
    string = re.sub(r'[^\w\s]', ' ', string)
    # Convert the string into lowercase and split into words
    words = string.lower().split()
    # Join words with underscores
    return '_'.join(words)

# Optional Parameters
def optional_parameters():
    # Initialize an empty list to store words
    words = []  
    print("Enter optional parameters for data collection (type 'done' to finish):")
    # Loop for user input of other parameters
    while True:
        word = string_to_snake_case(input("Enter a word: "))  # Take user input
        if word.lower() == 'done':  # If user types 'done', exit the loop, Then add other parameters that are required
            words.append("time_point")
            words.append("repetitions")
            words.append("optical_density")
            break
        words.append(word)  # Add the entered word to the list
    return words

# Function to define parameters
def define_parameters():
    #Required Parameters
    parameters = [
        "sample_id",
         "inoculum",
         "media_base",
         "oxygenation"]
    # Extend required parameters with optional parameters
    parameters.extend(optional_parameters())
    return parameters

# Function to populate parameters
def define_parameter_values(parameter):
    parameter_values = []
    print("Values for " + str(parameter) + " (Type 'done' when finished): ")
    while True:
        value = string_to_snake_case(input("Enter a value: "))  # Take user input
        if value.lower() == 'done':  # If user types 'done', exit the loop, Then add other parameters that are required
          break
        parameter_values.append(value)  # Add the entered word to the list
    return parameter_values

#Function to filter parameters that will be asked to be filled out
def filter_parameters():
    parameters = define_parameters()
    exclude = {'sample_id',
               'optical_density'}
    filtered_parameters = [parameter for parameter in parameters if parameter not in exclude ]
    return filtered_parameters

#Function to define parameters dictionary based on the established parameters
def parameters_dictionary():
    parameters = filter_parameters()
    parameters_dictionary = {}
    for parameter in parameters:
        parameters_dictionary[parameter] = define_parameter_values(parameter) 
    return parameters_dictionary



# Create CSV file and populate parameters and values.
def growth_curve_csv():
    # Define the file name
    file_name = string_to_snake_case(input("Define a name for your file: "))
    # Instantiate .csv file
    with open((file_name + ".csv"), 'w', newline='') as file:
        writer = csv.writer(file)
        # Populate Parameters
        writer.writerow(header for header in define_parameters())
        # Populate Parameter values
    print("Data collection sheet has been created!")

growth_curve_csv()
# Entry point
#if __name__ == "__main__":
#    fire.Fire(growth_curve)

