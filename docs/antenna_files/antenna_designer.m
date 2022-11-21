% outputs y and z for 20m antenna

angle = 30;
z_max = 9.144;
antenna_length = 5.26;

y_dist = antenna_length * cosd(angle);

z_dist = z_max - antenna_length*sind(angle);

% output y and z for 40m antenna

z_new = 6.514;
y_new = 4.555;
antenna_length_new = 5;

y_dist_40 = y_new + antenna_length_new * cosd(angle)

z_dist_40 = z_dist - antenna_length_new*sind(angle)



% Resonance trap calculator
f = 14.05e6;
L = 8.54e-6;
C = 15e-12;

X_L = 2*pi*f*L;

X_C = -1/(2*pi*f*C);

R = abs(1i*(X_L + X_C));