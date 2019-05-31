% getWeightsFromLHS.m

% Script to calculate weights for fitness functions from the lhsresults.dat
% file.
% Current method is to take top 20 points in the population for each
% fitness function, then take 1 over the mean score of those points.

% First, load metaparameters:
metafile = tdfread( '../../output/metaparams.dat' , ':' , 1 ) ;
metaparams = metafile.paramvalue ;

NP = metaparams( 2 ) ;
NFFS = metaparams( 4 ) ;

% Second, load lhsresults.dat
lhs_file = '../../output/lhsresults.dat' ;
lhs = dlmread( lhs_file ) ;
PAF = [ lhs( : , 3 : end ) lhs( : , 2 ) ] ;

% split PAF into P(arameters) and F(itness functions)
params = PAF( : , 1 : NP ) ;
ffs = PAF( : , NP + 1 : NP + NFFS ) ;

% Find the non-firing traces by looking for the most frequently occurring
% FF values for the final 

ffsSpikes = find( ffs( : , end ) ~= mode( ffs( : , end ) ) ) ;
ffsFull = ffs ;
ffs = ffs( ffsSpikes , : ) ;

% Now get the weights according to the method:
    % Sort each fitness function independently
    % Take the top 5%
    % Take the mean of those
    % 1 / mean is the weight
ffsSorted = sort( ffs ) ;
ffsTop20 = ffsSorted( 1 : 115 , : ) ;
ffsTop20means = mean( ffsTop20 ) ;
weights = 1 ./ ffsTop20means ;
weights( weights == Inf ) = 1 ;

% Finally write the weights out to a file
dlmwrite( '../../setup/ffweights.dat' , weights' ) ;

exit
