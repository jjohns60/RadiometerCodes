%% To produce figures and test different microwave radiometer components as
%%  they relate to radiometer performance

%add functions to path for use in this code
addpath('../functions/')

%% INPUTS
B = 25E6; %radiometer bandwidth in Hz (cycles/sec)
t = [.001:.001:1]; %integration times in seconds (can input as range)
Frf = 5; %RF amplifier noise figure (in db)
Fm = 7.5; %Mixer pre-amp noise figure (in db)
Fif = 1.2; %IF amplifier noise figure (in db)
Grf = 30; %RF amplifier power gain (in db)
Gm = 23; %RF amplifier power gain (in db)
To = 290; %input noise temperature in Kelvin (standard room temp ~290K)
Ta = [100:100:1000]; %radiometric antenna temperatures, can input as range (in Kelvin)

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
Tsys_all = repmat(Tsys,[length(t) 1]);
t_all = repmat(t',[1 length(Tsys)]);
for i = 1:length(Tsys)
    deltaT_all(:,i) = NEDT(B,Tsys(i),t);
end    

%% Plotting
figure('Renderer', 'painters', 'Position', [100 100 800 800]); 
subplot(2,2,1); scatter(t,deltaT); grid on; ylabel('NEDT (K)'); xlabel('Integration time (sec)')
t1 = "NEDT, Ta == To' (" + num2str(To,3) + " K)";
title(t1)

subplot(2,2,2); scatter(Ta,Tsys); grid on; ylabel('System Temperature (Tsys, K)'); 
xlabel("Radiometric Antenna Temperature (Ta', K)"); title(['T_R_E_C: ' num2str(TREC,3) ' K']);

subplot(2,2,[3,4]); scatter(t_all(:),deltaT_all(:),[],Tsys_all(:)); grid on;
c = colorbar; ylabel(c,'Tsys'); ylabel('NEDT (K)'); xlabel('Integration time (sec)')