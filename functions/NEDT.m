function NEDT = NEDT(B,Tsys,t)
%NEDT computes the delta T value for a given radiometer
%   Delta T describes the precision/quality of a radiometer instrument
%   where small values indicate a strong ability to distinguish small
%   changes in radiometric brightness temperatures (and large values poor
%   precision). Otherwise known as Total Radiometer Power
%   B: input bandwidth of radiometer (Hz, cycles/sec)
%   Tsys: system temperature (degrees Kelvin, K)
%   t: integration time (sec)
NEDT = Tsys./((B.*t).^(0.5));
end

