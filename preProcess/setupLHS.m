% Set up Latin Hypercube Sampling method for parameter space
% Using 80 parameter combinations per parameter - probably need an argument for 
% this in the long run - set in the initial parameters here, as nPerPeram
% p is the number of parameters, set from parameters.dat file loading

nPerParam = 100 ;

rs = tdfread( '../../setup/parameters.dat' ) ;
% original min's and max's
ranges = [ rs.min , rs.max ] ;

p = length(rs.parameters) ;
n = p * nPerParam ;

% Load the LHSdesign for the required n and p:

des = lhsdesign(n, p, 'criterion', 'maximin', 'iteration', 10000);

% scale the MmLHS to the original input scale

desOrig = zeros(n, p);
for j = 1:p
    maxs = ranges(j, 2);
    mins = ranges(j, 1);
    for i = 1:n
        desOrig(i, j) = (maxs - mins)*des(i, j) + mins;
    end
end

% save the data to the curr_population file
% start by adding population size - n \tab p
dlmwrite( '../../output/curr_population' , [ n p ] , '\t' ) ;
% then append the desOrig, which is the set of parameters
dlmwrite( '../../output/curr_population' , desOrig , 'delimiter' , '\t' , '-append' ) ;
% then append a 1xn matrix of zeros, to be loaded into res vector in de_setup
dlmwrite( '../../output/curr_population' , zeros( n , 1 ) , 'delimiter' , '\t' , '-append' ) ;

%exit
