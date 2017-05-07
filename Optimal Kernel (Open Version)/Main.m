clear
clc
close all
warning off all

load IPS_16class.mat

%   xtAll.data means all samples in the image.
%   xtAll.label means the ground truth of the image.
maxValue=max(max(Sample));
in=SampleLabel==0;
xtAll.data=Sample(~in,:)/maxValue;
xtAll.label=SampleLabel(~in,:);

%   Choose TP percent of data as training sample
TP=0.1;

%   x is the structure of the training sample.
%   xt is the structure of the testing sample.
[Train, Test] = crossvalind('HoldOut',xtAll.label,1-TP);
x.data=xtAll.data(Train,:);
x.label=xtAll.label(Train,:);
xt.data=xtAll.data(Test,:);
xt.label=xtAll.label(Test,:);
    
%%
%   Plot the curve of J v.s. sigma 
%   If you are no need to plot, please comment this part.
sigma=0.1:0.1:10;
for i=1:length(sigma)
    J(i)=SeparabilityBasedOnRBF(x,sigma(i));
end
plot(sigma,J)
xlabel('\sigma');
ylabel('J(\sigma)');
title('\sigma vs. J(\sigma)');
pause(3)
%%
    
%   The range of C
C=2.^(-10:1:10);
%   Use k-fold cross validation to find the best C.
k=5;
indices=crossvalind('Kfold',x.label,k);
    
%%  Optimal Process
%   We use the mean of the distances between samples as the initial value.
initialSigma=mean(pdist(x.data));
%   We use the large-scale algorithm which is based on the 
%   interior-reflective Newton method to find the optimizer. 
options=optimset('fminunc');
options.Display='off';

f=@(sigma)SeparabilityBasedOnRBF(x,sigma);
initialTime=cputime;
[OpSigma,OJ]=fminunc(f,initialSigma,options);
[OpSigma,OpC,accFold]=GridParameters_SVM(x,OpSigma,C,indices,k,0);
TimeOp=cputime-initialTime;

%   Classify the training samples
[x,x]=MultiClassSVM1vsALL(x,x,OpSigma,OpC,1);
accTrain=x.acc
kappaAccTrain=x.kappa
    
%   Classify the testing samples
[x,xt]=MultiClassSVM1vsALL(x,xt,OpSigma,OpC,1);
accTest=xt.acc
kappaAccTest=xt.kappa

%   Classify the all samples in the image
[x,xtAll]=MultiClassSVM1vsALL(x,xtAll,OpSigma,OpC,1);
accAll=xtAll.acc
kappaAccAll=xtAll.kappa