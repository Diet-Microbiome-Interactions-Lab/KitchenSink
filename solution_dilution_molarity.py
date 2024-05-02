from chempy import Substance
import fire


def calculate_moles(mass,molar_mass):
    moles = mass/molar_mass
    return moles

def calculate_molar_mass(chemical_formula):
    compound = Substance.from_formula(chemical_formula)
    molar_mass = compound.mass
    return molar_mass

def calculate_molarity(solute_chemical_formula, solute_mass, solvent_volume):
    # Calculate Moles
    moles = calculate_moles(solute_mass, calculate_molar_mass(solute_chemical_formula))
    # Calculate Molarity
    molarity = moles / solvent_volume
    return molarity 

def solution_dilution_molarity(solute_chemical_formula, solute_mass, solvent_volume, final_concentration, final_volume):
    volume_to_add = final_concentration * final_volume/(calculate_molarity(solute_chemical_formula, solute_mass, solvent_volume))
    difference = final_volume - volume_to_add
    return(
        "Solvent Volume: " + str(difference) +
        "\nVolume to add: " + str(volume_to_add))

print(solution_dilution_molarity("CH3COOH",1000,1,1,0.05))
#if __name__ == '__main__':
#    fire.Fire(solution_dilution_molarity)