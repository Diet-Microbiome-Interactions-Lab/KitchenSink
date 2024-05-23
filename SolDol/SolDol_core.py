from SolDol_calculations import *

class SolDol:
    def __init__(self, c1, c2, v2, st, sv):
        self.c1 = c1
        self.c2 = c2
        self.v2 = v2
        self.st = st
        self.sv = sv
        self.v1 = self.calculate_v1()
        self.display_result()

    def calculate_v1(self):
        # Formula: C1 * V1 = C2 * V2 => V1 = (C2 * V2) / C1
        if self.c1 == 0:
            raise ValueError("Initial concentration (c1) cannot be zero.")
        return (self.c2 * self.v2) / self.c1

    def display_result(self):
        print("Initial concentration: " + str(self.c1) + f" {self.st}/{self.sv}\n" + 
              "Final concentration and volume: " + str(self.c2) + f" {self.st}/" + str(self.v2) + f" {self.sv}\n\n"
              "Solute: " + str(self.v1) + f" {self.sv}\n"
              "Solvent: " + str(self.v2) + f" {self.sv}")
