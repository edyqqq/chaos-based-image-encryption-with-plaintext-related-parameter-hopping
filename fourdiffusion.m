function [I] = fourdiffusion(I)

format long
[h, w_p] = size(I);
for l = 1 : h
    if l == 1
        I(l,:) = mod((I(l,:)+I(h,:)),256);
    else
        I(l,:) = mod((I(l,:)+I(l-1,:)),256);
    end

    if l == h
        I(l,:) = bitxor(I(l,:),I(1,:));
    else
        I(l,:) = bitxor(I(l,:),I(l+1,:));
    end
end

for k = 1 : w_p
    if k == 1
        I(:,k) = mod((I(:,k)+I(:,w_p)),256);
    else
        I(:,k) = mod((I(:,k)+I(:,k-1)),256);
    end

    if k == w_p
        I(:,k) = bitxor(I(:,k),I(:,1));
    else
        I(:,k) = bitxor(I(:,k),I(:,k+1));
    end
end

for l = h : 1
    if l == h
        I(l,:) = mod((I(l,:)+I(1,:)),256);
    else
        I(l,:) = mod((I(l,:)+I(l+1,:)),256);
    end

    if l == 1
        I(l,:) = bitxor(I(l,:),I(h,:));
    else
        I(l,:) = bitxor(I(l,:),I(l-1,:));
    end
end

for k = w_p : 1
    if k == w_p
        I(:,k) = mod((I(:,k)+I(:,1)),256);
    else
        I(:,k) = mod((I(:,k)+I(:,k+1)),256);
    end

    if k == 1
        I(:,k) = bitxor(I(:,k),I(:,w_p));
    else
        I(:,k) = bitxor(I(:,k),I(:,k-1));
    end
end

end