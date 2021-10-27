function DescriptorExtractor(filename, resultfile)

% reading the audio
[audio, samplerate] = wavread(filename);

% the processing goes here...





% writing results to file
f = fopen(resultfile, 'w');

% replace this line with your code...
fprintf(f, '%d %d %d...\n', 12, 34, 56);

% we are done, closing file
fclose(f);
