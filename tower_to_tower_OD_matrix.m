
h=zeros(1360,1360); % total number of tower is 1360
z=[];
c=0;
i=0;
j=0;
sum=0;


m=dlmread('july15_new_perl.csv','\t'); % read the file


j=1;
p=[];
q=[];
f=0;
g=0;
ag2= size(m);
p(1,:)=m(1,:);
for i=2:(ag2(1,1)),
if m(i,1)== m(i-1,1)
    j=j+1;
    p(j,:)= m(i,:);
else
    ag1=size(p);
if (((ag1(1,1))>1) && (p(1,1)== p(2,1)))
q = sortrows(p);
ag=size(q);
        for k=1:((ag(1,1))-1), 
            if q(k,4)== q(k+1,4)
            elseif ((((q(k+1,3)- q(k,3))< 1800)) && ((q(k+1,3)- q(k,3))> 0))
                f = q(k,4);
                g = q(k+1,4);
                h(f,g) = (h(f,g)+1);
            end;
        end;
		else
end;
        p=[];
        q=[];
        j=1;
        p(1,:)= m(i,:);
end;
end;
for i=1:1360
    for j=1:1360
        sum=sum + (h(i,j));
    end;
end;
xlswrite('ODflow11',h);
