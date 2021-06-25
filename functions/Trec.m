function Trec = Trec(Frf,Fm,Fif,Grf,Gm,To)
%Trec Computes receiver input noise temperature
%   Receiver input noise temperature (Trec) is computed given the following
%   inputs. While additional terms can be added, their contribution is
%   assumed negligible.
%   (sourced From Ulaby et al. 1981, Volume 1, Chapter 6)
%   Frf: RF amplifier noise figure, input in dB
%   Fm: Mixer-pre-amplierifer noise figure, input in dB
%   Fif: IF amplifier noise figure, input in dB
%   Grf: RF amp power gain, input as db
%   Gm: Mixer pre-amp gain, input as db
%   To: Input noise temperature, default of 290 K (room temp)

if nargin == 5
    To = 290;
end

%convert to equivalent power
Frf = db2pr(Frf);
Fm = db2pr(Fm);
Fif = db2pr(Fif);
Grf = db2pr(Grf);
Gm = db2pr(Gm);

%compute Trec
Trec = ((Frf - 1)*To) + ((Fm - 1)*To)/(Grf) + ((Fif - 1)*To)/(Grf*Gm);
end

