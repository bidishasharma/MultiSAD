clc;
clear all;
close all;
addpath('/home/nus/BidishaResearch/STS/voicebox/')%%Path For VOICEBOX

WavFileName='./Data/temp.wav';
OutfileName='./Data/temp.txt';
 
[SADOut]=SpeechActivityDetection(WavFileName);

WriteSADOut(SADOut,OutfileName);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function WriteSADOut(speechInd2,TextFile)
fs=8000;
Difrnc=[diff(speechInd2) 0];
    IndxVAD=find(Difrnc~=0);
    strtDur=0;
    fileID = fopen(TextFile,'w'); 
    for k=1:length(IndxVAD)
    EndDur= IndxVAD(k)/fs;
   
     if (Difrnc(IndxVAD(k))==1)
       Label='non-speech';
     else
       Label='speech';
     end
         
        ConsString='X	X	X	SAD	X';
        fprintf(fileID,'%s\t%f\t%f\t%s\t%f\n',ConsString,strtDur,EndDur,Label,0.5);      
        strtDur=EndDur;

    end
end

