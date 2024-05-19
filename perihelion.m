% PERIHELION  Mercury's perihelion precession and general relativity
%
% In this lab assignment, a student completes a MATLAB program to test with
% data an accurate prediction of Einstein’s theory, namely the perihelion
% precession of Mercury. Mercury’s orbit around the Sun is not a stationary
% ellipse, as Newton’s theory predicts when there are no other bodies. With
% Einstein’s theory, the relative angle of Mercury’s perihelion (position
% nearest the Sun) varies by about 575.31 arcseconds per century.

%{
    Copyright (c) 2021, University of Alberta
    Electrical and Computer Engineering
    All rights reserved.

    Student name: Rishi Bhatnagar
    Student CCID: 1705587
    Others: {Matlab website-5%}

    To avoid plagiarism, list the names of persons, other than a lecture
    instructor, whose code, words, ideas, or data you used. To avoid
    cheating, list the names of persons, other than a lab instructor or
    teaching assistant (TA), who provided compositional assistance.

    After each name, including the student's, enter in parentheses an
    estimate of the person's contributions in percent. Without these
    numbers, adding to 100%, follow-up questions may be asked.

    For anonymous sources, enter code names in uppercase, e.g., SAURON,
    followed by percentages as above. Email a link to or a copy of the
    source to the lab instructor before the assignment is due.
%}
clear
close all
data = loaddata('horizons_results');
if isempty(data)
    error('File open failure')
end
data = locate(data,0.1); % All perihelia
data = select(data,25,{'Jan','Feb','Mar'});
makeplot(data,'horizons_results')

function data = loaddata(filename)
disp(filename) %Displays filename on command window
filename = strcat(filename,'.txt'); %It adds '.txt' to the filename
fid = fopen(filename,'rt'); %To open the file in reading mode
if fid ~= -1 % Executes if the file exists
    line = ''; % Assigning a variable which would later be lines of the file
    while ~feof(fid) && ~strcmp(line,'$$SOE') 
        % Runs if not at the end of the program until the line is not
        % '$$SOE'

        line = fgetl(fid); %line variable gets the next line from the file( saved as fid)

    end %Terminates the if statement

    data = cell(1000,3); % Preallocates a cell array

    num = 0; %assigning number to a variable

    while ~feof(fid) %Runs until all the lines in the programs are iterated though or the break statement is executed

        line = fgetl(fid); %Gets the next line of the file

        if strcmp(line,'$$EOE') % Sentinel

            break % while loop is broken completely

        end %Terminating if statement

        num = num+1; %Increasing num variable by 1 

        if size(data,1) < num %Executes this if num is greater than number of rows of data in cell array

            disp(size(data,1)) %Displays the number of rows on command window
            data{2*end,1} = []; % Allocating twice the current number of rows in the data{CHECK IT LATER}

        end %Terminates if statement

        data(num,:) = str2cell(line); %Assigns value to the row of the cell for that nummber(num)

    end %Terminates the while statement

    data = data(1:num,:); % Truncate the cell array (WHAT DOES IT ACTUALLY DO=???)

    fclose(fid); %Closes the file

    disp(num) %Displays the num on command window

else %Executes if the 'if' statement doesn't execute

    data = {}; % File open failure

end %Terminates if statement

end %Terminates the function






function cellrow = str2cell(linestr)

[numeric_date,rest1]=strtok(linestr,','); %Splits it based based on comma

numeric_date=str2double(numeric_date);

[~,rest3]=strtok(rest1,'1');%Removes 'A.D.'

[string_date,rest5]=strtok(rest3,' ');

string_date=strtrim(string_date); 
rest5=strtrim(rest5);

z=split(rest5,',');%Splits the remaining string based on commma and gives a 5x1 cell array as an output

x_coordinate=str2double(z{2});%Takes the second row from the cell z and converts it into string

y_coordinate=str2double(z{3});%Takes the third row from the cell z and converts it into string

z_coordinate=str2double(z{4});%Takes the fourth row from the cell z and converts it into string

cellrow = {numeric_date,string_date,[x_coordinate y_coordinate z_coordinate]}; %Creates a cell array(1x3) for these quantities

end %Terminates function statement





function data = locate(data,thresh)
coord = cell2mat(data(:,3));
vnorm = sqrt(sum(coord.*coord,2));
maxval = max(vnorm); % Global aphelion
minval = min(vnorm); % Global perihelion
refval = minval+(maxval-minval)*thresh;
zcross = diff(vnorm < refval);
jlb = find(zcross == 1)+1; % Lower bound
jub = find(zcross == -1); % Upper bound
num = min(numel(jlb),numel(jub));
i = zeros(num,1);
for k = 1:num
    [~,index] = min(vnorm(jlb(k):jub(k)));
    i(k) = jlb(k)+(index-1); % Perihelion
end
data = data(i,:);
end

function data = select(data,~,~)
data = data(1:100:end,:);
end

function makeplot(data,filename)
[numdate,strdate,precess] = arcsec(data);
p = polyfit(numdate,precess,1);
bestfit = polyval(p,numdate);
plot(numdate,precess,'bo',numdate,bestfit,'b-')
annotate(numdate,strdate,36525*p(1))
print('-dtiff',filename)
end

function [numdate,strdate,precess] = arcsec(data)
numdate = cell2mat(data(:,1));
strdate = char(data{:,2});
num = size(data,1);
precess = zeros(num,1);
v = data{1,3}; % Reference position (2D/3D)
for i = 1:num
    u = data{i,3}; % Perihelion position (2D/3D)
    precess(i) = acosd((u*v')/sqrt((u*u')*(v*v')));
end
precess = 3600*precess; % arcsec
end

function annotate(numdate,strdate,slope)
xticks(numdate)
xticklabels(strdate)
xtickangle(45) % (deg)
xlabel('Perihelion Date')
ylabel('Precession (arcsec)')
legend('Actual data','Best fit line','Location','SE')
line2 = sprintf(' %.2f arcsec/cent',slope);
label = {' Slope of best fit line:'; line2};
axis tight % Adjust plot limits to data extrema
text(min(xlim),max(ylim),label,'VerticalAlignment','top')
end
