% Load the file
sizeOfData = 30000;
filename1 = 'risk-train.txt';
filename2 = 'risk-test.txt';

disp('Loading file...');
test_set = tdfread(filename1,'\t');
disp('Loading file...');
train_set = tdfread(filename2,'\t');
disp ('Finished Loading Files');

%% Dummy CLASS
class_var = test_set.CLASS;
for i = 1:length(class_var)
    class_var(i,:) = '?  ';
end


names = fieldnames(test_set);
temp = struct;
temp = setfield(temp,names{1},getfield(train_set,names{1}));
temp = setfield(temp,names{2},class_var);

for i = 3:length(names)
    temp = setfield(temp,names{i},getfield(train_set,names{i}));
end 