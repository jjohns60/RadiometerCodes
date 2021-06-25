function power_ratio = db2pr(decibels)
%db2pr Converts decibels to the equivalent power ratio
%   input a given decibel level to return the ratio in terms of
%   power_out/power_in. Where values less than 1 indicate loss and above 1
%   indicate gain
power_ratio = 10.^(decibels/10);
end

