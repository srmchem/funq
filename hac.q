\c 40 100
\l funq.q
\l iris.q
\l seeds.q
\l uef.q

/ hierarchical agglomerative clustering (HAC)
-1"normalize seed data set features";
X:.ml.zscore seeds.X
-1"build dissimilarity matrix";
D:.ml.f2nd[.ml.edist X] X
-1"generate hierarchical clustering linkage stats";
l:.ml.link[`.ml.lw.ward] D
-1"plot elbow curve (k vs ssw)";
show .util.plt .ml.ssw[X] peach .ml.clust[l] 1+til 10
-1"link into 3 clusters";
I:.ml.clust[l] 3
-1"confirm accuracy";
g:(.ml.mode each seeds.y I)!I
.util.assert[0.9] .util.rnd[.01] avg seeds.y=.ml.ugrp g

-1"we can also check for maximum silhouette";
-1"plot silhouette curve (k vs silhouette)";
show .util.plt (avg .ml.silhouette[.ml.edist;X]::) peach .ml.clust[l] 1+til 10


-1"normalize iris data set features";
X:.ml.zscore iris.X
-1"build dissimilarity matrix";
D:.ml.f2nd[.ml.edist X] X
-1"generate hierarchical clustering linkage stats";
l:.ml.link[`.ml.lw.median] D
-1"plot elbow curve (k vs ssw)";
show .util.plt .ml.ssw[X] peach .ml.clust[l] 1+til 10
-1"link into 3 clusters";
I:.ml.clust[l] 3
-1"confirm accuracy";
g:(.ml.mode each iris.y I)!I
.util.assert[.97] .util.rnd[.01] avg iris.y=.ml.ugrp g
-1"plot silhouette curve (k vs silhouette)";
show .util.plt (avg .ml.silhouette[.ml.edist;X]::) peach .ml.clust[l] 1+til 10

-1"let's apply the analyis to one of the uef reference cluster datasets";
X:uef.a1
-1"using pedist2 makes calculating the dissimilarity matrix much faster";
D:sqrt .ml.pedist2[X;X]
-1"generate hierarchical clustering linkage stats with ward metric";
l:.ml.link[`.ml.lw.ward] D
-1"plot elbow curve (k vs ssw)";
I:.ml.clust[l] ks:15+til 10
show .util.plt .ml.ssw[X] peach I
-1"plot silhouette curve (k vs silhouette)";
show .util.plt s:(avg .ml.silhouette[.ml.edist;X]::) peach .ml.clust[l] ks
.util.assert[20] ks i:.ml.imax s
-1"plot the clustered data";
show .util.plot[39;20;.util.c68] .ml.append[.ml.ugrp I i;X]
