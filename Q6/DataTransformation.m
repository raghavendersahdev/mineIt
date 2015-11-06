% Load the file
sizeOfData = 30000;
filename = 'risk-train.txt';
current_date = '10/30/2015';
disp('Loading file...');
s = tdfread(filename,'\t');

%% Normalize the attribute VALUE_ORDER_PRE
disp ('Normalize VALUE_ORDER_PRE and VALUE_ORDER')
valMin = min(s.VALUE_ORDER);
valMax = max(s.VALUE_ORDER);
s.VALUE_ORDER = (s.VALUE_ORDER-valMin)/(valMax-valMin);
valMin = min(s.VALUE_ORDER_PRE);
valMax = max(s.VALUE_ORDER_PRE);
s.VALUE_ORDER_PRE = (s.VALUE_ORDER_PRE-valMin)/(valMax-valMin);

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
infinite_date = '10/30/1700';
for i = 1:sizeOfData
    if (strcmp(s.DATE_LORDER(i),'?') == 1) 
        s.DATE_LORDER(i,:) = infinite_date;
    end
    temp = s.DATE_LORDER(i,:);
    temp_date(i) = daysact(temp,current_date);
end
temp_date = floor(temp_date/365);
s.DATE_LORDER = temp_date;


%% Update all the ordered items (ANUMBER_01...10) that have '?' to '0'
disp ('Updating all ordered items (ANUMBER_01..10) that are missing to 0')
number_of_items = zeros(sizeOfData,1);
for i = 1:sizeOfData
   if (strcmp(s.ANUMMER_01(i),'?') == 1)
       s.ANUMMER_01(i) = '?';
   else
       number_of_items(i) = 1;
   end
     if (strcmp(s.ANUMMER_02(i),'?') == 1)
       s.ANUMMER_02(i) = '?';
     else
       number_of_items(i) = 2;
     end
     if (strcmp(s.ANUMMER_03(i),'?') == 1)
       s.ANUMMER_03(i) = '?';
     else
       number_of_items(i) = 3;
     end
     if (strcmp(s.ANUMMER_04(i),'?') == 1)
       s.ANUMMER_04(i) = '?';
     else
       number_of_items(i) = 4;
     end
     if (strcmp(s.ANUMMER_05(i),'?') == 1)
       s.ANUMMER_05(i) = '?';
     else
       number_of_items(i) = 5;
     end
     if (strcmp(s.ANUMMER_06(i),'?') == 1)
       s.ANUMMER_06(i) = '?';
     else
       number_of_items(i) = 6;
     end
     if (strcmp(s.ANUMMER_07(i),'?') == 1)
       s.ANUMMER_07(i) = '?';
     else
       number_of_items(i) = 7;
     end
     if (strcmp(s.ANUMMER_08(i),'?') == 1)
       s.ANUMMER_08(i) = '?';
     else
       number_of_items(i) = 8;
     end
     if (strcmp(s.ANUMMER_09(i),'?') == 1)
       s.ANUMMER_09(i) = '?';
     else
       number_of_items(i) = 9;
     end
     if (strcmp(s.ANUMMER_10(i),'?') == 1)
       s.ANUMMER_10(i) = '?';
     else
       number_of_items(i) = 10;
     end
end

%% Add the Age
disp('Get the birthdate to convert to an age')
temp_age = zeros(sizeOfData,1);
for i=1:sizeOfData
    if (strcmp(s.B_BIRTHDATE(i),'?') == 1) 
        s.B_BIRTHDATE(i,:) = current_date;
    end
    temp = s.B_BIRTHDATE(i,:);
    temp_age(i) = daysact(temp,current_date);
    
end
temp_age = floor(temp_age/365);
s.AGE = temp_age;
%% Update MAN_HOECHST to '0' if not set
disp ('Update Current Stage of Reminder')
for i = 1:sizeOfData
    if (strcmp(s.MAHN_HOECHST,'?'))
        s.MAHN_HOECHST = '?';
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
s = rmfield(s,'B_BIRTHDATE');
s.B_BIRTHDATE = s.AGE;
s = rmfield(s,'AGE');
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