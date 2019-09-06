function [SADOut]=SpeechActivityDetection(WavFileName)

[y1,fs]=audioread(WavFileName);
y1 = specsub(y1,fs); %%Apply Spectral subtraction 
[MSMS1,SHE1]=voptestFeatures(y1,fs); %% Find Modulation Spectrum and Smoothed of Hilbert envelope evidence
MSMS1=(MSMS1-min(MSMS1))/(max(MSMS1)-min(MSMS1));
IndxZero=find(MSMS1<0.1*median(MSMS1)); %% First levlel filtering using Modulation Spectrum energy
SILArray=ones(1,length(y1));
SILArray(IndxZero)=0;SILArray(1:10)=0;SILArray(end)=0;
[SILArray1]=PostProcessing(SILArray,fs,0.8);
IndxZeroV2=find(SILArray1==0);

QFactor=FindQFactor(y1); %% Determine Q-factor

if QFactor>0.5   %% Set threshold according to Q-factor
   ThresEnergy=0.01;
   ThresTime=0.5;
elseif QFactor>0.3
   ThresEnergy=0.02;
   ThresTime=1;
else
   ThresEnergy=0.01; 
   ThresTime=1;
end
 
SHE1 = smoothdata(SHE1); SHE1=(SHE1-min(SHE1))/(max(SHE1)-min(SHE1));
SHE1(IndxZeroV2)=0;
SHE11 = FilterEnergy(SHE1,ThresEnergy); %% Second levlel filtering using Smoothed of Hilbert Envelope
[SADOut]=PostProcessing(SHE11,fs,ThresTime);  


function [IndOut]=FilterEnergy(energy,thresh)
IndOut=ones(1,length(energy));
IndOut(find(energy<thresh))=0;
end



function [MSAA11Mod]=PostProcessing(MSAA11,fs,thres)
strtVal=MSAA11(1);EndVal=MSAA11(end);
MSAA11(1)=1;
MSAA11(end)=1;
MSAA11Mod=MSAA11;
DifMSAA11=[0 diff(MSAA11)];
SwitchIndx1=find(DifMSAA11==1);
SwitchIndx2=find(DifMSAA11==-1);
  

if (length(SwitchIndx2)>length(SwitchIndx1))
    SwitchIndx22=SwitchIndx2(2:end);
else
    SwitchIndx22=SwitchIndx2;
end    

if (length(SwitchIndx1)>length(SwitchIndx2))
    SwitchIndx11=SwitchIndx1(1:end-1);
else
    SwitchIndx11=SwitchIndx1;
end 

SilenceTime=(SwitchIndx11-SwitchIndx22)/fs;
IndSil=find(SilenceTime<thres);
strt=SwitchIndx22(IndSil);
stpt=SwitchIndx11(IndSil);
for k=1:length(strt)
   MSAA11Mod(strt(k):stpt(k))=1; 
end
MSAA11Mod(1)=strtVal;
MSAA11Mod(end)=EndVal;
end


end
