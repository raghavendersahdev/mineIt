% Load the file
sizeOfData = 30000;
filename = 'risk-train.txt';
%filename = 'risk-train-wekamodified_new_stuff.csv';
current_date = '10/30/2015';
disp('Loading file...');
%s = tdfread(filename,'\t');
s = tdfread(filename,'\t');

%% Normalize the attribute VALUE_ORDER_PRE
disp ('Normalize VALUE_ORDER_PRE and VALUE_ORDER')
valMin = min(s.VALUE_ORDER);
valMax = max(s.VALUE_ORDER);
s.VALUE_ORDER = ((s.VALUE_ORDER-valMin)/(valMax-valMin))*40;
valMin = min(s.VALUE_ORDER_PRE);
valMax = max(s.VALUE_ORDER_PRE);
s.VALUE_ORDER_PRE = ((s.VALUE_ORDER_PRE-valMin)/(valMax-valMin))*50;

%% Create IS_LORDER Attribute
disp ('Creating IS_LORDER to see if a previous order has been placed.')
s.IS_LORDER = s.B_TELEFON;
for i = 1:sizeOfData
    if (strcmp(s.DATE_LORDER(i),'?') == 1) 
        s.IS_LORDER(i,:) = 'no ';
    else
        s.IS_LORDER(i,:) = 'yes';
    end     
end


%% Update DATE_LORDER to Numeric
disp('Updating DATE_LORDER Values to Numeric')
temp_date = zeros(sizeOfData,1);
for i = 1:sizeOfData
    if (strcmp(s.DATE_LORDER(i),'?') == 1) 
        s.DATE_LORDER(i,:) = '?         ';
    else
        temp = s.DATE_LORDER(i,:);
        temp = daysact(temp,current_date);
        temp = floor(temp/365);
        s.DATE_LORDER(i,:) = [num2str(temp),'        '];
    end
end



%% Update all the ordered items (ANUMBER_01...10) that have '?' to '0'
disp ('Updating all ordered items (ANUMBER_01..10) that are missing to 0')
number_of_items = zeros(sizeOfData,1);
t1 = s.ANUMMER_01;
t2 = s.ANUMMER_02;
t3 = s.ANUMMER_03;
t4 = s.ANUMMER_04;
t5 = s.ANUMMER_05;
t6 = s.ANUMMER_06;
t7 = s.ANUMMER_07;
t8 = s.ANUMMER_08;
t9 = s.ANUMMER_09;
s.ANUMMER_01 = s.B_BIRTHDATE;
s.ANUMMER_02 = s.B_BIRTHDATE;
s.ANUMMER_03 = s.B_BIRTHDATE;
s.ANUMMER_04 = s.B_BIRTHDATE;
s.ANUMMER_05 = s.B_BIRTHDATE;
s.ANUMMER_06 = s.B_BIRTHDATE;
s.ANUMMER_07 = s.B_BIRTHDATE;
s.ANUMMER_08 = s.B_BIRTHDATE;
s.ANUMMER_09 = s.B_BIRTHDATE;
for i = 1:sizeOfData
   if (strcmp(t1(i),'?') == 1)
       s.ANUMMER_01(i) = '?         ';
   else
       s.ANUMMER_01(i,:) = [num2str(t1(i,:)),'    '];
   end
     if (strcmp(t2(i),'?') == 1)
       s.ANUMMER_02(i,:) = '?         ';
        else
       s.ANUMMER_02(i,:) = [num2str(t2(i,:)),'    '];
   end
     if (strcmp(t3(i),'?') == 1)
       s.ANUMMER_03(i,:) = '?         ';
        else
       s.ANUMMER_03(i,:) = [num2str(t3(i,:)),'    '];
   end
     if (strcmp(t4(i),'?') == 1)
       s.ANUMMER_04(i,:) = '?         ';
        else
       s.ANUMMER_04(i,:) = [num2str(t4(i,:)),'    '];
   end
     if (strcmp(t5(i),'?') == 1)
       s.ANUMMER_05(i,:) = '?         ';
        else
       s.ANUMMER_05(i,:) = [num2str(t5(i,:)),'    '];
   end
     if (strcmp(t6(i),'?') == 1)
       s.ANUMMER_06(i,:) = '?         ';
        else
       s.ANUMMER_06(i,:) = [num2str(t6(i,:)),'    '];
   end
     if (strcmp(t7(i),'?') == 1)
       s.ANUMMER_07(i,:) = '?         ';
        else
       s.ANUMMER_07(i,:) = [num2str(t7(i,:)),'    '];
   end
     if (strcmp(t8(i),'?') == 1)
       s.ANUMMER_08(i,:) = '?         ';
        else
       s.ANUMMER_08(i,:) = [num2str(t8(i,:)),'    '];
   end
     if (strcmp(t9(i),'?') == 1)
       s.ANUMMER_09(i,:) = '?         ';
        else
       s.ANUMMER_09(i,:) = [num2str(t9(i,:)),'    '];
   end
end

%% Add the Age
disp('Get the birthdate to convert to an age')
temp_age = zeros(sizeOfData,1);
for i=1:sizeOfData
    if (strcmp(s.B_BIRTHDATE(i),'?') == 1) 
        temp_age(i) = 0;
    else
        temp = s.B_BIRTHDATE(i,:);
        temp = daysact(temp,current_date);
        temp_age(i) = (floor(temp/365));
    end
    
end
%% Bin the ages
disp('Bin the AGES')
bins = 10;
minAge = 28;
maxAge = max(temp_age);
bin_interval = ceil((maxAge-minAge)/bins);
bin_range = minAge:bin_interval:maxAge;
if (max(bin_range)<maxAge)
    bin_range = [bin_range maxAge+2];
end

for i = 1:30000
    if (~temp_age(i) == 0)
        for k = 1:length(bin_range)-1
            if (temp_age(i) >=bin_range(k) && temp_age(i) < bin_range(k+1))
               s.B_BIRTHDATE(i,:) = ['[',num2str(bin_range(k)),'-',num2str(bin_range(k+1)),')   '];
            end
        end        
    end    
end




%% Update MAN_HOECHST to '0' if not set
disp ('Update Current Stage of Reminder')
temp1 = s.MAHN_HOECHST;
temp2 = s.MAHN_AKT;
s.MAHN_HOECHST = s.B_BIRTHDATE;
s.MAHN_AKT = s.B_BIRTHDATE;
for i = 1:sizeOfData
    if (strcmp(temp1(i),'?'))
        s.MAHN_HOECHST(i,:) = '?         ';
    else
        s.MAHN_HOECHST(i,:) = [temp1(i,:),'         '];
    end
    if (strcmp(temp2(i),'?'))
       s.MAHN_AKT(i,:) = '?         ';
    else
        s.MAHN_AKT(i,:) = [temp2(i,:),'         '];
    end
end

%% Change TIME_ORDER to Numerical Values
s.TIME_ORDER_NUMERIC = zeros(sizeOfData,1);
disp('Change TIME_ORDER to NUMERIC values')
for i = 1:sizeOfData
    k = s.TIME_ORDER(i,:);
    if (isempty(strfind(k,':')))
        k = '0:0';       
    end
    mm = str2num(k(strfind(k,':')-1));
    ss = str2num(k(strfind(k,':')+1:end));
    time_seconds = mm*60+ss;
    s.TIME_ORDER_NUMERIC(i) = time_seconds;
    
end


%% Update LAST_NAME
disp('Update LAST_NAME which has no entries')
for i = 1:sizeOfData
    if (~isempty(strfind(s.Z_LAST_NAME(i,:),'?')))
        s.Z_LAST_NAME(i,:) = 'no ';
    end
end

%% Remove redundant Data
disp('Remove Redudant Data');
s = rmfield(s,'TIME_ORDER');
s = rmfield(s,'ANUMMER_10'); % This has no information
s = rmfield (s,'Z_CARD_VALID');

%% Update Field References
disp ('Update Data set references')
s.TIME_ORDER = s.TIME_ORDER_NUMERIC;
s = rmfield(s,'TIME_ORDER_NUMERIC');


%% Save back into the file
disp('Saving')
filenameOutput = 'risk-train-modified_10.txt';
tdfwrite(filenameOutput,s)
disp ('Successfully Finished!')