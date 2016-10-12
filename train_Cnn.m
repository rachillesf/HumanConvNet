function train_CharCnn(varargin)
% EXERCISE4   Part 4 of the VGG CNN practical

setup ;

% -------------------------------------------------------------------------
% Part 4.1: prepare the data
% -------------------------------------------------------------------------

% Load character dataset
imdb = load('data/peopledb.mat') ;

% Visualize some of the data

% -------------------------------------------------------------------------
% Part 4.2: initialize a CNN architecture
% -------------------------------------------------------------------------

net = initializeCharacterCNN() ;

% -------------------------------------------------------------------------
% Part 4.3: train and evaluate the CNN
% -------------------------------------------------------------------------

trainOpts.batchSize = 124 ;
trainOpts.numEpochs = 12;
trainOpts.continue = true ;
trainOpts.useGpu = false ;
trainOpts.learningRate = 0.00001 ;
trainOpts.expDir = 'data/chars-experiment' ;
trainOpts = vl_argparse(trainOpts, varargin);

% Take the average image out
imdb = load('data/peopledb.mat') ;
imageMean = mean(imdb.images.data(:)) ;
imdb.images.data = imdb.images.data - imageMean ;


% Call training function in MatConvNet
[net,info] = cnn_train(net, imdb, @getBatch, trainOpts) ;

% Save the result for later use
net.layers(end) = [] ;
net.imageMean = imageMean ;
save('data/chars-experiment/charscnn.mat', '-struct', 'net') ;

% -------------------------------------------------------------------------
% Part 4.4: visualize the learned filters
% -------------------------------------------------------------------------

figure(2) ; clf ; colormap gray ;
vl_imarraysc(squeeze(net.layers{1}.filters),'spacing',2)
axis equal ; title('filters in the first layer') ;




% --------------------------------------------------------------------
function [im, labels] = getBatch(imdb, batch)
% --------------------------------------------------------------------
im = imdb.images.data(:,:,batch) ;
im = 256 * reshape(im, 32, 32, 1, []) ;
labels = imdb.images.label(1,batch) ;




