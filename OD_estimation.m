%_____________Read the Data_________________%

%Open the file
fid=fopen('july15_order.csv');

 %this peart is to replace the string user ID with a real number
userIDStr=123456789;
userID_vector=[];
userID=0;
'''
%For text purposes
k=0;
for k=1:k+1:1000,
 tline = fgetl(fid);
end;
       userIDStr=tline(1:24);
 
 '''

for i=1:i+1:5000000,
    tline = fgetl(fid);
    if strfind(tline,userIDStr)>0
        userID_vector(i,1)=userID;
    else
         userID=userID+1;
        userID_vector(i,1)=userID;
        userIDStr=tline(1:24);
    end
	i=i+1;
end;
fclose(fid);

%read the other columns data 
data_1=dlmread('july15_order.csv',',',[0,2,4999999,5]);
%combine the data
data_full=[userID_vector(:,1) data_1(:,1:4)];

clear userID_vector;
clear data_1;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%_____________Data Process_________________%

%initialize
ODflow=zeros(33,33);
j=1;
OneUser=[];
OneUserSort=[];
origin=0;
destination=0;
OneUser(1,:)= data_full(1,2:5);

%separate userwise data
for i=2:length(data_full),
if data_full(i,1)== data_full(i-1,1)
    j=j+1; 
    OneUser(j,:)= data_full(i,2:5);
    size_1=size(OneUser);
elseif ((size_1(1))>2)
OneUserSort = sortrows(OneUser);
size_2=size(OneUserSort);


%eliminate second and third node
    l=1;
    r=[];
for k=1:((size_2(1,1))-1),
    if  OneUserSort(k,3)== 0
        r(l,:)= OneUserSort(k,2);
        l=l+1;
    else
    end
end;
o= unique(r);
clear r;
if length(o)> 1;
for k=1:((size_2(1,1))-1),
    if OneUserSort(k,3)> 0 && OneUserSort(k,4)> 0
        state = OneUserSort(k,2);
        switch state
            case OneUserSort(k,2)== o(1,1)
                OneUserSort(k,2)== o(1,1);
            case OneUserSort(k,3)== o(1,1)
                OneUserSort(k,2)== o(1,1);
            case OneUserSort(k,4)== o(1,1)
                OneUserSort(k,2)== o(1,1);
        end
    elseif (OneUserSort(k,3)> 0 && OneUserSort(k,4)== 0)
        state = OneUserSort(k,2);
        switch state
            case OneUserSort(k,2)== o(1,1)
                OneUserSort(k,2)== o(1,1);
            case OneUserSort(k,3)== o(1,1)
                OneUserSort(k,2)== o(1,1);
        end
    end;
end;
else
    clear o;
end;
%end of node elimination
    
         
        for k=1:((size_2(1,1))-1), 
            if OneUserSort(k,2)== OneUserSort(k+1,2)
            else 
                origin = OneUserSort(k,2);
                destination = OneUserSort(k+1,2);
                ODflow(origin,destination) = (ODflow(origin,destination)+1);
            end;
        end;
        OneUser=[];
        OneUserSort=[];
        j=1;
        OneUser(1,:)= data_full(i,2:5);
end;    
end;
%write the file
xlswrite('ODflow',ODflow)
