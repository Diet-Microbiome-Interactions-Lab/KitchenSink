import argparse
from SolDol_core import SolDol

def main():
    parser = argparse.ArgumentParser(
                    prog='C1*V1 = C2*V2 calculator!',
                    description='Why do your work when you can automate it?'
                    )
    # ~~~ Arguments ~~~ #
    parser.add_argument('-c1', "--initial_concentration",
                        help= 'Initial concentration',
                        type=str,
                        required=False  
    )
    parser.add_argument('-v1', "--initial_volume",
                        help= 'Initial volume',
                        type=str,
                        required=False  
    )
    parser.add_argument('-c2', "--final_concentration",
                        help= 'Final concentration',
                        type=str,
                        required=False  
    )
    parser.add_argument('-v2', "--final_concentration",
                        help= 'Final concentration',
                        type=str,
                        required=False
    )
    parser.add_argument('-sv', "--solvent_units",
                        help= 'Define the working units for solvent (volume)',
                        type=str,
                        required=True
    )
    parser.add_argument('-st', "--solute_units",
                        help= 'Define the working units for solute (concentration)',
                        type=str,
                        required=True
    )
    args = parser.parse_args()
    SolDol(args)

    if __name__ == "__main__":
        main()