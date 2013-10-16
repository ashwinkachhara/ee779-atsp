load('submarine.mat');

dl = d/lambda;

angle = -89:180/200:90;

phi1 = beamform(X, 200, dl);
figure(1)
plot(angle, phi1)

phi2 = capon_sp(X, 200, dl);
figure(2)
plot(angle, phi2)

theta1 = root_music_doa(X, 2, dl)
theta2 = esprit_doa(X, 2, dl)
