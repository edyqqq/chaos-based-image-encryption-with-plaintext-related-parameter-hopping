function [outputI] = rev_rearrange(I)

format long

[m,n] = size(I);
outputI = zeros(m,n/3,3);
ind = 1;
for i = 1 : n/3
    outputI(:, i, 1) = I(:, ind);
    outputI(:, i, 2) = I(:, ind+1);
    outputI(:, i, 3) = I(:, ind+2);
    ind = ind + 3;
end