% StdTemplate.cls
% http://blog.ankurdave.com/2009/04/creating-your-own-latex-document-class.html

% User-Definable Parameters
\newcommand{\HeaderLeft}[1]{\def \@HeaderLeft {#1}}
\newcommand{\HeaderRight}[1]{\def \@HeaderRight {#1}}

% Class Arguments
\ProvidesClass{StdTemplate}

% Dependencies
\NeedsTeXFormat{LaTeX2e}

% Derived from "article" class
\LoadClass[12pt]{article}

% Tilde Character
% https://tex.stackexchange.com/questions/9363/how-does-one-insert-a-backslash-or-a-tilde-into-latex
\newcommand{\myTilde}{\raise.17ex\hbox{$\scriptstyle\mathtt{\sim}$}}

% Page Encoding
\RequirePackage[utf8]{inputenc}

%% Required Packages

% [Geometry (of Page)]
\RequirePackage{geometry}
	\geometry{letterpaper}
	\geometry{margin=1in}

% [Graphics]
\RequirePackage[svgnames,table,hyperref]{xcolor}
\RequirePackage{graphicx} % Graphics Support
\DeclareGraphicsExtensions{.pdf,.jpeg,.png}
\RequirePackage{tikz} % Kitchen Sink
\RequirePackage{pdfpages} % Appendicies

% [Floats and Tables]
\RequirePackage{booktabs} % Improves Tables
\RequirePackage{multicol} % Multiple Columns
\RequirePackage{paralist} % Lists
\RequirePackage{subfig} % Sub-Figure Support
\RequirePackage{verbatim} % Multiple Columns

% [Enumerated Lists]
% Continue enumeration blocks (continuous numbering) with the \begin{enumerate}[resume]
\RequirePackage{enumitem}
%	\setenumerate[1]{label=\thesection.\arabic*.} % Make First Line of Enumeration the Section
	\setenumerate{label*=\arabic*.}

%% [Algorithms]
\RequirePackage{algorithm2e} % This is the nice one to work with
	
% [Bibliography]
\bibliographystyle{ieeetr}

%% [Captioning]
\RequirePackage{floatrow} % Has incompatibilities with float
	\floatsetup[figure]{capposition=bottom, objectset=centering}
	\floatsetup[table]{capposition=top, objectset=centering}
	\floatsetup[listing]{capposition=top, objectset=centering}

% [Header and Footer] Format
% http://mirror.hmc.edu/ctan/macros/latex/contrib/fancyhdr/fancyhdr.pdf
\RequirePackage{fancyhdr} % This should be set AFTER setting up the page geometry
	\pagestyle{fancy} % options: empty , plain , fancy
	\renewcommand{\headrulewidth}{1pt} % customise the layout...
	\fancyhf{}

% [Hyperlinks]
\RequirePackage[colorlinks = true, % Change to false is color hyperlinks are un-desired.
	linkcolor = blue,
	urlcolor  = blue,
	citecolor = blue,
	anchorcolor = blue]{hyperref} % Working Hyperlinks

% [Listings]
% https://tex.stackexchange.com/questions/18969/creating-a-zebra-effect-using-listings
% Credit: Martin Scharrer (Stack Exchage)
\RequirePackage{listings}

% [Mathematics]
\RequirePackage{array}
\RequirePackage[cmex10]{amsmath} % AMS Math, IEEE Xplore Compliance
\RequirePackage{amssymb} % AMS Symbols, IEEE Xplore Compliance

% [Titleing]
\RequirePackage{titling}
% https://tex.stackexchange.com/questions/27710/how-can-i-use-author-date-and-title-after-maketitle
\RequirePackage{titlesec}
	\titleformat*{\section}{\large\bfseries}
	\titleformat*{\subsection}{\normalsize\bfseries}
	\titleformat*{\subsubsection}{\normalsize\itshape}
%% ==== Bulk Customization ====
% Patch line number key to call line background macro
\lst@Key{numbers}{none}{%
    \def\lst@PlaceNumber{\lst@linebgrd}%
    \lstKV@SwitchCases{#1}%
    {none&\\%
     left&\def\lst@PlaceNumber{\llap{\normalfont
                \lst@numberstyle{\thelstnumber}\kern\lst@numbersep}\lst@linebgrd}\\%
     right&\def\lst@PlaceNumber{\rlap{\normalfont
                \kern\linewidth \kern\lst@numbersep
                \lst@numberstyle{\thelstnumber}}\lst@linebgrd}%
    }{\PackageError{Listings}{Numbers #1 unknown}\@ehc}}

% Listings Style
% https://en.wikibooks.org/wiki/LaTeX/Source_Code_Listings
\lstset{
	% Escape Sequences
	escapeinside={\%*}{*)}, % Embedded LaTeX
	%
	% Breaks / Pagination
	breaklines=true, % Break Long Lines
	breakatwhitespace=false, % Break anywhere
	keepspaces=true,
	columns=flexible,
	xleftmargin=0.5cm, % Left Margin
	xrightmargin=0.5cm, % Right Margin
	%
	% Frame
	frame=tb,
	framesep=1pt,		
	%
	% Numbers
	numbers=left,
	numberfirstline=true,
	stepnumber=1,
	numbersep=4pt,
	%
	% Typefacing / Colors
	basicstyle=\ttfamily\footnotesize, % Font Size
		% https://en.wikibooks.org/wiki/LaTeX/Fonts#Built-in_sizes
	commentstyle=\color{ForestGreen},
	keywordstyle=\color{NavyBlue},
	stringstyle=\color{FireBrick}, % string literal style
	linebackgroundcolor={\ifodd\value{lstnumber}\color{gray!20}\fi},
	showstringspaces=false % Disable String Spaces being Shown
}

%% Methods
% https://en.wikibooks.org/wiki/LaTeX/Macros
% Update Page Layout Using Fancyhdr
\newcommand{\UpdateHeaddings}{
	% Place Page Number in Center Header
	\chead{-\ \thepage\ -}

	% Place Course Number in Left Header
	\ifx \@HeaderLeft \@empty
		\lhead{}
	\else
		\lhead{\@HeaderLeft}
	\fi

	% Place Semester Designation in Right Header
	\ifx \@HeaderRight \@empty
		\rhead{}
	\else
		\rhead{\@HeaderRight}
	\fi
	
	% Clear Out Footer
	\lfoot{}\cfoot{}\rfoot{}
}

% Update Title Command
\renewcommand{\@maketitle}{
\newpage
\begin{center}
{\large\textit \@title \\[.8cm]}
\end{center}
\par}

% Custom Title Command
\newcommand{\TitlePage}{
	\maketitle
	\thispagestyle{fancy}
}

% Custom Abstract
\renewcommand\abstractname{Abstract}
