

verbatimtex
%&latex
\documentclass[12pt]{article}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{bm}
\begin{document}
etex

beginfig(1)
%	pickup pensquare scaled 2.0pt;

	fontA=0.78;
	fontB=0.55;
	levelpen=0.8;
	levelpenA=1.6;

% 2S
	lw=40;                       %  level width
	hfx=5;                      %  hyperfine dashed line
	hfy=6;                       %  hyperfine dashed line
	z99=(lw,0);
	z98=(0.75*lw,0);			
	z97=(lw/3,0);			
	z0=(100,100);
	z1=z0+z99;
	draw z0--z1 withpen pencircle scaled levelpen;
	z2=z1+(hfx,-2*hfy);
	z3=z1+(hfx,hfy);
        draw z1--z2 dashed evenly scaled 0.5;
        draw z1--z3 dashed evenly scaled 0.5;
	draw z2--z2+z98;
	draw z3--z3+z98;

	fontH=0.45;
	hfsdx=19;
	hfsdy=-1;
	label.ulft( btex $-A$ etex scaled fontH, 0.5[z2,z2+z98]+(hfsdx,hfsdy));
	label.ulft( btex $\frac{1}{2} A$ etex scaled fontH, 0.5[z3,z3+z98]+(hfsdx,hfsdy));

	label.rt( btex $A$=152.1 MHz etex scaled fontB, z1+(18*hfx,0));

	label.lrt( btex $2\hspace{1pt}S_{1/2}$ etex scaled fontA, z0 );
	label.rt(  btex F=1/2 etex scaled fontB, z2+1.2*z98);
	label.rt(  btex F=3/2 etex scaled fontB, z3+1.2*z98);


	scale=5.0;
	scale3=1.00;

	tdlabelX= -0.75*lw;
	tdlabelY= -1.;
	tdY=9;

% 2P
	SP=lw+10.0*hfx;
	twoP=14.900*scale;
	z10=z0+(SP,twoP);
	z11=z10+z99;
	draw z10--z11 withpen pensquare scaled levelpenA;
	done=38;
	draw z10-(0,done)--z11-(0,done) withpen pencircle scaled levelpen;
	label.urt( btex $2\hspace{1pt}P_{3/2}$ etex scaled fontA, z11+(tdlabelX,-1));
	label.urt( btex $2\hspace{1pt}P_{1/2}$ etex scaled fontA, z11+(tdlabelX,-done-1));

	fontE = 0.5;
	label.lft( btex $\Gamma\!=\!(2\pi)\hspace{1pt}5.9\,\rm{MHz}$ etex scaled fontE,  z10+(-0.5,-0.5));
	ahlength := 1.8;
	drawarrow z10+(-2,5)--z10+(-2,1) withpen pensquare scaled 0.1;
	drawarrow z10+(-2,-5)--z10+(-2,-1) withpen pensquare scaled 0.1;

	hfyA=6.;
        z115=z11+(hfx,-1.5*hfyA); 
        z113=z11+(hfx, 1.0*hfyA); 
        z111=z11+(hfx, 2.5*hfyA); 
	draw z11--z115 dashed evenly scaled 0.5;
	draw z115--z115+z98;
	draw z11--z113 dashed evenly scaled 0.5;
	draw z113--z113+z98;
	draw z11--z111 dashed evenly scaled 0.5;
	draw z111--z111+z98;

	hfsdxB=5;
	label.ulft( btex $\frac{3}{2} A$ etex scaled fontH, 0.5[z115,z115+z98]+(hfsdxB,hfsdy));
	label.ulft( btex $- A$ etex scaled fontH, 0.5[z113,z113+z98]+(hfsdxB,hfsdy));
	label.ulft( btex $-\frac{5}{2} A$ etex scaled fontH, 0.5[z111,z111+z98]+(hfsdxB,hfsdy));

	label.rt( btex $A=-1.1$ MHz etex scaled fontB, z11+(13*hfx,0));
	
	label.rt(  btex F=5/2 etex scaled fontB, z115+z98);
	label.rt(  btex F=3/2 etex scaled fontB, z113+z98);
	label.rt(  btex F=1/2 etex scaled fontB, z111+z98);


% 671nm
	fontF = 0.8;
	ahlength := 3.5;
	ahangle := 30;
	drawdblarrow z3+0.15*z98--z10+0.25*z98 withpen pencircle scaled 0.75; 
	drawdblarrow z2+0.15*z98--z10+0.63*z98 withpen pencircle scaled 0.75;

	z222=z10+0.15*z98-z3-0.2*z98;
	label( btex Trap etex scaled fontE rotated angle z222 , 0.18[z3+0.15*z98,z10+0.25*z98]+(0,6.));
	label( btex Repump etex scaled fontE rotated angle z222, 0.32[z2+0.15*z98,z10+0.63*z98]+(0,6.));

 
	label.ulft( btex \bf 671 nm etex scaled fontF,  0.6[z0+0.8*z98,z10+0.2*z98]); 

% 228 MHz
	fontD = 0.5;
	z555=0.5[z2,z3]+(56,0);
	label.rt(btex $228\,\rm{MHz}$ etex scaled fontD, z555); 
	ahlength := 1.8;
	drawarrow z555+(10,4)--z555+(10,10) withpen pensquare scaled 0.1;
	drawarrow z555+(10,-4)--z555+(10,-10) withpen pensquare scaled 0.1;

% 10.056 GHz
	z666=z10+(0.7*lw,-0.5*done);
	label.rt(btex $10.0156\,\rm{GHz}$ etex scaled fontD, z666); 
	ahlength := 1.8;
	drawarrow z666+(10,4)--z666+(10,18) withpen pensquare scaled 0.1;
	drawarrow z666+(10,-4)--z666+(10,-18.8) withpen pensquare scaled 0.1;

endfig;

end
