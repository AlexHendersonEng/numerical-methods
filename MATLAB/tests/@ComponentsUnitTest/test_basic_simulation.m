%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% test_basic_simulation method for testing a basic simulation of a first
% order transfer function and gain simulation against the analytical
% solution 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function test_basic_simulation(test_case)
%
%   Analytical solution
%
    t = (0 : 0.01 : 10)';
    y = 2 * (1 - exp(-t));
%
%   Run simulation
%
    solver = RK4(t(1), 0.01);
    blocks = {Input(ones(size(t)), t), ...
              TF1(0, 1), ...
              Gain(2), ...
              L1(y, t)};
    connections = [1, 1, 2, 1;
                   2, 1, 3, 1;
                   3, 1, 4, 1];
    sim = Simulation(blocks, connections, solver, numel(t));
    for step = 1 : numel(t) - 1
        sim.step();
        solver.update();
    end
    sim.terminate();
%
%   Verify results
%
    test_case.verifyEqual(mean([blocks{end}.logger.output.value]), 0, ...
                          'AbsTol', 1e-2);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% End
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%