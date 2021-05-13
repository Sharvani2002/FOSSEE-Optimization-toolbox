/*
# AMPL Model by Hande Y. Benson
#
# Copyright (C) 2001 Princeton University
# All Rights Reserved
#
# Permission to use, copy, modify, and distribute this software and
# its documentation for any purpose and without fee is hereby
# granted, provided that the above copyright notice appear in all
# copies and that the copyright notice and this
# permission notice appear in all supporting documentation.                     

#   Source:
#   Y. Tanaka, M. Fukushima, T. Ibaraki,
#   "A comparative study of several semi-infinite nonlinear programming
#   algorithms",
#   EJOR, vol. 36, pp. 92-100, 1988.

#   SIF input: Ph. Toint, April 1992.

#   classification LLR2-AN-3-V

*/

/*
-------test case outputs-------
//	Bestknown Objective = 0.65395902; =0.649042(for M=500)
//M=500 //fval = 0.6490421
M = 350; //fval = 0.6490412

*/

x0 = zeros(3, 1);
M = 350; 
h = 1/M;
A = [];
b = [];

for i=1:M+1
	A(i, 1) = -1;
	A(i, 2) = -(i-1)*h;
	A(i, 3) = -((i-1)*h)^2;
	b(i) = -tan((i-1)*h);
end

function y=f(x)
	y = x(1)+0.5*x(2)+x(3)/3;
endfunction

function y=fGrad(x)
	y = [1, 0.5, 1/3];
endfunction

options = struct("MaxIter", [3000], "CpuTime", [600], "HessianApproximation", [1], "GradObj", fGrad,"Hessian","off","GradCon","off" );
[x,fval,exitflag,output,lambda,grad,hessian] = fot_fmincon(f, x0, A, b, options)
