%==========================================================================
% File      : POCRandomForest.m
% Project   : Math Challange
% Detail    : RandomForest algorithm 
% Autor     : Ashwin Bardhwaj
% 
% @Copyright reserved @2021  
%==========================================================================
% Mdl = TreeBagger(200,allFactorDataTable,'Number of Accidents','Method','regression','Surrogate','on',...
%     'PredictorSelection','curvature','OOBPredictorImportance','on');

allFactorDataTable = readtable(RandomForestInputTableFilename);
allFactorDataTable(:,1) = [];
% [m,n] = size(allFactorDataTable) ;
% P = 0.70 ;
% idx = randperm(m)  ;
% Training = allFactorDataTable(idx(1:round(P*m)),:) ; 
% Testing = allFactorDataTable(idx(round(P*m)+1:end),:) ;

% Ignore first column(unique zipcodes)

Mdl = fitrtree(allFactorDataTable,'x_Accidents','PredictorSelection','curvature','Surrogate','on');

% %    'OOBPredictorImportance','on');
% predX = linspace(min(Factor1),max(Factor1),10)';
% numAccMean = predict(Mdl,predX);
% numAccQuartiles = quantilePredict(Mdl,predX,'Quantile',[0.25,0.5,0.75]);
% figure;
% plot(Factor1,carAccNum,'o');
% hold on
% plot(predX,numAccMean);
% plot(predX,numAccQuartiles);
% ylabel('Number of Car Accidents In Cluster');
% xlabel('Visibility Level');
% legend('Data','Mean Response','First quartile','Median','Third quartile');
imp = predictorImportance(Mdl);

figure;
bar(imp);
title('Predictor Importance Estimates');
ylabel('Estimates');
xlabel('Predictors');
h = gca;
h.XTickLabel = Mdl.PredictorNames;
h.XTickLabelRotation = 45;
h.TickLabelInterpreter = 'none';