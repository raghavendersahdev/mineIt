% Load the file
sizeOfData = 30000;
filename = 'risk-train.txt';

s = tdfread(filename,'\t');

disp('Updating DATE_LORDERValues')
%% Update DATE_LORDER
for i = 1:sizeOfData
    if (strcmp(s.DATE_LORDER(i),'?') == 1) 
        s.DATE_LORDER(i,:) = 'no        ';
    else
        s.DATE_LORDER(i,:) = 'yes       ';
    end     
end

%% Update all the ordered items (ANUMBER_01...10) that have '?' to '0'
disp ('Updating all ordered items (ANUMBER_01..10) that are missing to 0')
number_of_items = zeros(sizeOfData,1);
for i = 1:sizeOfData
   if (strcmp(s.ANUMMER_01(i),'?') == 1)
       s.ANUMMER_01(i) = '0';
   else
       number_of_items(i) = 1;
   end
     if (strcmp(s.ANUMMER_02(i),'?') == 1)
       s.ANUMMER_02(i) = '0';
     else
       number_of_items(i) = 2;
     end
     if (strcmp(s.ANUMMER_03(i),'?') == 1)
       s.ANUMMER_03(i) = '0';
     else
       number_of_items(i) = 3;
     end
     if (strcmp(s.ANUMMER_04(i),'?') == 1)
       s.ANUMMER_04(i) = '0';
     else
       number_of_items(i) = 4;
     end
     if (strcmp(s.ANUMMER_05(i),'?') == 1)
       s.ANUMMER_05(i) = '0';
     else
       number_of_items(i) = 5;
     end
     if (strcmp(s.ANUMMER_06(i),'?') == 1)
       s.ANUMMER_06(i) = '0';
     else
       number_of_items(i) = 6;
     end
     if (strcmp(s.ANUMMER_07(i),'?') == 1)
       s.ANUMMER_07(i) = '0';
     else
       number_of_items(i) = 7;
     end
     if (strcmp(s.ANUMMER_08(i),'?') == 1)
       s.ANUMMER_08(i) = '0';
     else
       number_of_items(i) = 8;
     end
     if (strcmp(s.ANUMMER_09(i),'?') == 1)
       s.ANUMMER_09(i) = '0';
     else
       number_of_items(i) = 9;
     end
     if (strcmp(s.ANUMMER_10(i),'?') == 1)
       s.ANUMMER_10(i) = '0';
     else
       number_of_items(i) = 10;
     end
end

%% Add the Age
disp('Get the birthdate to convert to an age')
current_date = '10/30/2015';
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

%% Binning the Data 
% disp('Updating the Ages')
% for i = 1:sizeOfData
%     if (s.AGE(i) <20)
%         s.AGE(i) = 0;
%     elseif (s.AGE(i) < 30)
%        s.AGE(i) = 1;
%     elseif (s.AGE(i) < 40)
%        s.AGE(i) = 2;
%     elseif (s.AGE(i) < 50)
%        s.AGE(i) = 3;
%     elseif (s.AGE(i) < 60)
%        s.AGE(i) = 4;
%     elseif (s.AGE(i) < 70)
%        s.AGE(i) = 5;
%     elseif (s.AGE(i) < 80)
%        s.AGE(i) = 6;
%     elseif (s.AGE(i) < 90)
%        s.AGE(i) = 7;    
%     end
% end

%% Add in a new attribute: NUM_ITEMS_ORDERED
disp('Add in the new attribute: NUM_ITEMS_ORDERED')
s.NUM_ITEMS_ORDERED = number_of_items;


%% Save back into the file
disp('Saving')
filenameOutput = 'risk-train-DATE_LORDER_Binary.txt';
tdfwrite(filenameOutput,s)