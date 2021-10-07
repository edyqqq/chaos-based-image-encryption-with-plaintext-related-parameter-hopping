clc
clear
format long

% start time
tic;
% read image
img = imread("lena512.png");
f = @(r,x) r*x*(1-x);

% key initialze
K1 = 'C90FDAA22168C234C4C6628B80DC1CD1';
K2 = 'C90FDAA22168C234C5C6628B80DC1CD1';
K3 = '00000000000000000000000000000000';

% start encryption..... 
disp('start encryption....');
% step 1 : image rearrangement
img_s1 = rearrange(img);
[h,w_p] = size(img_s1);

% step 2 : key processing
[r1,r2,r3,r4,r5,r6,r7,r8] = key_processing(K1);

% step 3 : Row-wise combination with plaintext-related sequence
LT = lookuptable_diffusion(img_s1,r1,r2,r3,r4,r5,r6,r7,r8);

seq1 = get_cs(r4,r8,r3,r7,r2,r6,r1,r5,0.5,w_p,1,h-1);
seq2 = get_cs(r5,r1,r6,r2,r7,r3,r8,r4,0.5,h,1,w_p-1);

% circular shift
for j = 1 : w_p
    LT(:,j) = circshift(LT(:,j),seq1(j));
end
for i = 1 : h
    LT(i,:) = circshift(LT(i,:),seq2(i));
end

x1001 = get_cs(r1,r2,r3,r4,r5,r6,r7,r8,0.5,1,0,255);

% plaintext-related
for l = 1 : h
    if l == 1
        LT(l,:) = LT(l,:) + 10^(-15)*65536*img_s1(h,:);
    else
        LT(l,:) = LT(l,:) + 10^(-15)*65536*img_s1(l-1,:);
    end
    seqplr = zeros(1,w_p);
    for i = 1 : w_p
        seqplr(i) = x1001;
        x1001 = f(LT(l,i),x1001);
    end
    seqplr_p = floor(255.*mod((10^(4).*seqplr),1));
    img_s1(l,:) = bitxor(img_s1(l,:),seqplr_p);
end

% step 4 : Column-wise and row-wise confusion
seq4 = get_cs(r2,r1,r4,r3,r6,r5,r8,r7,0.5,w_p,1,h-1);
seq5 = get_cs(r7,r8,r5,r6,r3,r4,r1,r2,0.5,h,1,w_p-1);

% circular shift image
for j = 1 : w_p
    img_s1(:,j) = circshift(img_s1(:,j),seq4(j));
end
for i = 1 : h
    img_s1(i,:) = circshift(img_s1(i,:),seq5(i));
end

% step 5 : Four dimensional diffusion stage
img_s5 = fourdiffusion(img_s1);

% step 6 : Combination with a pseudo-random sequence
seq6 = get_cs(r8,r7,r6,r5,r4,r3,r2,r1,0.5,h*w_p,1,255);
seq6 = reshape(seq6,[h,w_p]);
img_s6 = bitxor(img_s5,seq6);

% step 7 : image rearrange
en_img = uint8(rev_rearrange(img_s6));

% end time
toc
disp('suceessfully encrypted')

