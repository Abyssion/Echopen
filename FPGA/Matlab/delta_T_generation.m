%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Generation of the constant use to calcul th deltaT
%%  used to know when the system have to send a pulse to
%%  the transducer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Creation  :  02/04/2016
%%  Update    :  02/04/2016
%%  Created by KHOYRATEE Farad
%%  Updated by KHOYRATEE Farad
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 64;         %% Shoot number

%%Angle calcul
for i = 1:n
    phi{1,i} = asin((2*(i-1))/(n));
end

i = 1;

%% the angle of the motor rotation between two pulse
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