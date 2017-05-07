load feature
load label

feature2 = feature(:,1:19);

feature1 = bsxfun(@minus,feature2,mean(feature2));
newfeature = bsxfun(@rdivide,feature1,std(feature1));

xdata = newfeature;
group = label;

p = 0.1;
[Train, Test] = crossvalind('HoldOut',group,p);

TrainingSample = xdata(Train,:);
TrainingLabel = group(Train,1);
TestingSample = xdata(Test,:);
TestingLabel = group(Test,1);

labelNum = 32;

DM=zeros(labelNum,size(TestingLabel,1));
for i=1:labelNum
    for j=i+1:labelNum
        indexij=(TrainingLabel==i)|(TrainingLabel==j);
        TrainingSampleij=TrainingSample(indexij,:);
        TrainingLabelij=TrainingLabel(indexij,:);

        svmStruct = svmtrain(TrainingSampleij,TrainingLabelij,...
          'showplot',0,'kernel_function','rbf','rbf_sigma',...
            7,'boxConstrain',2^7);

        outLabel = svmclassify(svmStruct,TestingSample,'showplot',0);
        
        rowIndex=outLabel;
        colIndex=(1:1:size(TestingLabel,1))';
       
        linearInd=sub2ind([labelNum size(TestingLabel,1)],rowIndex,colIndex);
        DM(linearInd)=DM(linearInd)+1;
    end
end

[~,outLabel]=max(DM);
acc=mean(grp2idx(outLabel)==grp2idx(TestingLabel));