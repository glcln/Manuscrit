%%% File: PhDThesisED182.cls
%%% Brief: Document class template for ED182 thesis manuscript
%%% Use: \documentclass[showNotes, showLineNumbers, showWatermark]{PhDThesisED182}
%%% Author: Alexandre BIGOT, alexandre.bigot@iphc.cnrs.fr

%% Identification
%% The class identifies itself and the LaTeX version needed
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{PhDThesisED182}[2024-02-28 Minimal class for PhD thesis manuscript in ED182]


%% Load the article class file
\LoadClass[a4paper,12pt,openright]{book}


%% Templates for author's name and thesis title (for front and back covers)
\newcommand{\authorFirstname}{Gaël\xspace}
\newcommand{\authorName}{COULON\xspace}
\newcommand{\thesisTitle}{Recherche de particules exotiques fortement ionisantes dans l'expérience CMS}
\newcommand{\thesisSubTitle}{}


%% Load packages
\PassOptionsToPackage{T1}{fontenc}\RequirePackage{fontenc} % Standard package for selecting font encodings
\PassOptionsToPackage{comma,square,numbers,sort&compress}{natbib}\RequirePackage{natbib} % Flexible bibliography support
\PassOptionsToPackage{english}{babel}\RequirePackage{babel} % Multilingual support
\RequirePackage{fancyhdr} % Extensive control of page headers and footers
\RequirePackage{graphicx} % Enhanced support for graphics
\RequirePackage{xcolor} % Driver-independent color extensions
\RequirePackage{amsmath} % AMS mathematical facilities
\RequirePackage{amsfonts} % TeX fonts from the American Mathematical Society
\RequirePackage{xspace} % Define commands that appear not to eat spaces
\RequirePackage{xifthen} % Extended conditional commands
\RequirePackage{hyperref} % Extensive support for hypertext
\PassOptionsToPackage{most}{tcolorbox}\RequirePackage{tcolorbox} % Coloured boxes
\PassOptionsToPackage{nottoc}{tocbibind}\RequirePackage{tocbibind}  % Add bibliography/index/contents to Table of Contents
\RequirePackage{minitoc} % Produce a table of contents for each chapter, part or section
\PassOptionsToPackage{title}{appendix}\RequirePackage{appendix} % Extra control of appendices
\RequirePackage{geometry} % Flexible and complete interface to document dimensions
\RequirePackage{lineno} % Line numbers on paragraphs
\RequirePackage{mathrsfs}

\RequirePackage{physics}
\RequirePackage{tikz}
\RequirePackage{tikz-3dplot}
\usetikzlibrary{arrows.meta} % for arrow size
\usetikzlibrary{3d} % for canvas is
\usetikzlibrary{patterns.meta}
\RequirePackage[outline]{contour} % glow around text
\contourlength{0.9pt}
\usetikzlibrary{bending} % for arrow head angle
\RequirePackage{makecell}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage[nameinlink,noabbrev,capitalise]{cleveref}
\RequirePackage{relsize}
\RequirePackage{multirow}


%% Import packages and fefine commands for watermark
\RequirePackage{silence} % Selective filtering of error messages and warnings
    \WarningsOff[everypage] % Suppress warnings related to package everypage
\RequirePackage{everypage} % Provide hooks to be run on every page of a document
\PassOptionsToPackage{
    pages=some,
    angle=90,
    color=black!40,
    scale=1.5,
    position={-0.07\textwidth,-0.4\textheight},
    contents={PhD thesis \authorFirstname \authorName\xspace - \today}
    }{background}\RequirePackage{background}
% define a switch for class option showWatermark
\newif\ifshowWatermark
\AddEverypageHook{\ifshowWatermark\BgThispage\fi} % activate background for every page is showWatermark enabled

%% Define my colours
\definecolor{DarkBlue}{rgb}{0.0, 0.0, 0.55}
\definecolor{DarkRed}{rgb}{0.55, 0.0, 0.0}
\definecolor{DarkGreen}{rgb}{0.0, 0.2, 0.13}
\definecolor{DodgerBlue}{rgb}{0.12, 0.56, 1.0}
\colorlet{DodgerBlue2}{DodgerBlue!80}


%% Color commands
\newcommand{\mycolor}[2]{\color{#1}#2\color{black}\xspace}
\newcommand{\red}[1]{\color{red}#1\color{black}\xspace}


%% Change hyperlinks style
\hypersetup
{
    colorlinks=true,
    linkcolor=black,
    linktocpage=false, % to have the link on the page number in toc
    filecolor=magenta,
    urlcolor=DodgerBlue,
    citecolor=DodgerBlue,
}


%% Table of contents configuration
\addto\captionsenglish{% Replace "french" with the language you use
  \renewcommand{\contentsname}%
    {Table des matières}%
}
\setcounter{minitocdepth}{3} 
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\setlength{\mtcindent}{24pt} 
\renewcommand{\mtcfont}{\small\rm} 
\renewcommand{\mtcSfont}{\small\bf} 
\renewcommand{\mtctitle}{Contenu}


%% Section configuration | Change the numerotations of sections
    % \renewcommand{\thesection}{\Roman{section})}
    % \renewcommand{\thesubsection}{\Roman{section}.\arabic{subsection})}
    % \renewcommand{\thesubsubsection}{\Roman{section}.\arabic{subsection}.\alph{subsubsection})}


%% A simple box
\newenvironment{mybox}[0]{%
    \tcolorbox[opacityback=0., standard jigsaw,breakable]}%
    {\endtcolorbox}


%% Change left and right margins (used in front and back covers)
\newenvironment{changemargin}[2]{%
    \begin{list}{}{%
    \setlength{\topsep}{0pt}%
    \setlength{\leftmargin}{#1}%
    \setlength{\rightmargin}{#2}%
    \setlength{\listparindent}{\parindent}%
    \setlength{\itemindent}{\parindent}%
    \setlength{\parsep}{\parskip}%
    }%
    \item[]
}{\end{list}}


%% Save default margin lengths
\newlength{\defaultOddsidemargin}
\setlength{\defaultOddsidemargin}{\oddsidemargin}
\newlength{\defaultEvensidemargin}
\setlength{\defaultEvensidemargin}{\evensidemargin}

\geometry{
    bottom=2.5cm,
    headheight=14pt,        % fix fancyhdr warning
    % topmargin=-1.6pt      % optionnel, pour compenser
}


%% Figure environment with "This Thesis" mention
\newenvironment{figureThisThesis}[3][]
{%
% Parameters
%%%%%%%%%%%%%%%%%%%%
% #1 : figure placement specifier
% #2 : tune "This thesis" vertical position
% #3 : tune "This thesis" horizontal position

% template for argument #1
    \ifthenelse{\isempty{#1}}
        {\begin{figure}}
        {\begin{figure}[#1]}
% template for arguments #2 and #3
    \ifthenelse{\isempty{#2}\or\isempty{#3}}
        { % #2 or #3 empty
            \ifthenelse{\isempty{#2}\and\isempty{#3}}
                {\begin{minipage}[b][0.5cm][c]{\linewidth}} % #2 empty and #3 empty
                {
                    \ifthenelse{\isempty{#2}}
                        {\begin{minipage}[b][0.5cm][c]{#3}} % only #2 empty
                        {\begin{minipage}[b][#2][c]{\linewidth}} % only #3 empty
                }
        }
        { % #2 not empty and #3 not empty
            \begin{minipage}[b][#2][c]{#3}
        }
\hfill This Thesis
\end{minipage}
}
{\end{figure}}


%% Switches
\newif\ifshowNotes
    \newenvironment{notes}[1]{\ifshowNotes #1\fi}

\newif\ifshowLineNumbers 
%
%% Class options
\DeclareOption{showNotes}{\showNotestrue}
\DeclareOption{showLineNumbers}{\showLineNumberstrue}
\DeclareOption{showWatermark}{\showWatermarktrue}
\ProcessOptions\relax % to process options