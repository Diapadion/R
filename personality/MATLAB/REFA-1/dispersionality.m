function [sth] = dispersionality(rotmat)

rotmat = abs(rotmat);
nrm = max(abs(rotmat)');

sz = size(rotmat);
for i = 1:sz(2)
    rotmat(:,i) = rotmat(:,i) - nrm';
end

sth= mean(rotmat');


end
