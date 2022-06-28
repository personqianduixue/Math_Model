function [v,mf]=grMaxFlows(E,s,t)
% Function [v,mf]=grMaxFlows(E,s,t) solve the problem 
% about the maximal flow in the network.
% Input parameters: 
%   E(m,2) or (m,3) - the arrows of digraph and their weight;
%     1st and 2nd elements of each row is numbers of vertexes;
%     3rd elements of each row is weight of arrow;
%     m - number of arrows.
%     If we set the array E(m,2), then all weights is 1.
%   s - input (source) of the network (number of vertex);
%   t - output (sink) of the network (number of vertex).
% Output parameters: 
%   v(m,1) - vector-column of flows in the arrows;,
%   mf - the total maximal flow in the network.
% Uses the reduction to LP-problem.
% Required the Optimization Toolbox
% Author: Sergiy Iglin
% e-mail: siglin@yandex.ru
% personal page: http://iglin.exponenta.ru

% ============= Input data validation ==================
if nargin<3,
  error('Required three input data: E, s, t.')
end
[m,n,E] = grValidation(E); % E data validation
if ~ismember(s,E(:,1)),
  error(['From vertex number s=' num2str(s) ' does not go out any arrow!'])
end
if ~ismember(t,E(:,2)),
  error(['To vertex number t=' num2str(t) ' does not go in any arrow!'])
end

% ============= Parameters of LP problem ==========
A=zeros(n,m); % for incidence matrix
A(E(:,1)+([1:m]'-1)*n)=1; % we fill the incidence matrix
A(E(:,2)+([1:m]'-1)*n)=-1;
Aeq=A(setdiff([1:n],[s t]),:); % the balance of flows
options=optimset('linprog'); % the default options
options.Display='off'; % we change the output
options.TolX=1e-12; % we change the output

% ============= We solve the LP problem ==========
v=linprog(-A(s,:)',[],[],Aeq,zeros(size(Aeq,1),1),...
  zeros(m,1),E(:,3),[],options); % we solve the LP-problem
mf=A(s,:)*v; % the total flow
return