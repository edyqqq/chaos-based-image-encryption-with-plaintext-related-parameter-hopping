function outputI = rearrange(I)

format long
[m,n,c] = size(I);
outputI = zeros(m,n*c);
ind = 1;
for i = 1 : n
    outputI(:, ind) = I(:, i, 1);
    outputI(:, ind+1) = I(:, i, 2);
    outputI(:, ind+2) = I(:, i, 3);
    ind = ind + 3;
end
end