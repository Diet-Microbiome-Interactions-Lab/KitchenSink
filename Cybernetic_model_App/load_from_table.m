function [Ci_time,Ci_data,Sj_time,Sj_data,Species,Substrates,Enzymes,n_species,n_substrates,Tjji] = load_from_table(file_name)

Species_table = readtable(file_name,'Sheet','Species');
Ci_time = Species_table{:,1};
Ci_data = Species_table{:,2:end};
Species = string(Species_table.Properties.VariableNames(2:end));
n_species = length(Species);

Substrates_table = readtable(file_name,'Sheet','Substrates');
Sj_time = Substrates_table{:,1};
Sj_data = Substrates_table{:,2:end};
Substrates = string(Substrates_table.Properties.VariableNames(2:end));
n_substrates = length(Substrates);

Enzymes = strings(n_species,n_substrates);
for j = 1:n_substrates
    for i = 1:n_species
        Enzymes(i,j) = strcat(Species(i),"-",Substrates(j));
    end
end
Enzymes = Enzymes(:);

Tjji_table = readtable(file_name,'Sheet','Tjji','ReadRowNames',true);
Tjji = reshape(Tjji_table{:,:},n_substrates,n_substrates,n_species);