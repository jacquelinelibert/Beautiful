#!/usr/bin/env python
# -*- coding: utf-8 -*-

from numpy import *
from scipy import *
from matplotlib import pylab
from sqlShort import sqlShort

db = sqlShort(host='results/jvo_db.sqlite', type='sqlite')

voc, voc_name = db.query("""
	SELECT vocoder, vocoder_name
	FROM thr GROUP BY vocoder
	""")

vocs = dict(zip(voc, voc_name))

cm = array([[207, 82, 10], [237, 186, 70], [78, 164, 38], [25, 112, 176], [149, 38, 138], [250, 90, 0], [200, 0, 0], [0, 150, 255], [158, 204, 59], [54, 102, 255]])/255.
cm = r_[cm, .7*cm]

cols = {2: cm[0], 1: cm[1], 0: cm[2], 3: cm[3], 4: cm[4]}
lw = 2

fig = pylab.figure()
ax  = fig.add_axes((.12, .1, .8, .8))

dashes = (6,3,2,3)
ax.axhline(y=0, dashes=dashes, color=ones(3)*.7, lw=.75)
ax.axvline(x=0, dashes=dashes, color=ones(3)*.7, lw=.75)

ids, = db.query("SELECT subject FROM thr GROUP BY subject")

markers = {'AB': 's', 'Cochlear': 'o'}

for i, id in enumerate(ids):

	subject_clause = " AND subject='%s' " % id

	for voc, voc_desc in vocs.iteritems():
	
		col = cm[i]
		
		brand, = db.query("SELECT brand FROM subject WHERE subject='%s'" % id)
		brand = brand[0]
		
		if id!=ids[0]:
			voc_desc = None
	
		ref_f0, ref_ser, dir_f0, dir_ser, thr_f0, thr_ser, thr, se_thr = db.query("""
			SELECT ref_f0, ref_ser, dir_f0, dir_ser,
				AVG(threshold_f0) AS thr_f0, AVG(threshold_ser) AS thr_ser, AVG(threshold) AS thr,
				STD(threshold)/SQRT(COUNT(*)) AS se_thr
			FROM thr
			WHERE vocoder=%d %s
				AND ref_voice='female'
			GROUP BY dir_f0, dir_ser
			""" % (voc, subject_clause),
			array=True)
	
		u = log2(dir_f0 / ref_f0) + 1j * log2(dir_ser / ref_ser)
		a = angle(u)
		a[a>=pi] += -2*pi
		u = u/abs(u)

		ix = argsort(a)

		dir_f0 = 12*log2(dir_f0[ix]/ref_f0[ix])
		dir_ser = 12*log2(dir_ser[ix]/ref_ser[ix])
		thr_f0 = thr_f0[ix]
		thr_ser = thr_ser[ix]
		se = se_thr[ix]
		thr = thr[ix]
		u = u[ix]
	
		for j in range(len(dir_f0)):
			ax.plot(thr_f0[j]+se[j]*array([-1, 1])*real(u[j]), thr_ser[j]+se[j]*array([-1, 1])*imag(u[j]), '-o', color=col, ms=4, mfc='none', mec=col*.7)

		s = ((dir_f0==0) & (dir_ser>0)) | ((dir_f0<0) & (dir_ser==0))
		ax.plot(thr_f0[s], thr_ser[s], '-', color=col*.5+.5, lw=lw, dashes=(2,2))

		s = ((dir_f0==0) & (dir_ser<0)) | ((dir_f0>0) & (dir_ser==0))
		ax.plot(thr_f0[s], thr_ser[s], '-', color=col*.5+.5, lw=lw, dashes=(2,2))

		s = (dir_f0>=0) & (dir_ser>=0)
		ax.plot(thr_f0[s], thr_ser[s], '-', color=col, lw=lw, mec=col*.5, ms=7, marker=markers[brand])

		s = (dir_f0<=0) & (dir_ser<=0)
		ax.plot(thr_f0[s], thr_ser[s], '-', color=col, lw=lw, mec=col*.5, ms=7, label=id, marker=markers[brand])
    

ax.legend(loc='lower left', prop={'size': 11})
ax.set_ylabel("1/VTL (semitones re. reference)")
ax.set_xlabel("F0 (semitones re. reference)")

ax.set_yticks(range(-14, 10, 2))

xlim = ax.get_xlim()
ylim = ax.get_ylim()
dx = xlim[1]-xlim[0]
dy = ylim[1]-ylim[0]
s = .4
fig.set_size_inches(dx*s, dy*s)
fig.savefig("Results_indiv.png", dpi=200, format="png")
fig.savefig("Results_indiv.eps", format="eps")


