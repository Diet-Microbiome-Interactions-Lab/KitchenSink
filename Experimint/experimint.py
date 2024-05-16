import argparse
from core import *

def main(): 
    parser = argparse.ArgumentParser(
                    prog='Data Collection Sheet Generator',
                    description='This program eliminates the manual work of carpentering data collection sheets files, bridging the time gap between effective experimental design and laboratory testing.'
                    )
    parser.add_argument('-fn','--filename',
                        help= 'Required argument to specify the name of the output file.',
                        metavar='File Name',
                        type=str,
                        required=True)
    parser.add_argument('-b','--block',
                        help = 'Optional parameter used to separate a group of experimental units based on blocking criteria.',
                        type=str,
                        nargs='*',
                        metavar='Experimental Blocks',
                        required=False)
    parser.add_argument('-t','--treatments',
                        help='Required parameter, specifying different criteria for classification of experimental units.',
                        type=str,
                        nargs="*",
                        metavar='Treatments',                                   
                        required=True)
    parser.add_argument('-r','--repetitions',
                        help='Optional parameter to specify the number of experimental repetitions to take for each experimental unit, *** default is three repetitions ***',
                        default=3,
                        type=int,
                        metavar='Repetitions',
                        required=False)
    parser.add_argument('-rp','--repeat_measurement',
                        help='Optional parameter, which is different from specifying measurements because it allows to mutate the dataset based on repeated measures, this option is especially useful for measurements across time, otherwise the repetitions should suffice to mutate the dataset if repeated measurements want to be taken.',
                        type=str,
                        nargs='*',
                        metavar='Repeat Measurement',
                        required=False)
    parser.add_argument('-m','--measurements',
                        help='Required parameter specifying the measuring criteria for the experimental units.',
                        type=str,
                        nargs='*',
                        metavar='Measurement',
                        required=True)
    args = parser.parse_args()

    csv_write(args.filename, args.block, args.treatments, args.repeat_measurement,args.repetitions, args.measurements) #ADD measurements

    
if __name__ == "__main__":
    main()
# I think that I can get this program independently but I also want to find a way to standardize certain experiments that we typically do in the lab.
# Such as growth curve or HPLC experiments, since they can be streamlined in the amount of information.
