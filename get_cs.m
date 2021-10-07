function [seq_p] = get_cs(p1,p2,p3,p4,p5,p6,p7,p8,ic,len,quan,Q)

format long

x0 = ic;
p_policy = [p1, p2, p3, p4, p5, p6, p7, p8];
cm = @(r,x) r*x*(1-x);
seq = zeros(1,len);

ind = 1;
% transient period 1000
for i = 1 : 1000
    x0 = cm(p_policy(ind),x0);
    if mod(i,125) == 0
        ind = ind + 1;
    end
end

% chaotic seq
ind = 1;
for j = 1 : len
    seq(j) = x0;
    x0 = cm(p_policy(ind),x0);
end

% quantization
if quan == 1    
    seq_p = floor(Q.*mod((10^(4).*seq),1));
else
    seq_p = seq;
end
end