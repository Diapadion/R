%Permutation tests for dimensionality selection

function [q]=permudim(dt)

%
nbs=200;
%
if cond(cov(dt))>200
  lmd=[0 0.5 1 3 5 10];
else
  lmd=[0];
end
mm=length(lmd);
fn=zeros(mm,1);

for b=1:mm
    lambda=lmd(b);
    m=0;
    
%correlation matrices 
t=sum(dt);
[nr n]=size(dt); %nr= sample size, n= # variables
fm=t/nr;
dt=dt-ones(nr,1)*fm;
Cs=dt'*dt+lambda*eye(n)/nr;
sd=sqrt(diag(diag(Cs)));
sdb=inv(sd);
dts=dt*sdb;
X=dts;


%Permutation tests for dimensionality selection
[N n]=size(X);


Xt=X;
XXt=Xt'*Xt+lambda*eye(n);
[u0 d0 v0]=svd(XXt);
d0sqr=sqrt(d0);
U0=Xt*v0*inv(d0sqr);

fmx=zeros(n,1);
rmxc=diag(d0);
Xp=zeros(N,n);
Xp(:,1)=Xt(:,1);



for k=1:nbs
        for i=2:n
           Xp(:,i)=Xt(randperm(N),i);
        end
              
        XXp=Xp'*Xp+lambda*eye(n);
[u5 d5 v5]=svd(XXp);

rmx=diag(d5);

for i=1:n
if rmx(i)>rmxc(i),
    fmx(i)=fmx(i)+1;
end%if
end%i



end%k


pbtab=fmx/nbs;
for i=1:n
    if pbtab(i) <= 0.05
        m=m+1;
    end
end


fn(b,1)=m;

end %b

q=min(fn);
