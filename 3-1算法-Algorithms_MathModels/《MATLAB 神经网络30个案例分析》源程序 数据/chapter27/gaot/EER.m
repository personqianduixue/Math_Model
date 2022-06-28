function [c1,c2]=er(p1,p2,bounds,genInfo,ops)
sz=size(p1,2);
%fprintf(1,'======EER======\n');
%fprintf(1,'%d ',p1(1:sz-1)); fprintf(1,'\n');
%fprintf(1,'%d ',p2(1:sz-1)); fprintf(1,'\n');

right=[2:sz-1 1];
left =[sz-1 1:(sz-2)];
p1i(p1(1:sz-1))=1:sz-1; %Generate index
p2i(p2(1:sz-1))=1:sz-1; %Generate index

adj=sort([-1:-1:-sz+1;p1(right(p1i));p1(left(p1i));p2(right(p2i));p2(left(p2i))])'; %'
repeats=find(diff(adj(:,2:5)')'==0);
adj(repeats+sz-1)=zeros(size(repeats)); %Zero repeat
adj(repeats+2*(sz-1))=-1*adj(repeats+2*(sz-1)); %Leftover is negative
adj=[adj sum(abs(sign(adj(:,2:5)))')'];

curr_site = round(rand*(sz-1) + 0.5); %Pick random start site
%curr_site=5;
%curr_site=8;
for site=1:(sz-2)
  c1(site)=curr_site;
  adj_cities=adj(curr_site,1+find(adj(curr_site,2:5))); %Cities adjacent
  i=find(adj_cities<0); 
  adj_cities=abs(adj_cities);
  %Zero out this site in adj table
  [cai caj]=find(abs(adj(adj_cities,2:5))==curr_site);
  adj(abs(adj(adj_cities(cai),1))+(sz-1)*caj)=zeros(size(cai,1),1);
  adj(curr_site,1:6)=[0 0 0 0 0 0];
  %Update nonzero count
  adj(adj_cities,6)=adj(adj_cities,6)-ones(size(cai,1),1);
  %Pick the destination city
  if(i==[]) %No negative city
    [v i]=min(adj(adj_cities,6));
    if (v==[]) %No cities left ERROR
      i=find(adj(:,1)<0); adj_cities=abs(adj(i,1)); i=1;
      %adj_cities=abs(adj(i,1));
      %i=1;
    end %No Cities left Error
  end %If no negative cities
  curr_site=abs(adj_cities(i(1)));
end
c1(sz-1:sz)=[curr_site p1(sz)]; %Tag on fittness
c2=p1; %Create other child
%fprintf(1,'%d ',c1(1:sz-1)); fprintf(1,'\n');