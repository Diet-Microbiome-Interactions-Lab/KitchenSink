# Chronicle of the Neverending Code

The cybernetic model App code designed by Rubesh is composed of several functions which are used consecutively and finally mixed 
together in the Main Plot, the Master Function Tester, and the Fitting app to model bacterial growth. This README serves as your guide through the labyrith of code files. 

## Tester_model_plotting_uifigure
This file displays graphs of biomass, substrate and enzyme concentration through time for *in silico* experiments. To obtain this, code requires an excel file as input which must contain number of species and substrates, initial concentrations of biomass, substrate, and enzymes. Aditionally, time range and parameters such as growth rate, half velocity constant and yield must be provided. Once the program is run, values can be changed inside the user interface and model can be re-run to see new results. 

Inside code file, the first function called is **distinguishable_colors.m**, which allows Matlab to always pick maximally perceptually distinguishable colors when graphing results. Additionally, the sequence of colors is consistent no matter how many you request, which facilitates the users' ability to learn the color order and avoids major changes in the appearance of plots when adding o removing data sets.

Next, *uigetfile* opens a dialog box for the user to select an Excel file, which is stored in the variable file, and the selected folder is stored in the variable *selFol*. Then the contents of the Excel file are read and stored into a Matlab table (variable named *table*).

Code lines 17 to 44 generate a user interface (UI) figure (fig) with a grid layout (g) consisting of 4 rows and 3 columns. 
The UI figure is titled "Cybernetic multi-species model Tester" and maximized on the screen.

Then, *table* values are assigned to variable *Current_model* in workspace *base*. This is used to export data from a function to the 
base workspace. After that, function **solve_from_modelset** is used, where *table* is the input and *t, Ci, Sj, eij, Eij, n_species, n_substrates* are the outputs.

Code lines 49 to 79 plot biomass, substrate, intracellular and extracelular enzyme concentrations through time. 


## Solve_from_modelset
This function solves the ordinary differential equations that govern the model. 

First, it states de preferred parameter names and order: 
  * **mu1:** specific growth rate
  * **K:**  half velocity constant 
  * **m:** death rate
  * **Y:** substrate yield
  * **k_c:** cleavage rate constant
  * **K_c:** half velocity constant for cleavage
  * **f:** competititon index (I came up with this name)
  * **k_e:** inductive enzyme production rate
  * **alpha1:** enzyme production rate
  * **beta1:** enzyme degradation rate
  * **k_t:** enzyme transport rate constant
  * **e_initial:** initial enzyme concentration

*eval* function in line 5 contructs and evaluates a string to extract parameter values from the input *table* based on their names. Following *eval* functions (lines 6 to 10) construct variables *Par, Par_size, Par_sp_size and Par_sub_size*, from extracted parameter values. Next set of eval functions (lines 12 to 18) extract variables *n_species, n_substrates, tmax, Ci_initial, Sj_initial, Tjji*. 

* *Par stands for parameter, sp for species, sub for substrate, n for number, Ci for biomass concentration of species i, 
Sj for concentration of substrate j, Tjji for the transition probability of extracellular hydrolysis of substrate j1 to j2 by species i.*

After that, **Par_list** function is called to extract variables from the concatenated array *Par* (line 6), and resizes them according to *Par_sp_size* and *Par_sub_size*. Then an array called *x_in* is created to save the initial values of biomass, substrate and enzyme concentrations. 

Subsequently, *opts* is used to define the options for the MATLAB ODE solver, specifying the solution to the ODE should remain non-negative, and the tolerance level is set to 1e-13. Relative tolerance is a measure of the acceptable error in the solution relative to the size of the solution itself, which means that the solver aims to achieve a relative error of approximately 1e-13.

Afterwards, *ode23* (for non-stiff ODEs) is used to solve the model. The function **model_cyb** takes t (time), y (current values of the variables), and parameters (*Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates, Tjji*) as inputs. This function returns the derivatives of the variables with respect to time.

Finally, lines 32 to 35 extract solutions from solver output *y* into each variable. 


## model_cyb
This function is crucial as it contains all of the differential equations which compose the cybernetic model. 

All initial conditions are set from array *x* previously defined (lines 5 to 10). Model parameters are extracted from *Par* using function **Par_list**, and then resized appropiately using **Par_model_resize** function. 

From there on, for loops are used to calculate *emax(i,j), rho(i,j)*, and cybernetic variables *u(i,j), v(i,j)* for each species for each substrate. Then, ODE equations to calculate biomass, substrate, intracellular and extracellular enzyme concentration are used inside for loops for the same purpose. 

The output vector, *dx*, contains all data regarding biomass, substrate, intracellular and extracellular enzyme concentration through time.


## Par_list
This function aims to parse the paramenters stored in vector *Par* into each variable of the model. For each varibale, it checks its length and shapes it accordingly based on certain conditions:

* If length is equal to 1, it remains unchanged. This would be the case of working only with one species growing on one substrate.
* If the length matches the expected number of species times the number of substrates, it is reshaped into a matrix of size [n_species, n_substrates]. This is the case of multiple species on multiple substrates. 
* If the size of species matches the expected number of species, it is reshaped into a column vector of size [n_species, 1]. This is the case of multiple species on one unique substrate. 
* If the size of substrates matches the expected number of substrates, it is reshaped into a row vector of size [1, n_substrates]. This is the case of a single specie in multiple substrates.
* If none of the conditions are met, it sets the error flag err to true.

*reshape* function does not change underlying data, it just rearranges the elements to fit into a specific shape, but numbers are constant. 


## Par_model_resize
While **Par_list** extracts parameters from a vector into individual variables, **Par_model_resize** checks if those matrices sizes make sense considering the number of species and substrates that where previously defined. Each variable or parameter is checked based on the following: 

* If the length matches the expected number of species times the number of substrates, it means it's already in the correct shape and no reshaping is needed.
* If the length  is 1, it implies that it's a single value that needs to be replicated to match the size of the species and substrates. So, it uses repmat to replicate this single value into an array of size [n_species, n_substrates].
* If the size of species matches the expected number of species, it replicates the single value along the rows (species) to create an array of size [n_species, n_substrates].
* If the size of substrates matches the expected number of substrates, it replicates the single value along the columns (substrates) to create an array of size [n_species, n_substrates].

The reason to reshape input is to catch possible user mistakes when providing data in the input file, without breaking the code. *repmat* function replicates and tiles an array to create a larger one with repeated copies of the original array, yet again original data is not changed, just replicated. Additionally, as MATLAB works everything as matrixes it is extremely important that sizes match so operations can be run smoothly and logically. 


## Plot_main
This script involves a combination of data processing, model solving and visualization, resulting in plots of both experimental data and cybernetic model fitting. 

To begin, the code requires user input file which must include experimental data of biomass and substrate concentration through time, as well as, the transition probability matrix. Function **load_from_table** asigns values for the following variables according to the input: *Ci_time, Ci_data, Sj_time, Sj_data, Species, Substrates, Enzymes, n_species, n_substrates, Tjji*. 

??Solutions_sorted

eval functions (lines 81 to 84) construct variables *Par, Par_size, Par_sp_size and Par_sub_size*, from extracted parameter values.Model parameters are extracted from *Par* using function **Par_list**, and then an array called *x_in* is created to save the initial values of biomass, substrate and enzyme concentrations. 

Next, function **solve_cyb** is used to solve the differential equation systems, and as solution it returns the derivatives of the variables with respect to time in variable *y*. Finally, lines 91 to 94 extract solutions from solver output *y* into each variable. 

Finally, the code has both the experimental data, and the model fitting values, which are plotted together. 


## solve_cyb
This function uses the same ODE solver and specifications as **Solve_from_modelset** function, to solve both the cybernetic (**model_cyb**) and kinetic (**model_kin**) model proposals. 


## model_kin
This function is identical to **model_cyb**, it just lacks the cybernetic control variables *u(i,j), v(i,j)*. 

All initial conditions are set from array *x* previously defined. Model parameters are extracted from *Par* using function **Par_list**, and then resized appropiately using **Par_model_resize** function. 

From there on, for loops are used to calculate *emax(i,j), rho(i,j)*, but cybernetic variables are set equal to *1*, so that these don't affect results. Then, ODE equations to calculate biomass, substrate, intracellular and extracellular enzyme concentration.

The output vector, *dx*, contains all data regarding biomass, substrate, intracellular and extracellular enzyme concentration through time.
