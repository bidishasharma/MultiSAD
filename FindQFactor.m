function [QFactor]=FindQFactor(y1)
    fs=8000;
    winlength=20*10^-3*fs;
    winshift=10*10^-3*fs;
    y1=(y1-max(y1))/(max(y1)-min(y1));
    [energy_frame1,energy]=energy_funcV2(y1,winlength,winshift);
     Sortenergy=sort(energy);   %[vadSg]=vadsohn(y,fs);
     Percen=round((length(energy)*0.2));
     LowEng=mean(Sortenergy(1:Percen));
     HighEng=mean(Sortenergy(end-Percen:end));
     QFactor=10*log(HighEng/LowEng);
     %QFactor=HighEng/LowEng;
