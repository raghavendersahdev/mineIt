function indic = normAttribute(arr,a,k)
    % If k == 1, treat it as a double else treat it as a char       
    if (k == 0) 
       arr = str2num(arr);
    end
    z = find(a == arr);
    indic = '';
    if (z <10)
        indic = [num2str(z),'     '];
    elseif (z <100)
        indic = [num2str(z),'    '];
    else
        indic = [num2str(z),'   '];
    end

end