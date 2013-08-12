input graph
input sarith

verbatimtex
%&latex
\documentclass[12pt]{article}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{bm}
\DeclareMathSizes{10}{18}{4}{4}
\begin{document}
etex

beginfig(1);
	labelx=-0.75;
	labelxA=-2.0;
	fontA=0.65;
	fontAA=0.7;
	fontB=0.6;
	fontC=0.4;
	graphX=7cm;
	graphY=3.0cm;

	YRM=-115;
	YRP=35;
        
  	xsec=39.5;
	ysec=71.5;
        draw (xsec,ysec)--(xsec,ysec+7) withpen pensquare scaled 1.5pt withcolor 0.8*white;
	xsecB=158.7; 
        draw (xsecB,ysec)--(xsecB,ysec) withpen pensquare scaled 1.5pt withcolor 0.8*white; 

	draw begingraph(graphX,graphY);
	autogrid(,);
	frame scaled 0.01 withpen pencircle scaled 0pt withcolor white;
	setrange((-2.5,YRM),(10,YRP));

        %----- Draw the lines or shaded boxes to indicate the time regions -----%

	pickup pencircle scaled 0.1pt;
	%gdraw tA dashed withdots;	
	%gfill tA--reverse tB--cycle withcolor 0.83*white;
	%gfill tB--reverse tC--cycle withcolor 0.87*white;
	%gfill tC--reverse tD--cycle withcolor 0.85*white;
	%gfill tD--reverse tE--cycle withcolor 0.83*white;
	%gfill tE--reverse tF--cycle withcolor 0.89*white;
	sa=-2.5;
	sb=0.0;
	sc=1.25;
	sd=2.50;
	se=7.50;
	sf=8.50;
	sg=7.00;
 
	fontD=0.9;
	%glabel.llft(btex \sf (a) etex scaled fontD, 8.05, YRP+30);

	glabel.ulft(btex \sf CMOT etex scaled fontAA, -0.2, YRP);
	glabel.urt(btex \sf UV MOT etex scaled fontAA, 3.0, YRP);

	gdraw (sa,YRM+5)--(sf,YRM+5)--(sf,YRP)--(sa,YRP)--(sa,YRM+5) withpen pencircle scaled 1pt withcolor 0.*white;
	
	gdraw (sb,YRM+5)--(sb,YRP) withpen pensquare scaled 1.5pt withcolor 0.8*white;	
	gdraw (sc,YRM+5)--(sc,YRP) withpen pensquare scaled 1.5pt withcolor 0.9*white;	
	gdraw (sd,YRM+5)--(sd,YRP) withpen pensquare scaled 1.5pt withcolor 0.9*white;
	gdraw (se,YRM+5)--(se,YRP) withpen pensquare scaled 1.5pt withcolor 0.8*white;
	gdraw (sg,YRM+5)--(sg,YRP) withpen pensquare scaled 1.5pt withcolor 0.9*white;

	pickup pensquare scaled 0.5pt;
	gdraw (sb,YRM+4)--(sb,YRM+6);
	gdraw (sc,YRM+4)--(sc,YRM+6);
	gdraw (sd,YRM+4)--(sd,YRM+6);
	gdraw (se,YRM+4)--(se,YRM+6);
	gdraw (sg,YRM+4)--(sg,YRM+6);

	gdraw (sb,YRP-0)--(sb,YRP-2);
	gdraw (sc,YRP-0)--(sc,YRP-2);
	gdraw (sd,YRP-0)--(sd,YRP-2);
	gdraw (se,YRP-0)--(se,YRP-2);
	gdraw (sg,YRP-0)--(sg,YRP-2);

	glabel.bot(btex \sf time (ms) etex scaled fontB, labelxA+0.5, YRM+6.8);
	glabel.bot( btex \sf 0.0 etex scaled fontB, 0.0, YRM+5);
	glabel.bot( btex \sf 1.25 etex scaled fontB, 1.25, YRM+5);
	glabel.bot( btex \sf 2.5 etex scaled fontB, 2.50, YRM+5);
	glabel.bot( btex \sf 7 etex scaled fontB, 7.00, YRM+5);
	glabel.bot( btex \sf 7.5 etex scaled fontB, 7.50, YRM+5);

	%---- Draw the Bfield ramps -----%
	lscale=1.0pt;	
	pickup pencircle scaled lscale;
	path p;
	gdata("dat/bfield.dat", $, augment.p($1, $2); );
	path pA;
	gdata("dat/bfield.dat", $, augment.pA($1, $2); );
	path pB;
	gdata("dat/bfield.dat", $, augment.pB($1, $2); );
	path pAA;
	gdata("dat/bfield.dat", $, augment.pAA($1, $2); );
	path pAB;
	gdata("dat/bfield.dat", $, augment.pAB($1, $2); );
	gdraw p;
	gdraw pA;
	gdraw pB;
	gdraw pAA;
	gdraw pAB;
 	%----- Draw a dashed line to indicate zero field ----%

	pickup pencircle scaled 0.1pt;
	gdraw (-0.1,0.0)--(7.5,0.0) dashed evenly scaled 0.2;

	glabel(btex $\sf dB_{z}\atop { (G/cm)}$ etex scaled fontA, labelxA+0.08, 15);
	glabel(btex \sf 26.1  etex scaled fontB, labelx, 26.1);
	glabel(btex \sf 4.4  etex scaled fontB, 0.6, 4.4);
	glabel(btex \sf 14.0  etex scaled fontB, 5.0, 14.0);
	glabel(btex \sf 0.0  etex scaled fontB, 8.00, 0.0);


	endgraph;

	%----- Draw RED turn off ramp -----%

	fontAAA=0.45;
	fontBBB=0.57;
	draw begingraph(graphX,graphY);
	autogrid(,);
	frame scaled 0.01 withpen pencircle scaled 0pt withcolor white;
	scaleB=410;
	offsetB=-250;
	setrange((-2.5,offsetB),(10,offsetB+scaleB));
	glabel(btex $\sf RED  $ etex scaled fontAAA, labelxA, 19);
	pickup pencircle scaled lscale;
	path pD;
	gdata("dat/trappow.dat", $, augment.pD($1, $2); );
	gdraw pD;
	path pDA;
	gdata("dat/trappow.dat", $, augment.pDA($1, $2); );
	gdraw pDA;
	path pDB;
	gdata("dat/trappow.dat", $, augment.pDB($1, $2); );
	gdraw pDB;
	pickup pencircle scaled 0.1pt;
	gdraw (-0.1,0.0)--(7.5,0.0) dashed evenly scaled 0.2;
	glabel(btex \sf OFF  etex scaled fontBBB, 5.00, 0.0);
	glabel(btex \sf ON etex scaled fontBBB, labelx, 34);
    	endgraph;

	%----- Draw UV Intensity -----%

	draw begingraph(graphX,graphY);
	autogrid(,);
	frame scaled 0.01 withpen pencircle scaled 0pt withcolor white;
	scaleE=12;
	offsetE=-5.2;
	setrange((-2.5,offsetE),(10,offsetE+scaleE));
	glabel(btex $\sf UV_{trap}$ etex scaled fontAAA, labelxA, 0.6);
	pickup pencircle scaled lscale;
	path pG;
	gdata("dat/uv_light.dat", $, augment.pG($1, $2); );
	gdraw pG;
	path pH;
	gdata("dat/uv_light.dat", $, augment.pH($1, $2); );
	gdraw pH;
	path pHA;
	gdata("dat/uv_light.dat", $, augment.pHA($1, $2); );
	gdraw pHA;
	path pHB;
	gdata("dat/uv_light.dat", $, augment.pHB($1, $2); );
	gdraw pHB;
	pickup pencircle scaled 0.1pt;
	gdraw (0.0,0.0)--(7.5,0.0) dashed evenly scaled 0.2;
	glabel(btex \sf OFF  etex scaled fontBBB, 8.00, 0.0);
	glabel(btex \sf ON  etex scaled fontBBB, 5.00, 1.0);
	glabel(btex \sf OFF	 etex scaled fontBBB, labelx, 0.0);
    	endgraph;

	%----- Draw UV repump Intensity -----%

	draw begingraph(graphX,graphY);
	autogrid(,);
	frame scaled 0.01 withpen pencircle scaled 0pt withcolor white;
	scaleF=12;
	offsetF=-3.1;
	setrange((-2.5,offsetF),(10,offsetF+scaleF));
	glabel(btex $\sf UV_{rep}$ etex scaled fontAAA, labelxA, 0.6);
	pickup pencircle scaled lscale;
	path pG;
	gdata("dat/uv_repump.dat", $, augment.pG($1, $2); );
	gdraw pG;
	path pH;
	gdata("dat/uv_repump.dat", $, augment.pH($1, $2); );
	gdraw pH;
	path pHA;
	gdata("dat/uv_repump.dat", $, augment.pHA($1, $2); );
	gdraw pHA;
	path pHB;
	gdata("dat/uv_repump.dat", $, augment.pHB($1, $2); );
	gdraw pHB;
	pickup pencircle scaled 0.1pt;
	gdraw (0.0,0.0)--(7.5,0.0) dashed evenly scaled 0.2;
	glabel(btex \sf OFF  etex scaled fontBBB, 8.00-0.3, 0.0);
	glabel(btex \sf ON  etex scaled fontBBB, 5.00, 1.0);
	glabel(btex \sf OFF	 etex scaled fontBBB, labelx, 0.0);
    	endgraph;

	%---- Draw UV detuning ----%

	draw begingraph(graphX,graphY);
	autogrid(,);
	frame scaled 0.01 withpen pencircle scaled 0pt withcolor white;
	scaleD=20;
	offsetD=-5.1;
	setrange((-2.5,offsetD),(10,offsetD+scaleD));
	glabel(btex $\sf \Delta_{UV}\atop { (\Gamma_{UV})}$ etex scaled fontA, labelxA+0.5, -2.8);
	pickup pencircle scaled lscale;
	path pE;
	gdata("dat/uvdet.dat", $, augment.pE($1, $2); );
%	gdraw pE dashed evenly scaled 0.2;
	path pF;
	gdata("dat/uvdet.dat", $, augment.pF($1, $2); );
	gdraw pF;
	path pFA;
	gdata("dat/uvdet.dat", $, augment.pFA($1, $2); );
	gdraw pFA;
	path pFB;
	gdata("dat/uvdet.dat", $, augment.pFB($1, $2); );
	gdraw pFB;
	pickup pencircle scaled 0.1pt;
	glabel(btex \sf -3.7  etex scaled fontB, 5.00, -1.2);
	glabel(btex \sf -6.0  etex scaled fontB, 0.62, -3.2);
    	endgraph;

endfig;

end

%     gdraw "bfield.dat" withcolor red;
%	  glabel.bot(btex time (ms) etex, OUT);
%	  glabel.lft(btex $I_{trap}/I_{sat}$ etex rotated 90, OUT);
%      glabel.rt(btex $I_{trap}= 6.8 I_{sat}$ etex, 0.1, 6.78);
%      glabel.ulft(btex $I_{trap,f}$ etex, 4.5,0.7);

%beginfig(2)
%    draw begingraph(6cm,4cm)
%      setrange(-0.5,0,4.5,4.4);
%      pickup pencircle scaled 2.5pt
%	  gdraw "bfield.dat" withcolor blue;
%	  gdraw "bfield.dat" withcolor green;
	  %glabel.bot(btex time (ms) etex, OUT);
	  %glabel.bot(btex $T_{r}=h^{2} / (2 m k_{b} \lambda^{2})=$ 15 $\mu$K etex, OUT);
      %glabel.bot(btex $T_{D}=h\gamma / (2 k_{b} )=$ 25 $\mu$K etex, OUT);
%	  glabel.bot(btex $I_{trap}=0.4 I_{sat}$ etex, OUT);
%	  glabel.lft(btex Detuning etex rotated 90, OUT);
%      glabel.rt(btex $\Delta_{trap}=-6.3 \Gamma$ etex, -0.4,0.35);
%	  glabel.lft(btex $\Delta_{trap}$ etex,  4.5,3.8);
%      glabel.rt(btex $\Delta_{rep}=-3.1 \Gamma$ etex, -0.4,4.1);
%	  glabel.lft(btex $\Delta_{rep}=-6.1 \Gamma$ etex, 4.5,0.45);
%	  autogrid(otick.bot,);
%    endgraph;
%endfig;
