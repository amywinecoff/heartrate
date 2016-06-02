function ExtractTrialEstimatesAnger (subj)
%subj=105;
input_dir = ('~/Dropbox/ACL_Experiments/BridgetSPROJ');
txt_subj = num2str(subj);
data=dlmread ((strcat(input_dir, '/', txt_subj, '.AngerInd.txt')), '\t', 11, 0);



%raw_ecg=data(:,1);
trial_times = find(data(:,4)==5);

trial_count=0;
trial_id=zeros((length(trial_times)),3);
for trial_pulses = 1:length(trial_times)
    index = trial_times(trial_pulses);
    if (data(index-1,4) -data(index,4)) == -5 %find if it was the start of a new sentence or not
        trial_count = trial_count +1;
    end
    
    
    trial_id(trial_pulses,1) = data(trial_times(trial_pulses),1); %time
    trial_id(trial_pulses,2) = trial_count; %sentence number
    trial_id(trial_pulses,3) = data(trial_times(trial_pulses),2); %mV ECG
    trial_id(trial_pulses,4) = data(trial_times(trial_pulses),3); % BPM
  
    
end



trial_BPM = zeros(50,2);
for trials = 1:50
    mat_index = find (trial_id(:,2)==trials);
    trial_BPM(trials,1)=trials;
    trial_BPM(trials,2) = mean(trial_id(mat_index,4));
end

out_dir = [input_dir '/MeanBPM'];
cd (out_dir)
fname=[txt_subj '_meanBPM.txt'];

dlmwrite (fname, trial_BPM, '\t');
cd (input_dir)



