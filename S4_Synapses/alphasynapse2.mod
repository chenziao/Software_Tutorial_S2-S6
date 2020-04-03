NEURON {
	POINT_PROCESS AlphaSynapse2
	RANGE tau, e, i, w, gmax, g
	NONSPECIFIC_CURRENT i
}

PARAMETER {
	tau = 3   (ms)
	e = -80		(millivolt)
	w = 0
	gmax = 100e-6   (microsiemens)
}

ASSIGNED {
	v     (millivolt)
	i     (nanoamp)
	g	  (microsiemens)
}

STATE { a  b}


INITIAL { a = 0 b = 0}
BREAKPOINT {
	SOLVE state METHOD cnexp
	g = w*gmax*a*b
	i = g*(v-e)
	
}
DERIVATIVE state {
	a' = 1/tau
	b' = -b/tau
	}
	
NET_RECEIVE(weight) {
	LOCAL x
	x = weight
	state_discontinuity(a,(a*b/(b+x*exp(1))))
	state_discontinuity(b,b+x*exp(1))
}