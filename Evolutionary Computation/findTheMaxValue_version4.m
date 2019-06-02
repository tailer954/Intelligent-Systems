clear;clc;

% x = [-10:0.01:10];    fx = -15*power(sin(2*x),2)-power((x-2),2)+160;
% plot(x,fx); title('-15sin(2x)^2-(x-2)^2+160'); xlabel('domain'); ylabel('f(x)');                    %�Q��plot�j�P�e�X���D�ؤ��ϧ�                  
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---generate initial generation---%
internal = 20/1023;     x = -10:internal:10;                                                         %�D�سW�w��10bits

B_initialGeneration_decimal = randi(1023,1,10);                                                      %���X��l�@�N(�Q�i��)    B��binary code
B_initialGeneration_decode = x(B_initialGeneration_decimal);                                         %���X��l�@�N(�ѽX��)    B��binary code
B_initialGeneration_binary = dec2bin(B_initialGeneration_decimal);                                   %���X��l�@�N(�G�i��)    B��binary code
B_fitnessValue = findFitness(B_initialGeneration_decode);                                            %�Q�Φۤw�g��function��X�A����

for i=1:10
    R_initialGeneration_decode(i) = -10+(10-(-10))*rand(1,1);                                        %���X��l�@�N(�ѽX��)
end
R_fitnessValue = findFitness(R_initialGeneration_decode);                                            %��X�A���ȡAR�����

for i=1:10
    EA_initialGeneration_decode(i) = -10+(10-(-10))*rand(1,1);                                       %���X��l�@�N(�ѽX��)�AEA���t�ƭp��k
end
EA_fitnessValue = findFitness(EA_initialGeneration_decode);                                          %��X�A����  EA���t�ƭp��k
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---reproduction(initial generation)---%
B_percentage = wheel_percent(B_fitnessValue);       %�Q�Φۤw�g��function�A�o����L�k��o�쪺��v(B)
R_percentage = wheel_percent(R_fitnessValue);       %�Q�Φۤw�g��function���L�k��o�쪺��v(R)
EA_percentage = wheel_percent(EA_fitnessValue);     %�Q�Φۤw�g��function���L�k��o�쪺��v(EA)

B_wheelGeneration_decode = rouletteWheelSelection(B_initialGeneration_decode,B_percentage);      %�Q�Φۤw�g��function�ѥX�g�L���L�k��o�쪺��(�Q�i��)(B)
B_tournamentGeneration_decode = tournamentSelection(B_initialGeneration_decode,2);               %�Q�Φۤw�g��function�ѥX�g�L�v���k��o�쪺��(�Q�i��)(B)

R_wheelGeneration_decode = rouletteWheelSelection(R_initialGeneration_decode,R_percentage);      %�Q�Φۤw�g��function�ѥX�g�L���L�k��o�쪺��(R)
R_tournamentGeneration_decode = tournamentSelection(R_initialGeneration_decode,2);               %�Q�Φۤw�g��function�ѥX�g�L�v���k��o�쪺��(R)

EA_wheelGeneration_decode = rouletteWheelSelection(EA_initialGeneration_decode,EA_percentage);   %�Q�Φۤw�g��function�ѥX�g�L���L�k��o�쪺��(EA)
EA_tournamentGeneration_decode = tournamentSelection(EA_initialGeneration_decode,2);             %�Q�Φۤw�g��function�ѥX�g�L�v���k��o�쪺��(EA)
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---�i�J�@�N������j�餤---%
n = 1;
while n<401                                                                    %n���H�����w���@�N�ơA�S���ƻ�N�q�A�ھڼ������G�վ�Y�i
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---crossover---%
    b = randperm(10);                                                          %�M�w��t�ü�
    r = randperm(10);                                                          %�M�w��t�ü�
    ea = randperm(10);                                                         %�M�w��t�ü�
    
    B_wheelGeneration_decimal = binaryValue_encode(B_wheelGeneration_decode,x);
    B_tournamentGeneration_decimal = binaryValue_encode(B_tournamentGeneration_decode,x);
    
    B_wheel_parent = dec2bin(B_wheelGeneration_decimal(b(1:10)));              %�M�wB���n��t���H�f(���L�k)
    B_tournament_parent = dec2bin(B_tournamentGeneration_decimal(b(1:10)));    %�M�wB���n��t���H�f(�v���k)
    R_wheel_parent = R_wheelGeneration_decode(r(1:8));                         %�M�wR�n��t���H�f(���L�k)
    R_tournament_parent = R_tournamentGeneration_decode(r(1:8));               %�M�wR�n��t���H�f(�v���k)
    EA_wheel_parent = EA_wheelGeneration_decode(ea(1:8));                      %�M�wEA�n��t���H�f(���L�k)
    EA_tournament_parent = EA_tournamentGeneration_decode(ea(1:8));            %�M�wEA�n��t���H�f(�v���k)

    B_wheel_generation = binaryValue_crossover(B_wheel_parent);                %�Q�Φۤw�g��function����B����t(���L�k)
    B_tournament_generation = binaryValue_crossover(B_tournament_parent);      %�Q�Φۤw�g��function����B����t(�v���k)
    R_wheel_generation = realValue_crossover(R_wheel_parent);                  %�Q�Φۤw�g��function����R����t(���L�k)
    R_tournament_generation = realValue_crossover(R_tournament_parent);        %�Q�Φۤw�g��function����R����t(�v���k)
    EA_wheel_generation = evoAlgorithm_crossover(EA_wheel_parent);             %�Q�Φۤw�g��function����EA����t(���L�k)
    EA_tournament_generation = evoAlgorithm_crossover(EA_tournament_parent);   %�Q�Φۤw�g��function����EA����t(�v���k)

    R_wheel_generation(9:10) = R_wheelGeneration_decode(r(9:10));              %��B������tfunction�Φ��MREA�������@�ˡA�G���ݬ����N�S���i���t���H�f�[�^�ڸs��
    R_tournament_generation(9:10) = R_tournamentGeneration_decode(r(9:10));
    EA_wheel_generation(9:10) = EA_wheelGeneration_decode(ea(9:10));
    EA_tournament_generation(9:10) = EA_tournamentGeneration_decode(ea(9:10));  %����|��{���X���G�N�S���i���t���H�f�[�^�ڸs��
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---mutation---%
    if mod(n,10) == 0
        R_wheel_generation = R_mutation(R_wheel_generation);                    %�Q�Τw�g��function�o�XR�������ܵ��G(���L�k)
        R_tournament_generation = R_mutation(R_tournament_generation);          %�Q�Τw�g��function�o�XR�������ܵ��G(�v���k)           
        EA_wheel_generation = EA_mutation(EA_wheel_generation);                 %�Q�Τw�g��function�o�XEA�������ܵ��G(���L�k)
        EA_tournament_generation = EA_mutation(EA_tournament_generation);       %�Q�Τw�g��function�o�XEA�������ܵ��G(�v���k)
    end  
    
    B_wheelmutation_rand = randi(length(B_wheel_generation(:)),1,1);
    B_wheel_generation(B_wheelmutation_rand) = num2str(xor(str2double(B_wheel_generation(B_wheelmutation_rand)),1));            %B�������ܵ��G(���L�k)�Axor��1��0�A0��1
    B_tourmutation_rand = randi(length(B_tournament_generation(:)),1,1);
    B_tournament_generation(B_tourmutation_rand) = num2str(xor(str2double(B_tournament_generation(B_tourmutation_rand)),1));    %B�������ܵ��G(�v���k)�Axor��1��0�A0��1
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---cuculate and reproduction---%
    B_wheelFit = findFitness(x(bin2dec(B_wheel_generation)));      %�D�X�A����(���L�k�AB��)   ���榳�p���v����X�Ӧ����~�A�]���ھڥ�t���ܡAB_wheel_generation�i��]�t�����s���H�f
    B_tourFit = findFitness(x(bin2dec(B_tournament_generation)));  %�D�X�A����(�v���k�AB��)   ���榳�p���v����X�Ӧ����~�A�]���ھڥ�t���ܡAB_wheel_generation�i��]�t�����s���H�f
    R_wheelFit = findFitness(R_wheel_generation);                  %�D�X�A����(���L�k�AR��)
    R_tourFit = findFitness(R_tournament_generation);              %�D�X�A����(�v���k�AR��)
    EA_wheelFit = findFitness(EA_wheel_generation);                %�D�X�A����(���L�k�AEA��)
    EA_tourFit = findFitness(EA_tournament_generation);            %�D�X�A����(�v���k�AEA��)
    
    NEW_B_wheelPercentage = wheel_percent(B_wheelFit);
    NEW_B_wheelGeneration_decode = rouletteWheelSelection(x(bin2dec(B_wheel_generation)),NEW_B_wheelPercentage); %reproduction(���L�k�AB��)
    NEW_R_wheelPercentage = wheel_percent(R_wheelFit);
    NEW_R_wheelGeneration_decode = rouletteWheelSelection(R_wheel_generation,NEW_R_wheelPercentage);             %reproduction(���L�k�A��ƫ�)
    NEW_EA_wheelPercentage = wheel_percent(EA_wheelFit);
    NEW_EA_wheelGeneration_decode = rouletteWheelSelection(EA_wheel_generation,NEW_EA_wheelPercentage);          %reproduction(���L�k�AEA��)
    
    NEW_B_tourGeneration_decode = tournamentSelection(x(bin2dec(B_tournament_generation)),2);                    %reproduction(�v���k�AB��)
    NEW_R_tourGeneration_decode = tournamentSelection(R_tournament_generation,2);                                %reproduction(�v���k�A��ƫ�)
    NEW_EA_tourGeneration_decode = tournamentSelection(EA_tournament_generation,2);                              %reproduction(�v���k�AEA��)
    
    B_wheelGeneration_decode = NEW_B_wheelGeneration_decode;                        %��s�ȡA�H�ϰj�����L�~(���L�k�AB��)
    B_tournamentGeneration_decode = NEW_B_tourGeneration_decode;                    %��s�ȡA�H�ϰj�����L�~(�v���k�AB��)
    R_wheelGeneration_decode = NEW_R_wheelGeneration_decode;                        %��s�ȡA�H�ϰj�����L�~(���L�k�A��ƫ�)
    R_tournamentGeneration_decode = NEW_R_tourGeneration_decode;                    %��s�ȡA�H�ϰj�����L�~(�v���k�A��ƫ�)
    EA_wheelGeneration_decode = NEW_EA_wheelGeneration_decode;                      %��s�ȡA�H�ϰj�����L�~(���L�k�AEA��)
    EA_tournamentGeneration_decode = NEW_EA_tourGeneration_decode;                  %��s�ȡA�H�ϰj�����L�~(�v���k�AEA��)
    
    B_wheel_plot(n) = max(B_wheelFit);                                              %���������@�N���̨θ�(���L�k�A��ƫ�)
    B_tour_plot(n) = max(B_tourFit);                                                %���������@�N���̨θ�(�v���k�A��ƫ�)
    R_wheel_plot(n) = max(R_wheelFit);                                              %���������@�N���̨θ�(���L�k�A��ƫ�)
    R_tour_plot(n) = max(R_tourFit);                                                %���������@�N���̨θ�(�v���k�A��ƫ�)
    EA_wheel_plot(n) = max(EA_wheelFit);                                            %���������@�N���̨θ�(���L�k�AEA��)
    EA_tour_plot(n) = max(EA_tourFit);                                              %���������@�N���̨θ�(�v���k�AEA��)
    
    n = n + 1;
end
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------%
%---plot---%
xx = 0:n-2; 

B_wheel_max = power(B_wheel_plot(n-1),0.125);         %���̷s�@�N���A���ȡA����ѽX(���L�k�A��ƫ�)
B_tour_max = power(B_tour_plot(n-1),0.125);           %���̷s�@�N���A���ȡA����ѽX(�v���k�A��ƫ�)
R_wheel_max = power(R_wheel_plot(n-1),0.125);         %���̷s�@�N���A���ȡA����ѽX(���L�k�A��ƫ�)
R_tour_max = power(R_tour_plot(n-1),0.125);           %���̷s�@�N���A���ȡA����ѽX(�v���k�A��ƫ�)
EA_wheel_max = power(EA_wheel_plot(n-1),0.125);       %���̷s�@�N���A���ȡA����ѽX(���L�k�AEA��)
EA_tour_max = power(EA_tour_plot(n-1),0.125);         %���̷s�@�N���A���ȡA����ѽX(�v���k�AEA��)

B_wheel_x = B_wheelGeneration_decode(xFind(B_wheelGeneration_decode));                    %���̷s�@�N��X
B_tour_x = B_tournamentGeneration_decode(xFind(B_tournamentGeneration_decode));           %���̷s�@�N��X
R_wheel_x = R_wheelGeneration_decode(xFind(R_wheelGeneration_decode));                    %���̷s�@�N��X
R_tour_x = R_tournamentGeneration_decode(xFind(R_tournamentGeneration_decode));           %���̷s�@�N��X
EA_wheel_x = EA_wheelGeneration_decode(xFind(EA_wheelGeneration_decode));                 %���̷s�@�N��X
EA_tour_x = EA_tournamentGeneration_decode(xFind(EA_tournamentGeneration_decode));        %���̷s�@�N��X

% Plot Binary-Code GAs chart
subplot(3,2,1);
plot(xx,B_wheel_plot); title( {['Binary-Code GAs with roulette wheel selection'],[' Maximum = ' , mat2str(B_wheel_max),'   x = ',num2str(B_wheel_x)]});
xlabel('Generations'); ylabel('Fitness');
subplot(3,2,2);
plot(xx,B_tour_plot); title( {['Binary-Code GAs with tournament selection'],['Maximum = ' , mat2str(B_tour_max),'   x = ',num2str(B_tour_x)]});  
xlabel('Generations'); ylabel('Fitness');   

% Plot Real-Value GAs chart
subplot(3,2,3);
plot(xx,R_wheel_plot); title( {['Real-Value GAs with roulette wheel selection'],['Maximum = ' , mat2str(R_wheel_max),'   x = ',num2str(R_wheel_x)]});  
xlabel('Generations'); ylabel('Fitness');
subplot(3,2,4);
plot(xx,R_tour_plot); title( {['Real-Value GAs with tournament selection'],['Maximum = ' , mat2str(R_tour_max),'   x = ',num2str(R_tour_x)]});  
xlabel('Generations'); ylabel('Fitness');         

% Plot Evolutionary Algorithm chart
subplot(3,2,5);
plot(xx,EA_wheel_plot); title( {['Evolutionary Algorithm with roulette wheel selection'],['Maximum = ' , mat2str(EA_wheel_max),'   x = ',num2str(EA_wheel_x)]});  
xlabel('Generations'); ylabel('Fitness');
subplot(3,2,6);
plot(xx,EA_tour_plot); title( {['Evolutionary Algorithm with tournament selection'],['Maximum = ' , mat2str(EA_tour_max),'   x = ',num2str(EA_tour_x)]});  
xlabel('Generations'); ylabel('Fitness');           