function [Par, Par_size, Par_sp_size, Par_sub_size, LB, UB] = Par_from_table(file_name)

opts = detectImportOptions(file_name,'Sheet','Initial guess','ReadRowNames',true);
opts = setvartype(opts, 'Indexing', 'string');
opts = setvartype(opts, 'Values', 'string');
opts = setvartype(opts,'LB','string');
opts = setvartype(opts, 'UB','string');

Par_table = readtable(file_name,opts);

Pref_Par_order = ["mu1";"K";"m";"Y";"k_c";"K_c";"f";"k_e";"alpha1";"beta1";"k_t";"e_initial"];

eval(strjoin(strcat(Pref_Par_order,"=str2num(string(Par_table{'",Pref_Par_order,"',2}));")));
eval(strcat("Par=[", strjoin(strcat(Pref_Par_order,"(:)"),";"), "];"));
eval(strcat("Par_size=[", strjoin(strcat("(length(",Pref_Par_order,"(:)))"),";"),"];"));

eval(strcat("Par_sp_size=[", strjoin(strcat("(length(sum(",Pref_Par_order,",2)))"),";"),"];"));
eval(strcat("Par_sub_size=[", strjoin(strcat("(length(sum(",Pref_Par_order,",1)))"),";"),"];"));

% eval(strcat("LB=[", strjoin(strcat("repmat(Par_table{'",Pref_Par_order,"','LB'},[",num2str(Par_size),",1])"),";"),"];"));
% eval(strcat("UB=[", strjoin(strcat("repmat(Par_table{'",Pref_Par_order,"','UB'},[",num2str(Par_size),",1])"),";"),"];"));

LB = [];
UB = [];

for i=1:length(Pref_Par_order)
    if length(reshape(str2num(Par_table{Pref_Par_order{i},'LB'}),[],1))==1
        LB = [LB; repmat(str2num(Par_table{Pref_Par_order{i},'LB'}),Par_size(i),1)];
    elseif length(reshape(str2num(Par_table{Pref_Par_order{i},'LB'}),[],1))==Par_size(i)
        LB = [LB; reshape(str2num(Par_table{Pref_Par_order{i},'LB'}),[],1)];
    end
    if length(reshape(str2num(Par_table{Pref_Par_order{i},'UB'}),[],1))==1
        UB = [UB; repmat(str2num(Par_table{Pref_Par_order{i},'UB'}),Par_size(i),1)];
    elseif length(reshape(str2num(Par_table{Pref_Par_order{i},'UB'}),[],1))==Par_size(i)
        UB = [UB; reshape(str2num(Par_table{Pref_Par_order{i},'UB'}),[],1)];
    end
end