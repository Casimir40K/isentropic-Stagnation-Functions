function [stagTemp,staticTemp] = IsentropicTemp(stagTemp,staticTemp,mach,speed)
% IsentropicTemp: finds either the isentropic stagnation temperature or the
% isentropic local temperature using isentropic relation formulae.

% Takes inputs: stagTemp = stagnation temperature.  staticTemp = static
% temperature.  mach = Mach number.  speed = speed in m/s.
% Only one of the stagnation temperature and static pressure may be passed
% into the function, the other one should be passed as NaN, The same goes
% for mach and speed, only one of them may be passed into the function and
% the other should be set as NaN.

% /////////////////////////////////////////////////////////////////////////

% Input error checking
    % Temperature checking
    if isnan(staticTemp) && isnan(stagTemp) 
        error('You need to include either static or stagnation temperature')
    end
    if (isnan(staticTemp)) == false && (isnan(stagTemp)) == false
        error('Only one of either staic temperature or stagnation temperature may be included in the function')
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
    
% Temperature and speed separation
    % Determines whether static or stagnation temperature is known, and uses
    % the known value
    if isnan(stagTemp)
        knownTemperature = staticTemp;
    else
        knownTemperature = stagTemp;
    end
    
    % Determines whether speed or mach nu,ber is known and uses the known
    % value
    if isnan(speed) % Checks if speed is undefined, if so, uses the mach number defined
        mach = mach;
    else
        mach = speed / sqrt(gamma*R*knownTemperature);
    end
% /////////////////////////////////////////////////////////////////////////

% Temperature calculation
    % calculates either stagnation temperature or static temperature based
    % on inputs
    if isnan(stagTemp) % If the stagnation pressure input is not defined (NaN)
        stagTemp = staticTemp * (1 + (((gamma - 1)/2)* mach ^ 2));
        staticTemp = staticTemp;
    else
        staticTemp = stagTemp / (1 + (((gamma - 1)/2)* mach ^ 2));
        stagTemp = stagTemp;
    end
% /////////////////////////////////////////////////////////////////////////