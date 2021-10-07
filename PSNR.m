function value = PSNR(img1,img2)

format long
mse = mean(mean((im2double(img1) - im2double(img2)).^2, 1), 2);
value = 10 * log10(1 ./ mean(mse,3));

end