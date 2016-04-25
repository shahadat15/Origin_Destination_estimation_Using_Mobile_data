%Open the file
fid=fopen('july15_order.csv');

a=123456789;
z=[];
c=0;
i=0;
%k=0;
%for k=1:k+1:1000,
 %tline = fgetl(fid);
%end;
 %      a=tline(1:24);
for j=1:j+1:5000000,
    tline = fgetl(fid);
    i=i+1;
    if strfind(tline,a)>0
        z(i,1)=c;
    else
         c=c+1;
        z(i,1)=c;
        a=tline(1:24);
    end
end;
fclose(fid);


b=dlmread('july15_order.csv',',',[0,2,4999999,5]);
m=[z(:,1) b(:,1:4)];

clear z;
clear b;

h=zeros(33,33);
j=1;
p=[];
q=[];
f=0;
g=0;
p(1,:)= m(1,2:5);
for i=2:length(m),
if m(i,1)== m(i-1,1)
    j=j+1; 
    p(j,:)= m(i,2:5);
    ag1=size(p);
elseif ((ag1(1))>2)
q = sortrows(p);
ag=size(q);
    %to eliminate second and third node
    l=1;
    r=[];
for k=1:((ag(1,1))-1),
    if  q(k,3)== 0
        r(l,:)= q(k,2);
        l=l+1;
    else
    end
end;
o= unique(r);
clear r;
if length(o)> 1;
for k=1:((ag(1,1))-1),
    if q(k,3)> 0 && q(k,4)> 0
        state = q(k,2);
        switch state
            case q(k,2)== o(1,1)
                q(k,2)== o(1,1);
            case q(k,3)== o(1,1)
                q(k,2)== o(1,1);
            case q(k,4)== o(1,1)
                q(k,2)== o(1,1);
        end
    elseif (q(k,3)> 0 && q(k,4)== 0)
        state = q(k,2);
        switch state
            case q(k,2)== o(1,1)
                q(k,2)== o(1,1);
            case q(k,3)== o(1,1)
                q(k,2)== o(1,1);
        end
    end;
end;
else
    clear o;
end;
    %end of node elimination
    
         
        for k=1:((ag(1,1))-1), 
            if q(k,2)== q(k+1,2)
            else 
                f = q(k,2);
                g = q(k+1,2);
                h(f,g) = (h(f,g)+1);
            end;
        end;
        p=[];
        q=[];
        j=1;
        p(1,:)= m(i,2:5);
end;    
end;
%write the file
xlswrite('ODflow',h)
