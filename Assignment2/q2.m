r01 = getdata('q2_data/R01.DAT');
r10 = getdata('q2_data/R10.DAT');
r40 = getdata('q2_data/R40.DAT');
i01 = getdata('q2_data/I01.DAT');
i10 = getdata('q2_data/I10.DAT');
i40 = getdata('q2_data/I40.DAT');

x01 = r01 + i01*1i;
x10 = r10 + i10*1i;
x40 = r40 + i40*1i;

%2a
per_x01 = periodogramse(x01,rectwin(8), 1024);
figure(1)
plot(per_x01)


p=7;
y1 = [zeros(p,1);x01';zeros(p,1)];
N = 32;

Y1 = zeros(N, p);
for i=1:N+p,
    for j=1:p,
        Y1(i, j) = y1(p+i-j);
    end
end


%Autocorrelation method: N1=1, N2 = N+p
N1=1; N2 = N+p;
ya = y1(N1+p:N2+p);
Ya = Y1(N1:N2,:);

theta_a = -inv(Ya'*Ya)*Ya'*ya;

Pspec_a=zeros(1024, 1);
for k=0:1024,
    w = k/1024 * 2 * pi;
    expo = [1; exp(-1i*w); exp(-2i*w); exp(-3i*w); exp(-4i*w); exp(-5i*w); exp(-6i*w); exp(-7i*w)];
    Pspec_a(k+1) = 1/abs(expo'*[1;theta_a])^2;
end
figure(2)
plot(Pspec_a)

%Covariance method: N1=p+1, N2=N
N1=p+1; N2=N;
yc = y1(N1+p:N2+p);
Yc = Y1(N1:N2,:);

theta_c = -inv(Yc'*Yc)*Yc'*yc;

Pspec_c=zeros(1024, 1);
for k=0:1024,
    w = k/1024 * 2 * pi;
    expo = [1; exp(-1i*w); exp(-2i*w); exp(-3i*w); exp(-4i*w); exp(-5i*w); exp(-6i*w); exp(-7i*w)];
    Pspec_c(k+1) = 1/abs(expo'*[1;theta_c])^2;
end
figure(3)
plot(Pspec_c)

%MUSIC method

pm = 8;
y1m = [zeros(pm,1);x01';zeros(pm,1)];
N = 32;

Y1m = zeros(N, pm);
for i=1:N+pm,
    for j=1:pm,
        Y1m(i, j) = y1m(pm+i-j);
    end
end
N1=pm+1; N2=N;
Ycm = Y1m(N1:N2,:);

[V D] = eig(Ycm'*Ycm);
Vn = V(:,1:5);
Pspec_mu=zeros(1024, 1);
for k=0:1024,
    w = k/1024 * 2 * pi;
    expo = [1; exp(1i*w); exp(2i*w); exp(3i*w); exp(4i*w); exp(5i*w); exp(6i*w); exp(7i*w)];
    
    Pspec_mu(k+1) = 1/sum(abs(expo'*conj(Vn)).^2);
end
figure(4)
plot(Pspec_mu)

%Min norm

u1 = [1 0 0 0 0 0 0 0]';

denom = u1'*(Vn)*(Vn)'*u1;
a = (Vn)*(Vn)'*u1;
a = a/denom;

Pspec_min = zeros(1024,1);
for k=0:1024,
    w = k/1024 * 2 * pi;
    expo = [1; exp(1i*w); exp(2i*w); exp(3i*w); exp(4i*w); exp(5i*w); exp(6i*w); exp(7i*w)];
    Pspec_min(k+1) = 1/abs(expo'*conj(a)).^2;
end
figure(5)
plot(Pspec_min)


