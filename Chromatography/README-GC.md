# Chromatography File Parser

## i) Setup (Start Here!!!)

The chromatography file parser is a command line tool that invokes a python script. This means you can run the script from your Terminal (mac), or terminal-emulator in Windows (Putty, powershell, etc.), which we will refer to as "your terminal." In order to run this, you must have [**python3**](https://www.python.org/downloads/) installed .


With your terminal opened, check to make sure you have python3 installed by running these commands:
```
python --version
```
or
```
python3 --version
```

One of those commands should show "Python 3.9" or newer if you have python3 installed correctly. For the remaining steps, use the command (`python` or `python3`) that worked.

You will now need to install a python package called _scipy_. To do this, simply navigate to your terminal and install it via pip:  

```
python -m pip install --user scipy
```

## ii) Run the command (CLI - most people do this)

To run the script using the Command Line Interface, you just need to tell the program where your GC file is. The GC file should be the .txt output report that comes off the GC machine.  
`$ python gcParser.py -f example-gc.txt --Save`  
Use the --save flag to write output to a folder. By default, running this script will produce a new folder with the name:  
`output-DD-Mmm-YYYY`, for example: `output-06-May-2024`
Above, replace 'example-gc.txt' with the name of your own GC file. You can run the script on this example file to ensure everything works well. There will be a bunch of information coming across your terminal, which is for debugging right now.

## Output Files

1. FinalTable-DD-Mmm-YYYY.csv (ex, FinalTable-06-May-2024.csv)  
   Above, this file provides a tabular format of all unknown samples from the GC file. 'Unknown' files are determined by looking at the Level attribute, which equals 0 for all unknowns (standards are 1-N, typically 1-5). See the below table for information on the first 6 columns. For the rest of the columns, they are taken directly from the GC text file and have the same meaning. Note: Make sure you are looking at the **appropriate detector**, as if there are multiple detectors used in a run then there will potentially be multiple rows per sample.

| Sample_Name         | Name                   | Area           | Isocupric_Value         | Normalized_Concentration | Concentration                                    |
| ------------------- | ---------------------- | -------------- | ----------------------- | ------------------------ | ------------------------------------------------ |
| Name of your sample | Acid that was detected | Raw area (int) | Internal standard value | Area / Isocupric_Value   | Normalized put into standard regression equation |

2. ModelTable-DD-Mmm-YYYY.csv  
   This provides the model parameters for each standard found in the run. For GC, this should include Acetate, Butyrate, Isobutyrate, Isocupric, Isovalerate, and Propionate. If there were not at least 2 values for an internal standard, then the regression was skipped and you will see NAs for each value. This model is used to provide the values for the Normalized_Concentration for unknowns.

3. StandardsMeanDF-DD-Mmm-YYYY.csv
   A table of all the standard acid values (mean, std, count) with the detected level and associated Concentration. Note that the Concentration is hard-coded, meaning this is prior information that the script knows and uses as the X-axis to create the regression model.

4. StdPeakTable-DD-Mmm-YYYY.csv
   Similar to the StandardMeanDF table, this shows all the individual replicate data for each standard.

# Roadmap

### Features to Implement

- Allow HPLC files to use this script. Currently this is a little buggy and not completely supported.
- Read in metadata associated with each sample and automatically perform a join to create a table with all relevant information in it, which should be easy to immediately plot. For example, adding the metadata would look something like:  
  `$ python gcParser --file myfile.txt --metadata mymetadata.txt --Save`  
  and then an output file could be: FinalTableWithMetadata.csv.
- Perform flagging for values within the GC data. For example, if internal standard has too high of a standard deviation, let the user know; if replicate data is variable, let the user know; if concentrations are insanely high, let the user know; etc.
- Add logging
- Cleanup terminal output
- Add to GeneralTools library
