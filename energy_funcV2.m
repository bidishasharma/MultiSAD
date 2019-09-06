function [energy_frame1,energy]=energy_funcV2(wav,lframe,over_lap)

incre=(over_lap/lframe);
lwav=length(wav);

no_frame=floor(lwav/lframe);%for 20ms frame size and 10ms frame shift no of frames 208 actual 415
%no_frame=fix((lwav-lframe+over_lap)/over_lap);
k=0;
wav_high_energy=[];
energy_frames=[];
sample_nos=[];
[maxi]=max(abs(wav));
wav=wav/maxi;
energy_frame1=[];
pp=0;
for m=1:incre:no_frame%because of 0.5 increment total no of frames becomes 416 check pp
    pp=pp+1;
    frame=wav(floor(lframe*(m-1))+1:floor(lframe*m));
%     sample_nos=[sample_nos floor(lframe*(m-1))+1:floor(lframe*m)];
    energy(pp)=sum(frame.*frame);
end

energyBak=energy;
energy=smooth(energy,50);
energy=(energy-min(energy))/(max(energy)-min(energy));
energy(find(energy<0.02))=0;
avg_energy=sum(energy)/length(energy);
qq=0;

for n=1:incre:no_frame
    qq=qq+1;
    frame=wav(floor(lframe*(n-1))+1:floor(lframe*n));
%     energ_fram=zeros(1,160);
    energy_frame=0;
    
    if energy(qq)>0.20*avg_energy
 %   if energy(qq)>0.05*max(energy)
%         wav_high_energy=[wav_high_energy frame];
        k=k+1;
%         energ_fram=ones(1,160);
        energy_frame=1;
    end
    energy_frame1=[energy_frame1,energy_frame];
%     energy_frames=[energy_frames energ_fram];
end
% figure
% % plot(wav);
% % hold on
% plot(sample_nos,energy_frames,'r');
% grid on;
 %percentage=k/(2*no_frame)

