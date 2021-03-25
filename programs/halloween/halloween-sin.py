import math

N = 1

for n in xrange(N):
	y = (math.sin(float(n)/float(N)*math.pi*2.0)+1.0)/2.0*(8*16-1)

	sy = int(round((y % 16)/3))
	cy = int(round(int(y / 16)))

	print "; x = %d y = %f" % (n, y)
	print "db %d" % cy
	print "db %d" % sy

	#print n, y, cy*16+sy*3
