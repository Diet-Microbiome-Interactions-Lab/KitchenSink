

# Concentration 1 Formula
def calculate_c1(v1,c2,v2):
    return(float(c2)*float(v2)/float(v1))

# Volume 1 Formulas
def calculate_v1(c1,c2,v2):
    return(float(c2)*float(v2)/float(c1))

def calculate_difference_v2_v1(v1,v2):
    return(float(v2)-float(v1))

# Concentration 1 Formula
def calculate_c2(c1,v1,v2):
    return(float(c1)*float(v1)/float(v2))

# Volume 2 Formula
def calculate_v2(c1,v1,c2):
    return(float(c1)*float(v1)/float(c2))