%% 
%%  RANSAC - RANdom SAmple Consensus
%%    
%%    1. Select randomly the minimum number of points required 
%%      to determine the model parameters.
%%    
%%    2: Solve for the parameters of the model.
%%    
%%    3: Determine how many points from the set of all points 
%%      fit with a predefined tolerance.
%%    
%%    4: If the fraction of the number of inliers over the total 
%%      number points in the set exceeds a predefined threshold 
%%      τ, re-estimate the model parameters using all the
%%      identified inliers and terminate.
%%    
%%    5: Otherwise, repeat steps 1 through 4 (maximum of N times).
%%

function [inliers] = ransac(data, options)
  best_indices = [];
  n_inliers = 0; % highest number of inliers found
  data_elems = size(data, 2); % number of data elements

  iter = 0;
  itermax = 100;
  while iter < itermax
    %% TODO: improve random selection in other to avoid 
    %%       selecting the same range more then once
    rand_indices = randperm(data_elems, options.nfit); 
    model = options.model(data(:, rand_indices));
    distances = options.distance(model, data);
    
    inliers = find(distances < options.threshold);
    
    if length(inliers) > n_inliers
      n_inliers = length(inliers);
      best_indices = inliers;
  
      rate = 1.0 - n_inliers / data_elems; % outlier proportion
      itermax = round(log(1.0 - 0.99) / log(1.0 - (1.0 - rate)^options.nfit));
    end

    iter = iter + 1;
  end

  inliers = data(:, best_indices);