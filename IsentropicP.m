function [stagP,staticP] = IsentropicP(stagP,staticP,mach,speed,staticT)
% IsentropicP: finds either the isentropic stagnation pressure or the
% isentropic local pressure using isentropic relation formulae.

% Takes inputs: stagTemp = stagnation pressure.  staticTemp = static
% pressure.  mach = Mach number.  speed = speed in m/s.
% Only one of the stagnation pressure and static pressure may be passed
% into the function, the other one should be passed as NaN, The same goes
% for mach and speed, only one of them may be passed into the function and
% the other should be set as NaN.

% /////////////////////////////////////////////////////////////////////////

% Input error checking
    % pressure checking
    if isnan(staticP) && isnan(stagP) 
        error('You need to include either static or stagnation pressure')
    end
    if (isnan(staticP)) == false && (isnan(stagP)) == false
        error('Only one of either staic pressure or stagnation pressure may be included in the function')
    end

    % Speed checking
    if isnan(speed) && isnan(mach) 
        error('You need to include either speed or mach nu,ber')
    end
    if (isnan(speed)) == false && (isnan(mach)) == false
        error('Only one of either speed or mach number may be included in the function')
    end
% /////////////////////////////////////////////////////////////////////////

% Finding or creating fluid properties
    %Fluid_Data = importdata(Fluid_Data); % Not implemented yet
    
    % Fluid Properties Override
    gamma = 1.4;
    R = 287;
% /////////////////////////////////////////////////////////////////////////
    
% pressure and speed separation
    knownTemperature = staticT;
    
    % Determines whether speed or mach nu,ber is known and uses the known
    % value
    if isnan(speed) % Checks if speed is undefined, if so, uses the mach number defined
        mach = mach;
    else
        mach = speed / sqrt(gamma*R*knownTemperature);
    end
% /////////////////////////////////////////////////////////////////////////

% pressure calculation
    % calculates either stagnation pressure or static pressure based
    % on inputs
    if isnan(stagP) % If the stagnation pressure input is not defined (NaN)
        stagP = staticP * (1 + (((gamma - 1)/2)* mach ^ 2))^(gamma/(gamma-1));
        staticP = staticP;
    else
        staticP = stagP / (1 + (((gamma - 1)/2)* mach ^ 2))^(gamma/(gamma-1));
        stagP = stagP;
    end
% /////////////////////////////////////////////////////////////////////////