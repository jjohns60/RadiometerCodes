%% To produce figures and test different microwave radiometer components as
%%  they relate to radiometer performance

%add functions to path for use in this code
addpath('../functions/')

%% INPUTS
B = 25E6; %radiometer bandwidth in Hz (cycles/sec)
t = [.001:.001:5]; %integration times in seconds (can input as range)
Frf = 2.3; %RF amplifier noise figure (in db)
Fm = 7.5; %Mixer pre-amp noise figure (in db)
Fif = 1.2; %IF amplifier noise figure (in db)
Grf = 30; %RF amplifier power gain (in db)
Gm = 23; %RF amplifier power gain (in db)
To = 290; %input noise temperature in Kelvin (standard room temp ~290K)
Ta = [200:350]; %radiometric antenna temperatures, can input as range (in Kelvin)

%% Computations
%compute Trec
TREC = Trec(Frf,Fm,Fif,Grf,Gm,To);

%compute Tsys
Tsys = Ta + TREC;
Tsys_0 = To + TREC;

%compute NEDT (output in degrees K) assuming Ta is the same as To
deltaT = NEDT(B,Tsys_0,t);

%compute 2-D matrix where columns correspond to system temperatures (and Ta)
% AND rows correspond to different integration times (t)
deltaT_all = NaN(length(t),length(Tsys));
for i = 1:length(Tsys)
    deltaT_all(:,i) = NEDT(B,Tsys(i),t);
end    

%% Plotting
figure('Renderer', 'painters', 'Position', [100 100 800 800]);
subplot(2,2,1); scatter(t,deltaT); grid on; ylabel('NEDT (K)'); xlabel('Integration time (t)')
subplot(2,2,2); scatter(Ta,Tsys); grid on; ylabel('System Temperature (Tsys, K)'); 
xlabel("Radiometric Antenna Temperature (Ta', K)"); title(['T_R_E_C: ' num2str(TREC,2)]);
subplot(2,2,[3,4]); 