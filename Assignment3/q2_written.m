% L shaped sensor array. REF Q2 Assignment3

theta = -pi/2:pi/180:pi/2;

m=17;
dl=0.5;
ws1 = 2*pi*dl*sin(theta);
ws2 = - 2*pi*dl*cos(theta);
m1=(m-1)/2;

a1 = [exp(-1i*ws1); exp(-2i*ws1); exp(-3i*ws1); exp(-4i*ws1); exp(-5i*ws1); exp(-6i*ws1); exp(-7i*ws1); exp(-8i*ws1);];
a2 = [exp(0i*ws2); exp(-1i*ws2); exp(-2i*ws2); exp(-3i*ws2); exp(-4i*ws2); exp(-5i*ws2); exp(-6i*ws2); exp(-7i*ws2); exp(-8i*ws2);];

a = [a2' a1'];

theta0 = 90*pi/180;
ws10 = 2*pi*dl*sin(theta0);
ws20 = - 2*pi*dl*cos(theta0);

a10 = [exp(-1i*ws10); exp(-2i*ws10); exp(-3i*ws10); exp(-4i*ws10); exp(-5i*ws10); exp(-6i*ws10); exp(-7i*ws10); exp(-8i*ws10);];
a20 = [exp(0i*ws20); exp(-1i*ws20); exp(-2i*ws20); exp(-3i*ws20); exp(-4i*ws20); exp(-5i*ws20); exp(-6i*ws20); exp(-7i*ws20); exp(-8i*ws20);];

a0 = [a20' a10'];

W = a*a0';

plot(theta*180/pi, abs(W).^2);


