import itertools
from main import *
import re
# Function to transform text to snake case
def string_to_snake_case(string):
    # Replace non-word characters (anything not a letter, number, or underscore) with spaces
    string = re.sub(r'[^\w\s]', ' ', string)
    # Convert the string into lowercase and split into words
    words = string.lower().split()
    # Join words with underscores
    return '_'.join(words)

# Function to define values for one column
def define_column_values(column):
    column_values = []
    print("Values for " + str(column) + " (Type 'done' when finished): ")
    while True:
        value = string_to_snake_case(input("Enter a value: "))  # Take user input
        if value.lower() == 'done':  # If user types 'done', exit the loop, Then add other parameters that are required
          break
        column_values.append(value)  # Add the entered word to the list
    return column_values

#Define repetition range
def define_repetition_range(integer):
    return list(range(1,integer+1))

#ensure iterable
def ensure_iterable(groups):
    # Return the group as is if it's not None, otherwise return an empty list
    return [group if group is not None else [] for group in groups]


# Define experimental design column names
def experimental_design_columns(blocks, treatments, repeat_measurement):
    experimental_design_column_names = []
    # Process inputs to ensure they are iterable
    blocks, treatments, repeat_measurement = ensure_iterable([blocks, treatments, repeat_measurement])
    experimental_design_column_names.extend(string_to_snake_case(item) for group in [blocks, treatments, repeat_measurement] for item in group)
    return experimental_design_column_names


# Function to define a dictionary with experimental design column names and defines the values for each.
def experimental_design_dictionary(experimental_design_column_names, repetition_integer):
    experimental_design_dictionary = {}
    for name in experimental_design_column_names:
        experimental_design_dictionary[name] = define_column_values(name)
    experimental_design_dictionary.update({'repetitions': define_repetition_range(repetition_integer)})
    return experimental_design_dictionary
 
# Extend measurements to column names
def define_column_names(experimental_design_columns, measurements):
    final_column_names = ["sample_id"]
    final_column_names.extend(experimental_design_columns)
    final_column_names.append("repetitions") 
    final_column_names.extend(string_to_snake_case(item) for group in [measurements] for item in group)   
    return final_column_names

# Function to define combinations of values
def value_combinations(dictionary):
    combinations = list(itertools.product(*dictionary.values()))
    return combinations
















# GROWTH CURVE FUNCTIONS

# Optional Parameters
# def optional_parameters():
#     # Initialize an empty list to store words
#     words = []  
#     print("Enter optional parameters for data collection (type 'done' to finish):")
#     # Loop for user input of other parameters
#     while True:
#         word = string_to_snake_case(input("Enter a word: "))  # Take user input
#         if word.lower() == 'done':  # If user types 'done', exit the loop, Then add other parameters that are required
#             words.append("time_point")
#             words.append("repetitions")
#             words.append("optical_density")
#             break
#         words.append(word)  # Add the entered word to the list
#     return words

# # Function to define parameters
# def define_parameters():
#     #Required Parameters
#     parameters = [
#         "sample_id",
#          "inoculum",
#          "media_base",
#          "oxygenation"]
#     # Extend required parameters with optional parameters
#     parameters.extend(optional_parameters())
#     return parameters
