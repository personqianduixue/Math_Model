 % Read in an mp3 file, downsampled to 22 kHz mono
 [d,sr] = mp3read('Unwanted.mp3',[1 30*22050],1,2);
 soundsc(d,sr)
 % Convert to MFCCs very close to those genrated by feacalc -sr 22050 -nyq 8000 -dith -hpf -opf htk -delta 0 -plp no -dom cep -com yes -frq mel -filt tri -win 32 -step 16 -cep 20
 [mm,aspc] = melfcc(d*3.3752, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
 % .. then convert the cepstra back to audio (same options)
 [im,ispc] = invmelfcc(mm, sr, 'maxfreq', 8000, 'numcep', 20, 'nbands', 22, 'fbtype', 'fcmel', 'dcttype', 1, 'usecmp', 1, 'wintime', 0.032, 'hoptime', 0.016, 'preemph', 0, 'dither', 1);
 % listen to the reconstruction
 soundsc(im,sr)
 % compare the spectrograms
 subplot(311)
 specgram(d,512,sr)
 caxis([-50 30])
 title('original music')
 subplot(312)
 specgram(im,512,sr)
 caxis([-40 40])
 title('noise-excited reconstruction from cepstra')
 % Notice how spectral detail is blurred out e.g. the triangle hits around 6 kHz are broadened to a noise bank from 6-8 kHz.
 % save out the reconstruction
 max(abs(im))
 wavwrite(im/4,sr,'HoldMeNow.wav');