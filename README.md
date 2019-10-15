# Multi-level Adaptive Speech Activity Detector for Speech in Naturalistic Environments

## Overview

![BlockDiagramV4](https://user-images.githubusercontent.com/49261836/64412497-0ce3cf80-d0c2-11e9-9c82-5ba2f77c496e.png)

Speech activity detection (SAD) is a part of many speech processing applications. The traditional SAD approaches use signal energy as the evidence to identify the speech regions. However, such methods perform poorly under uncontrolled environments. In this work, we propose a novel SAD approach using a multi-level decision with signal knowledge in an adaptive manner. The multi-level evidence considered are modulation spectrum and smoothed Hilbert envelope of linear prediction (LP) residual. Modulation spectrum has compelling parallels to the dynamics of speech production and captures information only for the speech component. Contrarily, Hilbert envelope of LP residual captures excitation source aspect of speech. Under uncontrolled scenario, these evidence are found to be robust towards the signal distortions and thus expected to work well. In view of different levels of interference present in the signal, we propose to use a quality factor to control the speech/non-speech decision in an adaptive manner. We refer this method as multi-level adaptive SAD and evaluate on Fearless Steps corpus that is collected during Apollo-11 Mission in naturalistic environments. We achieve a detection cost function of 7.35% with
the proposed multi-level adaptive SAD on the evaluation set of Fearless Steps 2019 challenge corpus.

## Usage
- This code is executed in Matlab 2017b with Voicebox.
- SADMain.m is the main code
- SpeechActivityDetection.m is the primary function for Speech Activity Detection


# Reference

This is an implementation of Multi-level Adaptive Speech Activity Detector. Details are given in the following paper:

- B. Sharma, R. K. Das and H. Li, "Multi-level Adaptive Speech Activity Detector for Speech in Naturalistic Environments", in Proc. Interspeech 2019, Graz, Austria, 15-19 September 2019, pp. 2015-2019.

Please cite this paper if you use this code.

