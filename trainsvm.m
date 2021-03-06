% % load feature
% % load label
% % 
% % feature2 = feature(:,1:19);
% % 
% % feature1 = bsxfun(@minus,feature2,mean(feature2));
% % newfeature = bsxfun(@rdivide,feature1,std(feature1));
% % 
% % xdata = newfeature;
% % group = label;
% % 
% % p = 0.1;
% % [Train, Test] = crossvalind('HoldOut',group,p);
% % 
% % TrainingSample = xdata(Train,:);
% % TrainingLabel = group(Train,1);
% % TestingSample = xdata(Test,:);
% % TestingLabel = group(Test,1);

load trl1
load trs1
load tel1
load tes1

% TrainingSample = trs1;
% TrainingLabel = trl1;
% TestingSample = tes1;
% TestingLabel = tel1;

labelNum = 32;

% acc=[];
% for arg1 = 2.^(-10:1:10)
%     for arg2 = 2.^(-5:1:5)
DM=zeros(labelNum,size(TestingLabel,1));
for i=1:labelNum
    for j=i+1:labelNum
        indexij=(TrainingLabel==i)|(TrainingLabel==j);
        TrainingSampleij=TrainingSample(indexij,:);
        TrainingLabelij=TrainingLabel(indexij,:);
        
%         numFolds=5;
%         Indices = crossvalind('Kfold',TrainingLabelij,numFolds);

%         sigma=2.^(-10:1:10);
%         C=2.^(-5:1:5);
% 
%         [BestSigma,BeatC]=BestParametersRBF(TrainingSampleij,...
%            TrainingLabelij,sigma,C,Indices,numFolds);

%         svmStruct = svmtrain(TrainingSampleij,TrainingLabelij,...
%           'showplot',0,'kernel_function','rbf','rbf_sigma',...
%             BestSigma,'boxConstrain',BestC);

        svmStruct = svmtrain(TrainingSampleij,TrainingLabelij,...
          'showplot',0,'kernel_function','rbf','rbf_sigma',...
            6,'boxConstrain',2^8);

        outLabel = svmclassify(svmStruct,TestingSample,'showplot',0);
        
        rowIndex=outLabel;
        colIndex=(1:1:size(TestingLabel,1))';
       
        linearInd=sub2ind([labelNum size(TestingLabel,1)],rowIndex,colIndex);
        DM(linearInd)=DM(linearInd)+1;
    end
end

[~,outLabel]=max(DM);
acc=mean(grp2idx(outLabel)==grp2idx(TestingLabel));
%acc = [acc;[arg1,arg2,mean(grp2idx(outLabel)==grp2idx(TestingLabel))]];

% numFolds=5;
% Indices = crossvalind('Kfold',TrainingLabel,numFolds);
% 
% sigma=2.^(-10:1:10);
% C=2.^(-5:1:5);
% 
% [BestSigma,BeatC]=BestParametersRBF(TrainingSample,...
%     TrainingLabel,sigma,C,Indices,numFolds);

%%results = multisvm(TrainingSample,TrainingLabel,TestingSample);
% disp('multi class problem'); 
% disp(results);
% svmStruct = svmtrain(TrainingSample,TrainingLabel,...
%     'showplot',true,'kernel_function','rbf','rbf_sigma',0.1);

% outLabel = svmClassify(svmStruct,TestingSample,'showplot',true);
% acurracy = sum(outLabel==TestingLabel)/sum(Test);

