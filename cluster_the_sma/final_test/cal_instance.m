function [gra_UP,gra_DOWN]=cal_instance(Close,up_index,down_index,m,n)

% configuration: peaks.m SimpleMovingAverage.m graMA.m
up_index(up_index<=14)=[];
down_index(down_index<=14)=[];


[Short,Med,Long]=SimpleMovingAverage(Close,[5 10 14]);
[gra_S,gra_M,gra_L]=graMA(Short,Med,Long);

up_S=gra_S(up_index);
up_L=gra_L(up_index);
up_M=gra_M(up_index);
gra_UP=[up_S,up_M,up_L];

down_S=gra_S(down_index);
down_L=gra_L(down_index);
down_M=gra_M(down_index);
gra_DOWN=[down_S,down_M,down_L];

% reconstruct for instance and label. Save data
index =  [up_index,down_index];
index =  unique(sort(index));

train_data = [up_index',gra_UP;down_index',gra_DOWN];
train_data = sortrows(train_data);
for i=1:size(train_data,1)
    if( sum(train_data(i,1) == up_index) )
        train_data(i,1) = 1;
    else
        train_data(i,1) = -1;
    end
end
%% Note!!!!!!
% check it !!! the label!

filename=['data', '.mat'];
save(filename,'train_data');
txt('data.mat',m,n)