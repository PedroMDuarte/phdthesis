

verbatimtex
%&latex
\documentclass[12pt]{article}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{bm}
\begin{document}
\newcommand{\mathfont}{\sf}
\newcommand{\labelfont}{\sffamily}
\newcommand{\unitfont}[1]{\mathsf{#1}}
\renewcommand{\mathfont}{}
\renewcommand{\labelfont}{}
\renewcommand{\unitfont}[1]{\mathrm{#1}}
etex

beginfig(1)
%	pickup pensquare scaled 2.0pt;

	fontA=0.78;
	fontB=0.55;
	levelpen=0.8;

% 2S
	lw=40;                       %  level width
	hfx=15;                      %  hyperfine dashed line
	hfy=6;                       %  hyperfine dashed line
	z99=(lw,0);
	z98=(lw/3,0);			
	z0=(100,100);
	z1=z0+z99;
	draw z0--z1 withpen pencircle scaled levelpen;
	z2=z1+(hfx,-2*hfy);
	z3=z1+(hfx,hfy);
        draw z1--z2 dashed evenly scaled 0.5;
        draw z1--z3 dashed evenly scaled 0.5;
	draw z2--z2+z98;
	draw z3--z3+z98;
	label.lrt( btex $\mathfont 2\hspace{1pt}S_{1/2}$ etex scaled fontA, z0 );
	label.rt(  btex $\mathfont F=1/2$ etex scaled fontB, z2+z98);
	label.rt(  btex $\mathfont F=3/2$ etex scaled fontB, z3+z98);


	scale=3.5;
	scale2=0.8;
	scale3=1.00;

% 3S
	threeS=27.200*scale*scale3;
	z30=z0+(0,threeS);
	z31=z30+z99;
	draw z30--z31 withpen pencircle scaled levelpen;
	label.urt( btex $\mathfont 3\hspace{1pt}S_{1/2}$ etex scaled fontA, z30);

	tdlabelX= -25.5;
	tdlabelY= -1.;
	tdY=9;

% 2P
	SP=lw+4.4*hfx;
	twoP=14.900*scale*scale2;
	z10=z0+(SP,twoP);
	z11=z10+z99;
	draw z10--z11 withpen pencircle scaled levelpen;
	done=8;
	draw z10-(0,done)--z11-(0,done) withpen pencircle scaled levelpen;
	label.urt( btex $\mathfont 2\hspace{1pt}P_{3/2},P_{1/2}$ etex scaled fontA, z11+(tdlabelX,0));

% 3P
	scale4=1.1;
	threeP=30.925*scale*scale4;
	z20=z0+(SP,threeP);
	z21=z20+z99;
	draw z20--z21 withpen pencircle scaled levelpen;
	label.urt( btex $\mathfont 3\hspace{1pt}P_{3/2}$ etex scaled fontA, z21+(tdlabelX,0));

% 671nm
	fontE = 0.6;
	fontF = 0.6;
	drawdblarrow z0+2.3*z98--z10+0.3*z98-0.*(0,done) withpen pencircle scaled 1.1; 
	%label.lrt( btex $\bf \bm{\Gamma}\!=\!(2\bm{\pi})\hspace{1pt}5.9\,\unitfont{\bf MHz}$ etex scaled fontE,  z11+(tdlabelX,tdlabelY-done));
	%label.lrt( btex $\bf T_{D}\!=\!140\,\bm{\mu}  \unitfont{\bf K}$ etex scaled fontE, z11+(tdlabelX,tdlabelY-done-tdY));
	label.lrt( btex $\mathfont \Gamma\!=\!(2\pi)\hspace{1pt}5.86\,\unitfont{MHz}$ etex scaled fontE,  z11+(tdlabelX,tdlabelY-done));
	label.lrt( btex $\mathfont T_{D}\!=\!140\,\mu  \unitfont{K}$ etex scaled fontE, z11+(tdlabelX,tdlabelY-done-tdY));
	label.lrt( btex $\mathfont T_{R}\!=\!3.5\,\mu  \unitfont{K}$ etex scaled fontE, z11+(tdlabelX,tdlabelY-done-2*tdY));
	label.lrt( btex \bfseries \labelfont 671 nm etex scaled fontF,  0.6[z0+2.3*z98,z10+0.5*z98-0.5*(0,done)]); 

% 323nm 
	fontC = 0.52;
	alpha= 1.0;
	drawdblarrow z0+1.5*z98--z20+alpha*z98 withpen pencircle scaled 1.1;
	label.lrt(btex $\mathfont \Gamma = (2\pi)\hspace{1pt}764\,\unitfont{kHz}$ etex scaled fontE,  z21+(tdlabelX,tdlabelY));
	label.lrt(btex $\mathfont T_{D}=20\, \mu \unitfont{K}$ etex scaled fontE, z21+(tdlabelX,tdlabelY-tdY));
	label.lrt(btex $\mathfont T_{R}=15\, \mu \unitfont{K}$ etex scaled fontE, z21+(tdlabelX,tdlabelY-2*tdY));
	z222=-z0-1.5*z98+z20+alpha*z98;
	%label(btex $\mathfont \tau^{-1}\!=\!(2\pi)\hspace{1pt} 169\,\unitfont{kHz}$ etex scaled fontC rotated angle z222, .74[z0+1.5*z98+(0,7),z20+alpha*z98+(0,7)]);
	label(btex $\mathfont (2\pi)\hspace{1pt} 169\,\unitfont{kHz}$ etex scaled fontC rotated angle z222, .74[z0+1.5*z98+(0,7),z20+alpha*z98+(0,7)]);
	label.ulft( btex \bfseries \labelfont 323 nm etex scaled fontF, 0.3[z0+1.5*z98,z20+alpha*z98]);

% 2.69um
	drawarrow z20+0.5*z98--z30+2.5*z98;
	%label.ulft(btex $2.69\,\unitfont{\mu m} \atop 595\,\unitfont{kHz}$ etex scaled fontC, .5[z30+2*z98,z20+0.5*z98]);
	z22=-z30-2.5*z98+z20+0.5*z98;
	%label(btex $\mathfont \tau^{-1}\!=\!(2\pi)\hspace{1pt} 595\,\unitfont{kHz}$ etex scaled fontC rotated angle z22, .55[z30+2*z98+(0,3),z20+0.5*z98+(0,3)]);
	label(btex $\mathfont (2\pi)\hspace{1pt} 595\,\unitfont{kHz}$ etex scaled fontC rotated angle z22, .55[z30+2*z98+(0,3),z20+0.5*z98+(0,3)]);

% 812.6nm
	drawarrow z30+2*z98--z10+z98;
        %Find intersection of arrow with 3S state 
        z32=aa[z30,z31];
	z32=ab[z30+2*z98-(0,done),z10+z98-(0,done)];
	drawarrow z32--z10+z98-(0,done);
	%label.llft(btex $812\,\unitfont{nm} \atop 3.6,\,1.8\,\unitfont{MHz}$ etex scaled fontC, .35[z30+2*z98,z10+z98]);
	z2222=-z30-2*z98+z10+z98;
	fontG=0.95*fontC;
	%label(btex $\mathfont \tau^{-1}\!=\!(2\pi)\hspace{1pt} 3.6\,\unitfont{MHz}$ etex scaled fontG rotated angle z2222, .31[z30+2*z98+(0,3.6),z10+z98+(0,3.6)]);
	%label(btex $\mathfont \tau^{-1}\!=\!(2\pi)\hspace{1pt} 1.8\,\unitfont{MHz}$ etex scaled fontG rotated angle z2222, .26[z30+2*z98+(0,-4.5),z10+z98+(0,-4.5)]);
	label(btex $\mathfont (2\pi)\hspace{1pt} 3.6\,\unitfont{MHz}$ etex scaled fontG rotated angle z2222, .31[z30+2*z98+(0,3.6),z10+z98+(0,3.6)]);
	label(btex $\mathfont (2\pi)\hspace{1pt} 1.8\,\unitfont{MHz}$ etex scaled fontG rotated angle z2222, .26[z30+2*z98+(0,-4.5),z10+z98+(0,-4.5)]);
	%label.llft(btex $3.6,\,1.8\,\unitfont{MHz}$ etex scaled fontC, .35[z30+2*z98,z10+z98]);

% 228 MHz
	fontD = 0.5;
	label.rt(btex $\mathfont 228\,\unitfont{MHz}$ etex scaled fontD, 0.5[z2,z3]+(-2,0)); 


endfig;

end
