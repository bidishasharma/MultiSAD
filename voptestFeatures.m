%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [MSMS1,SHE1]=voptestFeatures(data,fs)

out1 = data(:,1);
Fs=8000;
out1=resample(out1,Fs,fs);%%Resampling to 8k
out2=out1-mean(out1);
out=out2/max(abs(out2));

%--------------------------------------------------------------------------
LPFL=(20*Fs)/1000; LPOLN=(10*Fs)/1000; P=8; Npoints=(50*Fs)/1000;                                                                                                
WL=(20*Fs)/1000;  OL=(10*Fs)/1000;   NFFT=512;     NPEAKS=10;                              
Fmin=0;  Fmax=Fs/2;  NBANDS=18;  NORDER=1000; LPFFc=28; MWL=20; MOLN=1;                    
%%%%%%--------------------------------------------------------------------------
%LPR
[res1,LPCoeffs1] = LPresidual_v4(out,LPFL,LPOLN,P,1,1,0);
%--------------------------------------------------------------------------
%MS,SHE
[ms1,MS1]= modulationspectrum(out,Fmin,Fmax,Fs,NBANDS,NORDER,LPFFc,MWL,MOLN);
he1=abs(hilbert(res1))';
she1=meansmooth(he1,Npoints,0);
she1=she1-min(she1); 
SHE1=she1./max(abs(she1));
MS1=MS1-min(MS1);MS1=MS1./max(abs(MS1));
%--------------------------------------------------------------------------
%MEAN SMOOTH
NMP=(50*Fs)/1000;
MSMS1=meansmooth(MS1,NMP,0);       %Modulation Spectrum
SHE1=meansmooth(SHE1,NMP,0);    %Smoothed Hilbert Envelope
