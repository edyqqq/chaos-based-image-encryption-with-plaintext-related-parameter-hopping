function [r1,r2,r3,r4,r5,r6,r7,r8] = key_processing(Key)

format long
f4 = @(x,y) 4 - 10^(-15)*((9 - y)*256*65536 - x);

r1 = f4(hex2dec(Key(1:4)),1);
r2 = f4(hex2dec(Key(5:8)),2);
r3 = f4(hex2dec(Key(9:12)),3);
r4 = f4(hex2dec(Key(13:16)),4);
r5 = f4(hex2dec(Key(17:20)),5);
r6 = f4(hex2dec(Key(21:24)),6);
r7 = f4(hex2dec(Key(25:28)),7);
r8 = f4(hex2dec(Key(29:32)),8);
end