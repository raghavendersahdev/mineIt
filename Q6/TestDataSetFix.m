% Load the file
sizeOfData = 30000;
filename1 = 'risk-train.txt';
filename2 = 'risk-test.txt';

disp(['Loading ', filename1]);
train_set = tdfread(filename1,'\t');
disp(['Loading ', filename2]);
test_set = tdfread(filename2,'\t');
disp ('Finished Loading Files');

%% Dummy CLASS
class_var = train_set.CLASS(1:length(test_set.AMOUNT_ORDER),:);
for i = 1:length(class_var)
    class_var(i,:) = '?  ';
end


names = fieldnames(train_set);
temp = struct;
temp = setfield(temp,names{1},getfield(test_set,names{1}));
temp = setfield(temp,names{2},class_var);

for i = 3:length(names)
    temp = setfield(temp,names{i},getfield(test_set,names{i}));
end 
test_set = temp;



%% Save the data
disp('Saving')
filenameOutput = 'risk-test-with-class.txt';
tdfwrite(filenameOutput,test_set)
disp ('Successfully Finished!')