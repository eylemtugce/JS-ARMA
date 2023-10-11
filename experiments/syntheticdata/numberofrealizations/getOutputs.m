function m = getOutputs(s,field)
splitedFields = split(field,'.');
for i = 1:size(s,1)
    for j = 1:size(s,2)
        if(length(splitedFields) == 3)
            try
                m(i,j) = s(i,j).(splitedFields{1}).(splitedFields{2}).(splitedFields{3});
            catch
                m(i,j) = s{i,j}.(splitedFields{1}).(splitedFields{2}).(splitedFields{3});
            end
        else if (length(splitedFields) == 2)
                try
                    m{i,j} = s(i,j).(splitedFields{1}).(splitedFields{2});
                catch
                    m{i,j} = s{i,j}.(splitedFields{1}).(splitedFields{2});
                end
            else
                try
                    m{i,j} = s(i,j).(splitedFields{1});
                catch
                    m{i,j} = s{i,j}.(splitedFields{1});
                end
            end
        end
    end
end