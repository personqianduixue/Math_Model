c     Copyright (C) 2001-7  Leo Breiman and Adele Cutler and Merck & Co, Inc.
c     This program is free software; you can redistribute it and/or
c     modify it under the terms of the GNU General Public License
c     as published by the Free Software Foundation; either version 2
c     of the License, or (at your option) any later version.

c     This program is distributed in the hope that it will be useful,
c     but WITHOUT ANY WARRANTY; without even the implied warranty of
c     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
c     GNU General Public License for more details.
c     
c     Modified by Andy Liaw and Matt Wiener:
c     The main program is re-written as a C function to be called from R.
c     All calls to the uniform RNG is replaced with R's RNG.  Some subroutines
c     not called are excluded.  Variables and arrays declared as double as 
c     needed.  Unused variables are deleted.
c     
c     SUBROUTINE BUILDTREE
      
      subroutine buildtree(a, b, cl, cat, maxcat, mdim, nsample, 
     1     nclass, treemap, bestvar, bestsplit, bestsplitnext, tgini,
     1     nodestatus,nodepop, nodestart, classpop, tclasspop, 
     1     tclasscat,ta,nrnodes, idmove, ndsize, ncase, mtry, iv,
     1     nodeclass, ndbigtree, win, wr, wl, mred, nuse, mind)

c     Buildtree consists of repeated calls to two subroutines, Findbestsplit
c     and Movedata.  Findbestsplit does just that--it finds the best split of
c     the current node.  Movedata moves the data in the split node right and
c     left so that the data corresponding to each child node is contiguous.
c     The buildtree bookkeeping is different from that in Friedman's original
c     CART program.  ncur is the total number of nodes to date.
c     nodestatus(k)=1 if the kth node has been split.  nodestatus(k)=2 if the
c     node exists but has not yet been split, and =-1 of the node is terminal.
c     A node is terminal if its size is below a threshold value, or if it is
c     all one class, or if all the x-values are equal.  If the current node k
c     is split, then its children are numbered ncur+1 (left), and
c     ncur+2(right), ncur increases to ncur+2 and the next node to be split is
c     numbered k+1.  When no more nodes can be split, buildtree returns to the
c     main program.
      
      implicit double precision(a-h,o-z)
      integer a(mdim, nsample), cl(nsample), cat(mdim),
     1     treemap(2,nrnodes), bestvar(nrnodes),
     1     bestsplit(nrnodes), nodestatus(nrnodes), ta(nsample),
     1     nodepop(nrnodes), nodestart(nrnodes),
     1     bestsplitnext(nrnodes), idmove(nsample),
     1     ncase(nsample), b(mdim,nsample),
     1     iv(mred), nodeclass(nrnodes), mind(mred)
      
      double precision tclasspop(nclass), classpop(nclass, nrnodes),
     1     tclasscat(nclass, 32), win(nsample), wr(nclass),
     1     wl(nclass), tgini(mdim), xrand
      integer msplit, ntie
      
      msplit = 0
      call zerv(nodestatus,nrnodes)
      call zerv(nodestart,nrnodes)
      call zerv(nodepop,nrnodes)
      call zermr(classpop,nclass,nrnodes)      
      
      do j=1,nclass
         classpop(j, 1) = tclasspop(j)
      end do
      ncur = 1
      nodestart(1) = 1
      nodepop(1) = nuse
      nodestatus(1) = 2
c     start main loop
      do 30 kbuild = 1, nrnodes
         if (kbuild .gt. ncur) goto 50
         if (nodestatus(kbuild) .ne. 2) goto 30
c     initialize for next call to findbestsplit
         ndstart = nodestart(kbuild)
         ndend = ndstart + nodepop(kbuild) - 1
         do j = 1, nclass
            tclasspop(j) = classpop(j,kbuild)
         end do
         jstat = 0

         call findbestsplit(a,b,cl,mdim,nsample,nclass,cat,maxcat,
     1        ndstart, ndend,tclasspop,tclasscat,msplit, decsplit,
     1        nbest,ncase, jstat,mtry,win,wr,wl,mred,mind)
         if (jstat .eq. -1) then
            nodestatus(kbuild) = -1
            goto 30 
         else
            bestvar(kbuild) = msplit
            iv(msplit) = 1
            if (decsplit .lt. 0.0) decsplit = 0.0
            tgini(msplit) = tgini(msplit) + decsplit
            if (cat(msplit) .eq. 1) then
               bestsplit(kbuild) = a(msplit,nbest)
               bestsplitnext(kbuild) = a(msplit,nbest+1)
            else
               bestsplit(kbuild) = nbest
               bestsplitnext(kbuild) = 0
            endif
         endif
         
         call movedata(a,ta,mdim,nsample,ndstart,ndend,idmove,ncase,
     1        msplit,cat,nbest,ndendl)
         
c     leftnode no.= ncur+1, rightnode no. = ncur+2.
         nodepop(ncur+1) = ndendl - ndstart + 1
         nodepop(ncur+2) = ndend - ndendl
         nodestart(ncur+1) = ndstart
         nodestart(ncur+2) = ndendl + 1

c     find class populations in both nodes
         do n = ndstart, ndendl
            nc = ncase(n)
            j=cl(nc)
            classpop(j,ncur+1) = classpop(j,ncur+1) + win(nc)
         end do 
         do n = ndendl+1, ndend
            nc = ncase(n)
            j = cl(nc)
            classpop(j,ncur+2) = classpop(j,ncur+2) + win(nc)
         end do
c     check on nodestatus
         nodestatus(ncur+1) = 2
         nodestatus(ncur+2) = 2
         if (nodepop(ncur+1).le.ndsize) nodestatus(ncur+1) = -1
         if (nodepop(ncur+2).le.ndsize) nodestatus(ncur+2) = -1
         popt1 = 0
         popt2 = 0
         do j = 1, nclass
            popt1 = popt1 + classpop(j,ncur+1)
            popt2 = popt2 + classpop(j,ncur+2)
         end do
         
         do j=1,nclass
            if (classpop(j,ncur+1).eq.popt1) nodestatus(ncur+1) = -1
            if (classpop(j,ncur+2).eq.popt2) nodestatus(ncur+2) = -1
         end do

         treemap(1,kbuild) = ncur + 1
         treemap(2,kbuild) = ncur + 2
         nodestatus(kbuild) = 1
         ncur = ncur+2
         if (ncur.ge.nrnodes) goto 50
         
 30   continue
 50   continue

      ndbigtree = nrnodes
      do k=nrnodes, 1, -1
         if (nodestatus(k) .eq. 0) ndbigtree = ndbigtree - 1
         if (nodestatus(k) .eq. 2) nodestatus(k) = -1
      end do

c     form prediction in terminal nodes
      do kn = 1, ndbigtree
         if(nodestatus(kn) .eq. -1) then
            pp = 0
            ntie = 1
            do j = 1, nclass
               if (classpop(j,kn) .gt. pp) then
                  nodeclass(kn) = j
                  pp = classpop(j,kn)
               end if
c     Break ties at random:
               if (classpop(j,kn) .eq. pp) then
                  ntie = ntie + 1
                  call rrand(xrand)
                  if (xrand .lt. 1.0 / ntie) then
                     nodeclass(kn)=j
                     pp=classpop(j,kn)
                  end if
               end if
            end do
         end if
      end do
      
      end

c     SUBROUTINE FINDBESTSPLIT
c     For the best split, msplit is the variable split on. decsplit is the
c     dec. in impurity.  If msplit is numerical, nsplit is the case number
c     of value of msplit split on, and nsplitnext is the case number of the
c     next larger value of msplit.  If msplit is categorical, then nsplit is
c     the coding into an integer of the categories going left.
      subroutine findbestsplit(a, b, cl, mdim, nsample, nclass, cat,
     1     maxcat, ndstart, ndend, tclasspop, tclasscat, msplit, 
     2     decsplit, nbest, ncase, jstat, mtry, win, wr, wl,
     3     mred, mind)
      implicit double precision(a-h,o-z)      
      integer a(mdim,nsample), cl(nsample), cat(mdim),
     1     ncase(nsample), b(mdim,nsample), nn, j          
      double precision tclasspop(nclass), tclasscat(nclass,32), dn(32),
     1     win(nsample), wr(nclass), wl(nclass), xrand
      integer mind(mred), ncmax, ncsplit,nhit, ntie
      ncmax = 10
      ncsplit = 512
c     compute initial values of numerator and denominator of Gini
      pno = 0.0
      pdo = 0.0
      do j = 1, nclass
         pno = pno + tclasspop(j) * tclasspop(j)
         pdo = pdo + tclasspop(j)
      end do
      crit0 = pno / pdo
      jstat = 0
      
c     start main loop through variables to find best split
      critmax = -1.0e25
      do k = 1, mred
         mind(k) = k
      end do
      nn = mred
c     sampling mtry variables w/o replacement.
      do mt = 1, mtry
         call rrand(xrand)
         j = int(nn * xrand) + 1
         mvar = mind(j)
         mind(j) = mind(nn)
         mind(nn) = mvar
         nn = nn - 1
         lcat = cat(mvar)
         if (lcat .eq. 1) then
c     Split on a numerical predictor.
            rrn = pno
            rrd = pdo
            rln = 0
            rld = 0
            call zervr(wl, nclass)
            do j = 1, nclass
               wr(j) = tclasspop(j)
            end do
            ntie = 1
            do nsp = ndstart, ndend-1
               nc = a(mvar, nsp)
               u = win(nc)
               k = cl(nc)
               rln = rln + u * (2 * wl(k) + u)
               rrn = rrn + u * (-2 * wr(k) + u)
               rld = rld + u
               rrd = rrd - u
               wl(k) = wl(k) + u
               wr(k) = wr(k) - u               
               if (b(mvar, nc) .lt. b(mvar, a(mvar, nsp + 1))) then
c     If neither nodes is empty, check the split.
                  if (dmin1(rrd, rld) .gt. 1.0e-5) then
                     crit = (rln / rld) + (rrn / rrd)
                     if (crit .gt. critmax) then
                        nbest = nsp
                        critmax = crit
                        msplit = mvar
                     end if
c     Break ties at random:
                     if (crit .eq. critmax) then
                        ntie = ntie + 1
                        call rrand(xrand)
                        if (xrand .lt. 1.0 / ntie) then
                           nbest = nsp
                           critmax = crit
                           msplit = mvar
                        end if
                     end if
                  end if
               end if
            end do
         else
c     Split on a categorical predictor.  Compute the decrease in impurity.
            call zermr(tclasscat, nclass, 32)
            do nsp = ndstart, ndend
               nc = ncase(nsp)
               l = a(mvar, ncase(nsp))
               tclasscat(cl(nc), l) = tclasscat(cl(nc), l) + win(nc)
            end do
            nnz = 0
            do i = 1, lcat
               su = 0
               do j = 1, nclass
                  su = su + tclasscat(j, i)
               end do
               dn(i) = su
               if(su .gt. 0) nnz = nnz + 1
            end do
            nhit = 0
            if (nnz .gt. 1) then
               if (nclass .eq. 2 .and. lcat .gt. ncmax) then
                  call catmaxb(pdo, tclasscat, tclasspop, nclass,
     &                 lcat, nbest, critmax, nhit, dn)
               else
                  call catmax(pdo, tclasscat, tclasspop, nclass, lcat,
     &                 nbest, critmax, nhit, maxcat, ncmax, ncsplit)
               end if
               if (nhit .eq. 1) msplit = mvar
c            else
c               critmax = -1.0e25
            end if
         end if
      end do
      if (critmax .lt. -1.0e10 .or. msplit .eq. 0) jstat = -1
      decsplit = critmax - crit0
      return
      end

C     ==============================================================
c     SUBROUTINE MOVEDATA
c     This subroutine is the heart of the buildtree construction. Based on the 
c     best split the data in the part of the a matrix corresponding to the 
c     current node is moved to the left if it belongs to the left child and 
c     right if it belongs to the right child.
      
      subroutine movedata(a,ta,mdim,nsample,ndstart,ndend,idmove,
     1     ncase,msplit,cat,nbest,ndendl)
      implicit double precision(a-h,o-z)
      integer a(mdim,nsample),ta(nsample),idmove(nsample),
     1     ncase(nsample),cat(mdim),icat(32)
      
c     compute idmove=indicator of case nos. going left
      
      if (cat(msplit).eq.1) then
         do nsp=ndstart,nbest
            nc=a(msplit,nsp)
            idmove(nc)=1
         end do
         do nsp=nbest+1, ndend
            nc=a(msplit,nsp)
            idmove(nc)=0
         end do
         ndendl=nbest
      else
         ndendl=ndstart-1
         l=cat(msplit)
         call myunpack(l,nbest,icat)
         do nsp=ndstart,ndend
            nc=ncase(nsp)
            if (icat(a(msplit,nc)).eq.1) then
               idmove(nc)=1
               ndendl=ndendl+1
            else
               idmove(nc)=0
            endif
         end do
      endif
      
c     shift case. nos. right and left for numerical variables.        
      
      do 40 msh=1,mdim
         if (cat(msh).eq.1) then
            k=ndstart-1
            do 50 n=ndstart,ndend
               ih=a(msh,n)
               if (idmove(ih).eq.1) then
                  k=k+1
                  ta(k)=a(msh,n)
               endif
 50         continue
            do 60 n=ndstart,ndend
               ih=a(msh,n)
               if (idmove(ih).eq.0) then 
                  k=k+1
                  ta(k)=a(msh,n)
               endif
 60         continue
            
            do 70 k=ndstart,ndend
               a(msh,k)=ta(k)
 70         continue
         endif
         
 40   continue
      ndo=0
      if (ndo.eq.1) then
         do 140 msh = 1, mdim
            if (cat(msh) .gt. 1) then
               k = ndstart - 1
               do 150 n = ndstart, ndend
                  ih = ncase(n)
                  if (idmove(ih) .eq. 1) then
                     k = k + 1
                     ta(k) = a(msh, ih)
                  endif
 150           continue
               do 160 n = ndstart, ndend
                  ih = ncase(n)
                  if (idmove(ih) .eq. 0) then 
                     k = k + 1
                     ta(k) = a(msh,ih)
                  endif
 160           continue
               
               do 170 k = ndstart, ndend
                  a(msh,k) = ta(k)
 170           continue
            endif
            
 140     continue
      end if
      
c     compute case nos. for right and left nodes.
      
      if (cat(msplit).eq.1) then
         do 80 n=ndstart,ndend
            ncase(n)=a(msplit,n)
 80      continue
      else
         k=ndstart-1
         do 90 n=ndstart, ndend
            if (idmove(ncase(n)).eq.1) then
               k=k+1
               ta(k)=ncase(n)
            endif
 90      continue
         do 100 n=ndstart,ndend
            if (idmove(ncase(n)).eq.0) then
               k=k+1
               ta(k)=ncase(n)
            endif
 100     continue
         do 110 k=ndstart,ndend
            ncase(k)=ta(k)
 110     continue
      endif
      
      end
      
      subroutine myunpack(l,npack,icat)
      
c     npack is a long integer.  The sub. returns icat, an integer of zeroes and
c     ones corresponding to the coefficients in the binary expansion of npack.
      
      integer icat(32),npack
      do j=1,32
         icat(j)=0
      end do
      n=npack
      icat(1)=mod(n,2)
      do k=2,l
         n=(n-icat(k-1))/2
         icat(k)=mod(n,2)
      end do
      end
      
      subroutine zerv(ix,m1)
      integer ix(m1)
      do n=1,m1
         ix(n)=0
      end do
      end
      
      subroutine zervr(rx,m1)
      double precision rx(m1)
      do n=1,m1
         rx(n)=0.0d0
      end do
      end
      
      subroutine zerm(mx,m1,m2)
      integer mx(m1,m2)
      do i=1,m1
         do j=1,m2
            mx(i,j)=0
         end do
      end do
      end
      
      subroutine zermr(rx,m1,m2)
      double precision rx(m1,m2)
      do i=1,m1
         do j=1,m2
            rx(i,j)=0.0d0
         end do
      end do
      end

      subroutine zermd(rx,m1,m2)
      double precision rx(m1,m2)
      do i=1,m1
         do j=1,m2
            rx(i,j)=0.0d0
         end do
      end do
      end
