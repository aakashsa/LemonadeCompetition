function [ scores ] = compute_scores( positions )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Computation of the points of each lemonade stand                       %
% given the positions of the 3 stands.                                    %
% INPUT:                                                                  %
%  - positions is a 1x3 row-vector with the 3 positions of the players    %
% OUTPUT:                                                                 %
%  - scores/points of each lemonade stand                                 %
%                                                                         %
% Author: Danai Koutra                                                    %
% Date: Monday, Nov. 5                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% number of people per stand
people = 2;
% initialization of scores
scores = zeros(3,1);

[ pos_sorted idx ] = sort(positions, 'ascend');

if pos_sorted(1) == pos_sorted(2) && pos_sorted(2) == pos_sorted(3)
    scores(idx(1)) = 12*people / 3;
    scores(idx(2)) = scores(idx(1));
    scores(idx(3)) = scores(idx(2));
elseif pos_sorted(1) == pos_sorted(2)
    scores(idx(1)) = 1 + ( splitClockwise(pos_sorted(1), pos_sorted(3), people) + ...
                     splitCounterClockwise(pos_sorted(3), pos_sorted(1), people) ) / 2;
    scores(idx(2)) = scores(idx(1));
    scores(idx(3)) = 2 + splitClockwise(pos_sorted(1), pos_sorted(3), people) + ...
                     splitCounterClockwise(pos_sorted(3), pos_sorted(1), people);
elseif pos_sorted(2) == pos_sorted(3)
    scores(idx(1)) = 2 + splitClockwise(pos_sorted(1), pos_sorted(3), people) + ...
                     splitCounterClockwise(pos_sorted(3), pos_sorted(1), people);
    scores(idx(2)) = 1 + ( splitClockwise(pos_sorted(2), pos_sorted(3), people) + ...
                     splitCounterClockwise(pos_sorted(3), pos_sorted(2), people) ) / 2;
    scores(idx(3)) = scores(idx(2));
else
    % all positions are different
    scores(idx(1)) = 2 + splitClockwise(pos_sorted(1), pos_sorted(2), people) + ...
                     splitCounterClockwise(pos_sorted(3), pos_sorted(1), people);
    scores(idx(2)) = 2 + splitClockwise(pos_sorted(1), pos_sorted(2), people) + ...
                     splitClockwise(pos_sorted(2), pos_sorted(3), people);
    scores(idx(3)) = 2 + splitClockwise(pos_sorted(2), pos_sorted(3), people) + ...
                     splitCounterClockwise(pos_sorted(3), pos_sorted(1), people);
end
    
    %% Auxiliary functions

    % splitting people among neighboring stands (clockwise)
    function [ peopleHalf ] = splitClockwise( neighbor1, neighbor2, people )    
       peopleHalf = ( neighbor2 - neighbor1 - 1 ) / 2 * people; 
    end


    % splitting people among neighboring stands (counter clockwise)
    function [ peopleHalf ] = splitCounterClockwise( neighbor1, neighbor2, people )    
       peopleHalf = (12 - ( abs(neighbor2 - neighbor1) - 1 ) - 2 ) / 2 * people; 
    end

end