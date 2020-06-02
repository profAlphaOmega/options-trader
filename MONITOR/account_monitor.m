function [] = account_monitor()

% Query information and store in temp var
[data,ibConnectionObject] = IBMatlab('action','account','AccountName','DU205260','ClientID',2666,'Port',4001);

data.ibConnectionObject = ibConnectionObject; % append IBConnector Object
data.pull_time = ibConnectionObject.twsConnectionTime; % create pull time field


data_length = size(fieldnames(data),1);

% load('C:\Users\Zato\Desktop\Master\AMMO\~mat\account_monitor.mat','account_runs') % load account repository
% 
% account_runs = insertrows(account_runs,data); % Append current data to historical
% 
% save('C:\Users\Zato\Desktop\Master\AMMO\~mat\account_monitor.mat','account_runs'); % save file down


fprintf('\n\nSUCCESS: Account data pull... \n\n');

fprintf('size of array = %.f  \n\n',data_length);
fprintf('%s \n\n',data.pull_time);

sendmail('ammodono@gmail.com', 'AMMO: Account Query',['Account run successful:' 10 10 'there were ' num2str(data_length) ' fields in the array']); % Send out email
fprintf('SUCCESS: Email delivery \n\n');

ibConnectionObject.disconnectFromTWS; % disconnect from TWS
fprintf('IB Gateway disconnected... \n\n');

pause(30);

fprintf('exit \n\n');

pause(1);
exit

end

