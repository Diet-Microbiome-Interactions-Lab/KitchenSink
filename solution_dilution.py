import fire
def solution_dilution(initial_concentration, final_concentration, final_volume):
    initial_concentration = float(initial_concentration)
    final_concentration = float(final_concentration)
    final_volume = float(final_volume)
    volume_to_add = final_concentration * final_volume / initial_concentration
    difference = final_volume - volume_to_add
    return(
        "Solvent Volume: " + str(difference) +
        "\nVolume to add: " + str(volume_to_add))

if __name__ == '__main__':
    fire.Fire(solution_dilution)

    #do one for inital concentration