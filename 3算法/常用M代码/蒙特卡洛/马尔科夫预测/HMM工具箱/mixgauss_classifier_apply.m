function [classHatTest, probPos] = mixgauss_classifier_apply(mixgauss, testFeatures)

Bpos = mixgauss_prob(testFeatures, mixgauss.pos.mu, mixgauss.pos.Sigma, mixgauss.pos.prior);
Bneg = mixgauss_prob(testFeatures, mixgauss.neg.mu, mixgauss.neg.Sigma,  mixgauss.neg.prior);
prior_pos = mixgauss.priorC(1);
prior_neg = mixgauss.priorC(2);
post = normalize([Bpos * prior_pos; Bneg * prior_neg], 1);
probPos = post(1,:)';
[junk, classHatTest] = max(post);
classHatTest(find(classHatTest==2))=0;
classHatTest = classHatTest(:);
