# Chronicle of the Neverending Code

The cybernetic model App code designed by Rubesh is composed of several functions which are used consecutively and finally mixed 
together in the Master Function Tester as well as the Fitting app to model bacterial growth. This README serves as your guide through the labyrith of code files. 

## Tester_model_plotting_uifigure
This file displays graphs of biomass, substrate and enzyme concentration through time for *in silico* experiments. To obtain this, code requires an excel file as input, which must contain number of species and substrates, initial concentrations of biomass for each species and substrate for each present, as well as an initial enzyme concentration. Aditionally, time range and parameters such as growth rate, half velocity constant and yield must be provided. Once the program is run, values can be changed inside the user interface and model can be re-run to see new results. 

Inside code file, the first function called is **distinguishable_colors.m**, which allows Matlab to always pick maximally perceptually distinguishable colors 
when graphing results. Additionally, the sequence of colors is consistent no matter how many you request, which facilitates the users' 
ability to learn the color order and avoids major changes in the appearance of plots when adding o removing data sets.

Next, uigetfile('*.xlsx')opens a dialog box for the user to select an Excel file, which is stored in the variable file, and the selected
folder is stored in the variable selFol. Then the contents of the Excel file are read and stored into a Matlab table (variable named 'table').

Code lines 17 to 44 generate a user interface (UI) figure (fig) with a grid layout (g) consisting of 4 rows and 3 columns. 
The UI figure is titled "Cybernetic multi-species model Tester" and maximized on the screen.

Then, 'table' values are assigned to variable 'Current_model' in workspace 'base'. This is used to export data from a function to the 
base workspace. After that, function **solve_from_modelset** is used, where 'table' is the input and t,Ci,Sj,eij,Eij,n_species,n_substrates are the outputs.

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

eval function in line 5 contructs and evaluates a string to extract parameter values from the input 'table' based on their names. Following eval functions (lines 6 to 10) construct variables Par, Par_size, Par_sp_size and Par_sub_size, from extracted parameter values. Next set of eval functions (lines 12 to 18) extract variables n_species, n_substrates, tmax, Ci_initial, Sj_initial, Tjji. 

* *Par stands for parameter, sp for species, sub for substrate, n for number, Ci for biomass concentration of species i, 
Sj for concentration of substrate j*

After that, **Par_list** function is called to extract variables from the concatenated array Par (line 6), and resizes them according to Par_sp_size and Par_sub_size. Then an array called x_in is created to save the initial values of biomass, substrate and enzyme concentrations. 

Subsequently, opts is used to define the options for the MATLAB ODE solver, specifying the solution to the ODE should remain non-negative, and the tolerance level is set to 1e-13. Relative tolerance is a measure of the acceptable error in the solution relative to the size of the solution itself, which means that the solver aims to achieve a relative error of approximately 1e-13.

Afterwards, ode23 (for non-stiff ODEs) is used to solve the model. The function **model_cyb** takes t (time), y (current values of the variables), and parameters (Par, Par_size, Par_sp_size, Par_sub_size, n_species, n_substrates, Tjji) as inputs. This function returns the derivatives of the variables with respect to time.

Finally, lines 32 to 35 extract solutions from solver output 'y' into each variable. 

## model_cyb
This function is crucial as it contains all of the differential equations which compose the cybernetic model. 

All initial conditions are set from array x previously defined (lines 5 to 10). Model parameters are extracted form Par using function **Par_list**, and then resized appropiately using **Par_model_resize** function. 

From there on, for loops are used to calculate emax(i,j), rho(i,j), and cybernetic variables u(i,j), v(i,j) for each species for each substrate. Then, ODE equations to calculate biomass, substrate, intracellular and extracellular enzyme concentration are used inside for loops for the same purpose. 

The output vector, dx, contains all data regarding biomass, substrate, intracellular and extracellular enzyme concentration through time.


## Par_list


## Par_model_resize



