function main_unst

r = tf([1],[1 0]);

pm = tf([1 3],[1 1 -2]);

%MECの誤差補償器
%d = tf([70 50],[1 0]);
d = tf([500 200],[1 0]);

%フィードバック制御器
c = tf([10 20],[1 0]);

k = [-2,1,0.5,-0.5,2,-1,2.3,0.5,-1.3];
t = [1,1,0.9,1.1,0.9,1.1,1.05,0.95];

for i = 1:7
p = tf([1 3],[1 1 -2])+tf([k(i)],[t(i) 2])*tf([1],[1 1]);%tf([k(i)],[t(i) 2])*tf([1],[1 -1]);
pc = p*(1+pm*d)/(1+p*d);
figure(1)
impulse(pc*r)
axis([0 10 0 1.2])
hold on
filename=['main01un/main012-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(2)
impulse(pc*r)
axis([0 10 0 1.2])
hold on
filename=['main01un/main013-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(3)
impulse(p*r)
axis([0 10 0 1.2])
hold on
filename=['main01un/main011-',num2str(i),'.jpg'];
saveas(gcf,filename);
end

for i = 1:7
p = tf([1 3],[1 1 -2])+tf([k(i)],[t(i) 2])*tf([1],[1 1]);%tf([k(i)],[t(i) 2])*tf([1],[1 -1]);
g = feedback(p*c,1);

pc1 = feedback(p,d);
pc2 = feedback(p*d,1);
pc = p*(1+pm*d)/(1+p*d);

gc01 = pc1*feedback(c,pm)+pc2*feedback(pm*c,1);
gc02 = feedback(pc*c,1);
figure(4)
impulse(gc01*r)
axis([0 3 0 1.2])
hold on
filename=['main02un/main022-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(5)
impulse(gc02*r)
axis([0 3 0 1.2])
hold on
filename=['main02un/main023-',num2str(i),'.jpg'];
saveas(gcf,filename);
figure(6)
impulse(g*r)
axis([0 3 0 1.2])
hold on
filename=['main02un/main021-',num2str(i),'.jpg'];
saveas(gcf,filename);
end
