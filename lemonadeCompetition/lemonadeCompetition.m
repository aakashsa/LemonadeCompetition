function [ final_scores ] = lemonadeCompetition( rounds, andrewID )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Testing an agent against two adversaries with predefined positions.    %
%                                                                         %
% *NOTE*: Make sure that the files 'adversary1.txt' and 'adversary2.txt'  %
%         have at least as many lines as the value of the variable        %
%         'rounds', and that each line has 1 integer in [1,12]. See       %
%         the sample files.                                               %
% *TO RUN*: scores = lemonadeCompetition( 7,'yourAndrewID')               %
%                                                                         %
% INPUTS: rounds -> number of days on the island (rounds of competition)  %
%         andrewID -> the name of the folder that contains the LEMONADE   %
%                     directory. Currently it is named 'yourAndrewID'.    %
% OUTPUT: final_scores -> the number of points that you and your          %
%                         adversaries have at the end of the competition. %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

history = zeros(rounds+1, 3);
scores = zeros(rounds+1, 3);
cum_scores = zeros(rounds+1, 3);
final_scores = zeros(1, 3);

%% Feedback messages
outOfRange = 'The position you gave is out of range.';
fileDoesNotExist = 'The file position.txt does not exist.';
won = 'You beat both adversaries. Good job!';
wonOnly1 = 'You beat only one of the adversaries.';
lost = 'You lost. Maybe think of another strategy?';

%% Commands to be executed at each round
exec_comm = sprintf('cd %s/HW5/LEMONADE; bash PickMyLemonadeSpot.sh; cd ../../..', andrewID);
cp_comm = sprintf('cp previous.txt %s/HW5/LEMONADE/', andrewID);

%% Loading the positions of the adversaries
load 'adversary1.txt'
positionAdv1 = adversary1;
%%load 'adversary2.txt'
%%positionAdv2 = adversary2;
clear adversary1 %%adversary2

%% Actual Lemonade Competition
for i = 1 : rounds
   toOutput = [ history(1:i,:), scores(1:i,:), cum_scores(1:i,:) ];
   fid_previous = fopen('previous.txt','w');
   fprintf(fid_previous, 'Round %d\n', i-1);
   fprintf(fid_previous, '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n', toOutput');
   fclose(fid_previous);
   system(cp_comm);
   system(exec_comm);
   positionPath = sprintf('%s/HW5/LEMONADE/position.txt', andrewID);
   adv2Path = sprintf('%s/HW5/LEMONADE/adv2pos.txt', andrewID);
   if ~exist(positionPath, 'file')
       fileDoesNotExist
       return;
   end
   load(positionPath)
   if position < 1 || position > 12
       outOfRange
       return;
   end
   if ~exist(adv2Path, 'file')
       fileDoesNotExist
       return;
   end
   load(adv2Path)
   if adv2pos < 1 || adv2pos > 12
       outOfRange
       return;
   end
   history(i+1,:) = [position, positionAdv1(i),adv2pos];
   scores(i+1,:) = compute_scores(history(i+1,:));
   cum_scores(i+1,:) = cum_scores(i,:) + scores(i+1,:);
end
    
   toOutput = [ history(1:rounds+1,:), scores(1:rounds+1,:), cum_scores(1:rounds+1,:) ];
   fid_previous = fopen('previous.txt','w');
   fprintf(fid_previous, 'Round %d\n', rounds);
   fprintf(fid_previous, '%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n', toOutput');
   fclose(fid_previous);

%% checking if the agent won the adversaries
final_scores = cum_scores(rounds+1,:)
if final_scores(1) > final_scores(2) && final_scores(1) > final_scores(3)
    won
elseif final_scores(1) > final_scores(2) || final_scores(1) > final_scores(3)
    wonOnly1
else
    lost
end

end
