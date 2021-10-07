function [LT] = lookuptable_diffusion(I,p1,p2,p3,p4,p5,p6,p7,p8)

format long

[m,n] = size(I);
LT = zeros(m,n);
paraset = [p1, p2, p3, p4, p5, p6, p7, p8];

% lookup table setup
ind = 1;
for i = 1 : m
    for j = 1 : n
        t_ind = mod(ind,8);
        if t_ind == 0
            t_ind = 8;
        end
        LT(i, j) = paraset(t_ind);
        ind = ind + 1;
    end
end

% seq1 and seq2 generation



end