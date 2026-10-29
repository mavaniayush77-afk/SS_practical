function signal_sequencer
clc;
close all;

% Original signal x(t) = rect((t-1)/2)
% Signal is ON from t=0 to t=2.
x = @(u) double(u >= 0 & u <= 2);
t = -6:0.01:8;

while true
    fprintf('\n=== SIGNAL OPERATIONS SEQUENCER ===\n');
    fprintf('1. Basic Operations\n');
    fprintf('2. Viva Proof\n');
    fprintf('3. Exit\n');

    choice = input('Enter choice (1-3): ');

    switch choice
        case 1
            basic_ops(x,t);
        case 2
            viva_proof(x,t);
        case 3
            return;
        otherwise
            fprintf('Invalid choice. Try again.\n');
    end
end
end

function basic_ops(x,t)

Y = {x(t), x(t-2), x(t+1), x(2*t), ...
     x(t/2), x(-t), 2*x(t), -x(t), x(t)+1};

labels = {'Original x(t)','Shift Right x(t-2)', ...
          'Shift Left x(t+1)','Compression x(2t)', ...
          'Expansion x(t/2)','Reversal x(-t)', ...
          'Amplification 2x(t)','Inversion -x(t)', ...
          'Offset x(t)+1'};

figure('Name','Basic Signal Operations');

for k = 1:9
    subplot(3,3,k);
    stairs(t,Y{k},'LineWidth',1.5);
    grid on;
    title(labels{k});
    xlabel('Time t');
    ylabel('Amplitude');
    xlim([-6 8]);
end

end

function viva_proof(x,t)

ref = x(2*t-3);
c1 = x(2*(t-1.5));
c2 = x(2*(t-3));

fprintf('\nVIVA PROOF\n');
fprintf('x(2t-3) = x(2(t-1.5))\n');
fprintf('Maximum difference for candidate 1: %.4f\n', ...
        max(abs(ref-c1)));
fprintf('Maximum difference for candidate 2: %.4f\n', ...
        max(abs(ref-c2)));

figure('Name','Viva Proof');

subplot(2,1,1);
stairs(t,ref,'k','LineWidth',2);
hold on;
stairs(t,c1,'g--','LineWidth',2);
stairs(t,c2,'r-.','LineWidth',2);
hold off;
grid on;

legend('x(2t-3)', ...
       'x(2(t-1.5))', ...
       'x(2(t-3))');

xlabel('Time t');
ylabel('Amplitude');
title('Viva Proof: Signal Comparison');
xlim([-1 6]);
ylim([-0.2 1.3]);

subplot(2,1,2);
stairs(t,ref-c1,'g','LineWidth',1.5);
hold on;
stairs(t,ref-c2,'r','LineWidth',1.5);
hold off;
grid on;

legend('Reference - Candidate 1', ...
       'Reference - Candidate 2');

xlabel('Time t');
ylabel('Difference');
title('Difference Between Signals');
xlim([-1 6]);

end