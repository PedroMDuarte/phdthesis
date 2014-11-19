% description: 
%    PDD_DESIGN script helps the designer to figure out bandwith an noise
%    specifications in photodiode transimpedance amplifier . 
%    Once the operational amplifier and photodiode parameters are defined, 
%    the phase compensation capacitor is computed then circuit bandwith and noise
%    are estimated.
%    The calculations arise out of the Jerald Graeme's book[1]. 
%    The user can supply his own electronic components from the
%    manufacturer datasheet.
%
% usage:
%    Used in frequency and noise analysis in photodiode transimpedance 
%    amplifier developpment.
%
% required specialized Matlab toolboxes: 
%    none.
%
% revision:
%   2007/03/01
%       - add comments.
%   2006/12/01
%       - file is created.
%
% author: 
%    Gilles Bailly
%    LCAR UMR5589 CNRS-Universite Toulouse
%    Toulouse
%
% references: 
%    [1] Photodiode amplifier, op amp solutions. Jerald Graeme,
%        McGraw-Hill 1996

clear all;

% Circuit structure
CIR.rf = 1e6;     % (Ohm) feedback resistor
CIR.cs = 0.5e-12; % (F) stray capacitance
CIR.vr = 5e-3;    % (V) reverse photodiode voltage 
%CIR.cf = 5e-12;   % (F) phase compensation capacitor 
%                 % needed only if designer impose feedback cap.
%                 % select 'user' in CIR.phasecomp member.
CIR.vmax = 5;     % (V) max. output voltage at the amplifier output

% choose operational amplifier structure
%CIR.oparef = 'OPA227';
%CIR.oparef = 'LF356';
%CIR.oparef = 'LTC6244';
CIR.oparef = 'LTC6241';

% choose photodiode structure
CIR.pdref = 'S2386_5K';

% choose 'auto' for automatic feedback capacitor 
CIR.phasecomp = 'auto'; % compute the feedback cap.
%CIR.phasecomp = 'user'; % use CIR.cf cap in the feedback

% generic operational amplifier structure
opa.reference = '';
opa.fc = 0;      % unity gain freq (Hz).
opa.cid = 0;     % input differential capacitance (F)
opa.cim = 0;     % input common mode capacitance (F)
opa.avol = 0;    % open loop gain (dB) at f=0
opa.ib = 0;      % input bias current (A);
opa.ios = 0;     % input offset current (A)
opa.enif = 0;    % input noise voltage -noise floor - (Vrms/Hz^0.5)
opa.ff = 0;      % input noise voltage corner frequency (Hz)

% generic photodiode structure
pd.reference ='';
pd.cd = 0;       % (F) capacitance at VR = 0V
pd.rsh = 0;      % (Ohm) shunt resistance 
pd.nep = 0;      % (W/Hz^0.5) Noise Equivalent Power 
pd.id = 0;       % (A) dark current 
pd.s = 0;        % (A/W)sensitivity at lambda
pd.lambda = 0;   % (nm) sensitivity wavelength 


% HAMAMATSU Si S2386 photodiode
S2386_5K = pd;
S2386_5K.reference = 'S2386_5K';
S2386_5K.cd = (730e-12)*0.1; %730e-12 nominal with 10% bootstap
S2386_5K.rsh = 50e9;
S2386_5K.id = 5e-12*3; % id at 10mv => ID=id*3
S2386_5K.nep = 9.6e-16;
S2386_5K.s = 0.47; % @ lambda = 671 nm
S2386_5K.lambda = 671;

% OPA227 bipolar operational amplifier
OPA227 = opa;
OPA227.reference = 'OPA227';
OPA227.fc = 8e6;    
OPA227.cid = 12e-12;     
OPA227.cim = 3e-12;    
OPA227.avol = 130;    
OPA227.ib = 2.5e-9;      
OPA227.ios = 2.5e-9;     
OPA227.enif = 3e-9;      
OPA227.ff = 10;     

% LF356 JFET operational amplifier
LF356 = opa;
LF356.reference = 'LF356';
LF356.fc = 5e6;    
LF356.cid = 3e-12;     
LF356.cim = 0;    
LF356.avol = 106;    
LF356.ib = 50e-12;      
LF356.ios = 50e-12;     
LF356.enif = 12e-9;      
LF356.ff = 100;     

% LTC6244 CMOS operational amplifier
LTC6244 = opa;
LTC6244.reference = 'LTC6244';
LTC6244.fc = 50e6;    
LTC6244.cid = 3.5e-12;     
LTC6244.cim = 2.1e-12;    
LTC6244.avol = 105;    
LTC6244.ib = 1e-12;      
LTC6244.ios = 1e-12;     
LTC6244.enif = 8e-9;      
LTC6244.ff = 200; 

% LTC6241 CMOS operational amplifier
LTC6241 = opa;
LTC6241.reference = 'LTC6241';
LTC6241.fc = 18e6;    
LTC6241.cid = (3.5+10)*1e-12; % + 10 pF from BF862 jfet boostrap    
LTC6241.cim = 3e-12;    
LTC6241.avol = 105;    
LTC6241.ib = 0.5e-12;      
LTC6241.ios = 0.2e-12;     
LTC6241.enif = 7e-9;      
LTC6241.ff = 100; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PHASE COMPENSATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% select components
eval(['OPA=', CIR.oparef]);
eval(['PD=', CIR.pdref]);

% feedback components
RF = CIR.rf;
CS = CIR.cs;
VR = CIR.vr;
% unity gain bandwith
FC = OPA.fc;
CD = PD.cd;
% total input capacitances
CIA = OPA.cid + OPA.cim;
% total capacitance
CI = CIA + CD;

% feedback pole at CF=0
FZF0 = 1/(2*pi*RF*(CI+CS));
% cross over frequency capacitance equivalent
CC = 1/(2*pi*RF*FC);

switch CIR.phasecomp,
    case 'auto',
        % phase compensation capacitance
        CF = (CC/2)*(1+(1+4*CI/CC)^0.5);
    case 'user',
        CF = CIR.cf;
end
CIR.cf = CF;

% feedback zero 
FCF = 1/(2*pi*RF*(CF+CS));
% feedback pole with CF 
FZF = 1/(2*pi*RF*(CI+CS+CF));
% intercept frequency 
FI = (FZF*FC)^0.5;
% signal bandwith approx.
BWT = 1.4*FCF;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NOISE ANALYSIS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 40+273;   % temperature (°K)
K = 1.38e-23; % Boltzman's cte (J/°K)
Q = 1.6e-19;  % electron charge (C)

F1 = 0.01; 
FPF = FCF;
ENIF = OPA.enif;
IB = OPA.ib;
FF = OPA.ff;

NEP = PD.nep;
S = PD.s;
ID = PD.id;
RSH = PD.rsh;
 VMAX = CIR.vmax;
% photocurrent at Vmax output
IP = VMAX/RF;
% equivalent incident power at IP
PI = IP/S;

% frequency bands
FR1 = [F1, FF];
FR2 = [FF, FZF];
FR3 = [FZF, FPF];
FR4 = [FPF, FI];
FR5 = [FI, FC];

% amplifier noise in different bandwith
ENOE1 = ENIF*(FF*log(FF/F1))^0.5; 
ENOE2 = ENIF*(FZF-FF)^0.5;
ENOE3 = ENIF/FZF*(1/3*(FPF^3 - FZF^3))^0.5;
ENOE4 = ENIF*(1+CI/CF)*(FI-FPF)^0.5;
ENOE5 = ENIF*FC*(1/FI)^0.5;
if (ENOE2<0), ENOE2 = 0; end
if (ENOE4<0), ENOE4 = 0; end
ENOE = (ENOE1^2 + ENOE2^2 + ENOE3^2 + ENOE4^2 + ENOE5^2)^0.5;

% resistor noise
ENOR = (2*K*T*RF*pi*BWT)^0.5;
ENOI = RF*(Q*IB*pi*BWT)^0.5;

% total transimpedance noise
ENOT = (ENOE^2 + ENOR^2 + ENOI^2)^0.5;

% photodiode noise
% leakage current
IL = ID*(1-exp(-VR/(K*T/Q)));
ENODL = RF*(Q*IL*pi*BWT)^0.5;
% photocurrent noise
ENODP = RF*(Q*IP*pi*BWT)^0.5;
% shunt resistor noise
ENODR = RF*(2*K*T/RSH*pi*BWT)^0.5;
% total phodiode noise
ENOD = (ENODL^2 + ENODP^2 + ENODR^2)^0.5;

h_1 = figure;
set(h_1,'Name', ['Noise analysis for the ',...
    OPA.reference, ' amplifier and ',...
    PD.reference, ' photodiode']);

subplot(3,1,1), bar([ENOE1,ENOE2,ENOE3,ENOE4,ENOE5, ENOE, ENOR, ENOI]'),...
    title('The 5 amplifier''s volt. components, RMS sum(total amp.), resistor and amp.current '),...
    ylabel('V_{RMS}');

subplot(3,1,2), bar([ENODL,ENODP,ENODR,ENOD]'),...
    title('The photodiode noises: leakage, photocurrent, shunt resistor and the RMS sum(total) '),...
    ylabel('V_{RMS}');

subplot(3,1,3), bar([ENOT, ENOD]');
    title('The transimpedance and photodiode noises'),...
    ylabel('V_{RMS}');



display(' ');
display('******************************************************');
display('***** PHOTODIODE TRANSIMPEDANCE AMPLIFIER DESIGN *****');
display('******************************************************');

display(' ');
display('Amplifier model...');
display([' reference :                                 ', OPA.reference]);
display([' input cap. :                          CIA = ', num2str(CIA,'%0.3e'), ' F']);
display([' unity gain freq. :                     FC = ', num2str(FC,'%0.3e'), ' Hz']);

display(' ');
display('Photodiode model...');
display([' reference :                                 ', PD.reference]);
display([' input cap. :                           CD = ', num2str(CD,'%0.3e'), ' F']);
display([' dark current :                         ID = ', num2str(ID,'%0.3e'), ' A']);
display([' sensitivity :                           S = ', num2str(S,'%0.3e'), ' A/W']);
display(['  at lambda :                            L = ', num2str(PD.lambda,'%0.3e'), ' nm']);

display(' ');
display('Feedback model...');
display([' total input capacitance:               CI = ', num2str(CI,'%0.3e'), ' F']);
display([' feedback resistor:                     RF = ', num2str(RF,'%0.3e'), ' Ohm']);
display([' stray capacitance:                     CS = ', num2str(CS,'%0.3e'), ' F']);

display(' ');
display('Incident power ...');
display([' max. output voltage:                 VMAX = ', num2str(VMAX,'%0.3e'), ' V']);
display([' equ. photocurrent:                     IP = ', num2str(IP,'%0.3e'), ' A'])
display([' equ. input power:                      PI = ', num2str(PI,'%0.3e'), ' W']);

display(' ');
display('Phase compensation...');
display([' feedback pole at CF=0:               FZF0 = ', num2str(FZF0,'%0.3e'), ' Hz']);
display([' crossover frequency capacitance equ.:  CC = ', num2str(CC,'%0.3e'), ' F']);
display([' phase compensation capacitance:        CF = ', num2str(CF,'%0.3e'), ' F']);
display([' feedback zero:                        FCF = ', num2str(FCF,'%0.3e'), ' Hz']);
display([' feedback pole with CF:                FZF = ', num2str(FZF,'%0.3e'), ' Hz']);
display([' intercept frequency:                   FI = ', num2str(FI,'%0.3e'), ' Hz']);
display([' signal bandwith approx.:              BWT = ', num2str(BWT,'%0.3e'), ' Hz']);

display(' ');
display('Noise analysis...');
display([' amp. freq range, region I:           FR1 = ', mat2str(FR1,3), ' Hz']);
display([' amp. freq range, region II:          FR2 = ', mat2str(FR2,3), ' Hz']);
display([' amp. freq range, region III:         FR3 = ', mat2str(FR3,3), ' Hz']);
display([' amp. freq range, region IV:          FR4 = ', mat2str(FR4,3), ' Hz']);
display([' amp. freq range, region V:           FR5 = ', mat2str(FR5,3), ' Hz']);
display([' signal bandwith approx.:             BWT = ', num2str(BWT,'%0.3e'), ' Hz']);
display([' amp. noise, region I:              ENOE1 = ', num2str(ENOE1,'%0.3e'), ' Vrms']);
display([' amp. noise, region II:             ENOE2 = ', num2str(ENOE2,'%0.3e'), ' Vrms']);
display([' amp. noise, region III:            ENOE3 = ', num2str(ENOE3,'%0.3e'), ' Vrms']);
display([' amp. noise, region IV:             ENOE4 = ', num2str(ENOE4,'%0.3e'), ' Vrms']);
display([' amp. noise, region V:              ENOE5 = ', num2str(ENOE5,'%0.3e'), ' Vrms']);
display([' total amplifier noise:              ENOE = ', num2str(ENOE,'%0.3e'), ' Vrms']);
display(' ');
display([' photodiode noise, leakage current: ENODL = ', num2str(ENODL,'%0.3e'), ' Vrms']);
display([' photodiode noise, photo current:   ENODP = ', num2str(ENODP,'%0.3e'), ' Vrms']);
display([' photodiode noise, shunt resist.:   ENODR = ', num2str(ENODR,'%0.3e'), ' Vrms']);
display([' total photodiode noise:             ENOD = ', num2str(ENOD,'%0.3e'), ' Vrms']);

display(' ');
display([' total amplifier noise:              ENOE = ', num2str(ENOE,'%0.3e'), ' Vrms']);
display([' resistor noise, region BWT:        ENOER = ', num2str(ENOR,'%0.3e'), ' Vrms']);
display([' current noise, region BWT:         ENOER = ', num2str(ENOI,'%0.3e'), ' Vrms']);
display([' total transimpedance noise:         ENOT = ', num2str(ENOT,'%0.3e'), ' Vrms']);
display([' total photodiode noise:             ENOD = ', num2str(ENOD,'%0.3e'), ' Vrms']);