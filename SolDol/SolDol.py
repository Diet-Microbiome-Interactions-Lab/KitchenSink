import argparse
from SolDol_core import SolDol

def main():
    parser = argparse.ArgumentParser(
                    prog='C1*V1 = C2*V2 calculator!',
                    description='Why do your work when you can automate it?\n'
                    )
    # ~~~ Value Arguments ~~~ #
    parser.add_argument('-c1', "--initial_concentration",
                        help= 'Initial concentration\n',
                        type=float,
                        required=True  
    )
    parser.add_argument('-c2', "--final_concentration",
                        help= 'Final concentration\n',
                        type=float,
                        required=True  
    )
    parser.add_argument('-v2', "--final_volume",
                        help= 'Final volume\n',
                        type=float,
                        required=True
    )
    # ~~~ Units Arguments ~~~ #
    parser.add_argument('-st', "--solute_units",
                        help= 'Define the working units for solute (concentration)\n',
                        type=str,
                        required=True
    )
    parser.add_argument('-sv', "--solvent_units",
                        help= 'Define the working units for solvent (volume)\n',
                        type=str,
                        required=True
    )

    args = parser.parse_args()
   
    SolDol(c1=args.initial_concentration, c2=args.final_concentration, v2=args.final_volume, st=args.solute_units, sv=args.solvent_units)

if __name__ == "__main__":
    main()