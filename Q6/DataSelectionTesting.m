% The following script finds all the 'yes' instances of the failed
% attributes, (FAIL_LPLZ,FAIL_LORT, etc.) and then checks what the
% corresponding class is. Basically the idea is to see if a FAILED
% attribute results in a high risk customer. The data indicates that those
% that do not provide this address are predominatety low risk (which
% doesn't make much sense or isn't of much use.
%% Gather the index values
classTest = zeros(sizeOfData,6);
indexValues = zeros(sizeOfData,6);
count = ones(1,6);
for i = 1:sizeOfData
    if (strcmp(s.FAIL_LORT(i,:),'yes'))
        indexValues(count(1),1) = i;
        count(1) = count(1) + 1;
    end
    if (strcmp(s.FAIL_LPLZ(i,:),'yes'))
        indexValues(count(2),2) = i;
        count(2) = count(2) + 1;
    end
    if (strcmp(s.FAIL_LPLZORTMATCH(i,:),'yes'))
        indexValues(count(3),3) = i;
        count(3) = count(3) + 1;
    end
    if (strcmp(s.FAIL_RORT(i,:),'yes'))
        indexValues(count(4),4) = i;
        count(4) = count(4) + 1;
    end
    if (strcmp(s.FAIL_RPLZ(i,:),'yes'))
        indexValues(count(5),5) = i;
        count(5) = count(5) + 1;
    end
    if (strcmp(s.FAIL_RPLZORTMATCH(i,:),'yes'))
        indexValues(count(6),6) = i;
        count(6) = count(6) + 1;
    end
    
end

%% Second Part
[~,sizeOfCount] = size(count);
percCorrelation = zeros(1,6);
for i = 1:sizeOfCount
    for j = 1:count(i)-1
        if (strcmp(s.CLASS(indexValues(j,i),:),'no '))
            percCorrelation(i) = percCorrelation(i) + 1;
            
        end
    end
end
percCorrelation = (percCorrelation./count)*100;

    
    