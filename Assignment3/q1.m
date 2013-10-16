P = eye(2);

y = zeros(10, 100, 50);
phi1 = zeros(50, 128);
phi2 = zeros(50, 128);
theta1 = zeros(50, 2);
theta2 = zeros(50, 2);
for i=1:50,
    y(:,:,i) = uladata([0, 15] ,P,100,1,10,0.5);
    phi1(i,:) = beamform(y(:,:,i), 128, 0.5);
    phi2(i,:) = capon_sp(y(:,:,i), 128, 0.5);
    theta1(i,:) = root_music_doa(y(:,:,i), 2, 0.5);
    theta2(i,:) = esprit_doa(y(:,:,i), 2, 0.5);
end

phi1avg(1:128) = mean(phi1(:,1:128));
figure(1)
plot(phi1avg)

phi2avg(1:128) = mean(phi2(:,1:128));
figure(2)
plot(phi2avg)

figure(3)
stem(theta1(:), ones(100,1));

figure(4)
stem(theta2(:), ones(100,1));


