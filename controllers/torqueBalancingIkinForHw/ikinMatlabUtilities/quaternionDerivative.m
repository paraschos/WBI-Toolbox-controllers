function dQ = quaternionDerivative(q, omega, k)
% CodeGen
    dQ = 1/2 * [0       -omega'; ...
                omega   -Sf(omega)] * q + k * (1 - q' * q) * q;
end
