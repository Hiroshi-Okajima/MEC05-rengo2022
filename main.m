function main

%r = tf([1],[1 0]);

pm = tf([1],[1 3 2]);

%MECの誤差補償器
d = tf([80 40],[1 0]);

%フィードバック制御器
c = tf([3 5],[1]);

k = [0.9,1.1,1,1,0.9,1.1,0.95,1.05];
t = [1,1,0.9,1.1,0.9,1.1,1.05,0.95];

for i = 1:8
p = tf([k(i)],[t(i) 1])*tf([1],[1 2]);
pc = p*(1+pm*d)/(1+p*d);
figure(1)
step(pc)
axis([0 10 0 1.2])
hold on
filename=['main01/main012-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(2)
step(pc)
axis([0 10 0 1.2])
hold on
filename=['main01/main013-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(3)
step(p)
axis([0 10 0 1.2])
hold on
filename=['main01/main011-',num2str(i),'.jpg'];
saveas(gcf,filename);
end

for i = 1:8
p = tf([k(i)],[t(i) 1])*tf([1],[1 2]);
g = feedback(p*c,1);

pc1 = feedback(p,d);
pc2 = feedback(p*d,1);
pc = p*(1+pm*d)/(1+p*d);

gc01 = pc1*feedback(c,pm)+pc2*feedback(pm*c,1);
gc02 = feedback(pc*c,1);
figure(4)
step(gc01)
axis([0 3 0 1.2])
hold on
filename=['main02/main022-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(5)
step(gc02)
axis([0 3 0 1.2])
hold on
filename=['main02/main023-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(6)
step(g)
axis([0 3 0 1.2])
hold on
filename=['main02/main021-',num2str(i),'.jpg'];
saveas(gcf,filename);
end