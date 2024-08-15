%Flyback Converter
Vin = 3.7;
Vbat = 3.7;
Rin = 100e-3;
Rout = Rin;
D = 0.5021;
Dp = 1-D;
n = 1;
delIlm = 0.01;
delVc = 0.02;
fs = 250e3;

Vc = (D*Vin + n*D*Rin*Vbat/Dp/Rout)/(Dp/n + n*D*Rin/Dp/Rout);
Iin = (D/Dp)* (Vc-Vbat)/Rout;
Ilm = Iin/D;
Lm = Vc*Dp/delIlm/fs;
C = D/fs*(Vc-Vbat)/Rout/delVc;

s = tf('s');
opts = bodeoptions;
opts.freqUnits = 'Hz';
opts.xLim = [100, 1000e3];
opts.grid = 'on';
%Plant Transfer function initialisation
GiLmd0 = (Vc/n/D + Dp*Rout*Ilm/n/n)/((D*Rin+Dp*Dp*Rout/n/n));
wz = (Vc/n/D + Dp*Rout*Ilm/n/n)/(C*Rout*Vc/n/D);
w0 = sqrt((D*Rin+Dp*Dp*Rout/n/n)/Lm/C/Rout);
Q = (D*Rin + Dp*Dp*Rout/n/n)/(Lm + D*Rin*Rout*C)/w0;
GiLmd = GiLmd0*(1+s/wz)/(1+(s/Q/w0)+(s/w0)^2);
Rsense = 5/0.2;
Vm = 5;
% bode(GiLmd,opts);

Giind = Ilm + D*GiLmd;
Tuiind = Giind*Rsense/Vm;

%Controller design
fc = 20e3;
wLv = 2*pi*fc*tan(75*pi/180);
wpfilter = 2*pi*30e3;
Gfilter = 1/(1+s/wpfilter);
Gcinf = (abs(evalfr(Tuiind,1i*2*pi*fc)))/sqrt(1+(wLv/2/pi/fc)^2)/abs(evalfr(Gfilter,1i*2*pi*fc));
Gc = Gcinf*(1+wLv/s)*Gfilter;               % final controller for glyback converter
opts.xLim = [1,100e5];
bode(Gc*Tuiind,opts);


%Two switch flyback
Vin2 = 3.7;
Vbat2 = 3*3.7;
Rin2 = 100e-3;
Rout2 = 3*Rin2;
D2 = 0.4303;
Dp2 = 1-D2;
n2 = 4;
delIlm2 = 0.01;
delVc2= 0.02;
fs = 250e3;

Vc2 = (D2*Vin2+ n2*D2*Rin2*Vbat2/Dp2/Rout2)/(Dp2/n2 + n2*D2*Rin2/Dp2/Rout2);
Iin2 = n2*(D2/Dp2)* (Vc2-Vbat2)/Rout2;
Ilm2 = Iin2/D2;
Lm2 = Vc2*Dp2/delIlm2/fs;
C2 = D2/fs*(Vc2-Vbat2)/Rout2/delVc2;

GiLmd02 = (Vc2/n2/D2 + Dp2*Rout2*Ilm2/n2/n2)/((D2*Rin2+Dp2*Dp2*Rout2/n2/n2));
wz2 = (Vc2/n2/D2 + Dp2*Rout2*Ilm2/n2/n2)/(C2*Rout2*Vc2/n2/D2);
w02 = sqrt((D2*Rin2+Dp2*Dp2*Rout2/n2/n2)/Lm2/C2/Rout2);
Q2 = (D2*Rin2 + Dp2*Dp2*Rout2/n2/n2)/(Lm2 + D2*Rin2*Rout2*C2)/w02;
GiLmd2 = GiLmd02*(1+s/wz2)/(1+(s/Q2/w02)+(s/w02)^2);
% bode(GiLmd2,opts);
Rsense2 = 5/0.1;
Vm = 5;

Giind2 = Ilm2 + D2*GiLmd2;
Tuiind2 = Giind2*Rsense2/Vm;
bode(Tuiind2,opts);

%Controller design
fc = 20e3;
wLv2 = 2*pi*fc*tan(60*pi/180);
wpfilter2 = 2*pi*10e3;
Gfilter2 = 1/(1+s/wpfilter2);
Gcinf2 = (abs(evalfr(Tuiind2,1i*2*pi*fc)))/sqrt(1+(wLv2/2/pi/fc)^2)/abs(evalfr(Gfilter,1i*2*pi*fc));
Gc2 = Gcinf2*(1+wLv2/s)*Gfilter2;           %final controller for two switch flyback
% opts.xLim = [1,100e5];
% bode(Gc2*Tuiind2,opts);