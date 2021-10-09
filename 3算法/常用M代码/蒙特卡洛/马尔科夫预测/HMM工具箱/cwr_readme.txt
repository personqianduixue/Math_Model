This directory implements Cluster Weighted Regression, as described in
Neil Gershenfeld, "The nature of mathematical modelling", p182.
(See also http://www.media.mit.edu/physics/publications/books/nmm/files/index.html)

Written by K. Murphy, 2 May 2003

The model is as follows:

X<--|
|   Q
v   |
Y<--

where Q is a discrete latent mixture variable.

A mixture of experts has an X->Q arc instead of a Q->X arc;
the X->Q arc is modelled by a softmax, which is slightly harder to fit than a
mixture of Gaussians.


