n = 64;

for i = 1:n
    phi{1,i} = asin((2*(i-1))/(n));
end

i = 1;
while i < (n/2)
    delta_phi{1, i+1} = phi{1,(n/2)+i}- phi{1,(n/2)-i};
    i = i+1;
end

i = n/2;
while i < n-1
    delta_phi{1, i+1} = phi{1,n-1-i};
    i = i+1;
end

delta_phi{1,1} = phi(n/2);