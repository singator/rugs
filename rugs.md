# Notes from user!2013 (RUGS)

## useR! 2013 conference

 - July 10-12
 - University of Castilla - La Mancha
 - Albacete, Spain
 - [conference website][r13]
 - [next conference][r14]

## Interesting companies

- Tibco
  - bought Insightful
  - Spotfire:
     - Get access to a broad array of predictive analytic and
       cutting-edge statistical analysis tools.
     - Develop analytics applications as much as five times faster.
     - Extend these tools with functions from a [contributed package][con]
  - Working on new S implementation
    - Brown (1984) > Blue (1988) > White (1992) > Green (1998)
      - Becker and Chambers (1984)
      - Becker, Chambers and Wilks (1988)
      - Chambers and Hastie (1992) 
      - Chambers (1998)
    - R is largely an implementation of blue and white
    - Chambers (2008) latest book focuses on Programming with R.

- Mango Solutions, UK (2002)
  - Consulting
  - Training
  - R validation

## Interesting concepts

- R 3.0.0 (Duncan Murdoch)
  - Versioning policy of R: x.y.z == ?
  - supports numeric indices 2**31 and larger:
    - `> x[2^31] <- y` on 64-bit machines
  - bounds checking when calling compiled code
  - Vignettes can now be written with engines other than Sweave.
    - engine that processes R code + documentation to create a latex
      file can be used, e.g. `knitr`. See this [page][rex] in the
      Writing R Extensions section
  - Dramatic increase in R users: why?

- Big Data R (Hadley Wickham) [full talk][big]
  - "visualisation reveals the unexpected but does not scale well;
     models scale well, but they are so precise that they seldom
     reveal new things"
  - reshape2
  - plyr
  - ggplot2
  - dplyr (new)
  - bigvis (new)

- MCMC or INLA
  - methods for Bayesian inference
     - R-INLA (Havard Rue)
     - BOOM (Steve Scott) (more general)
  - Google Correlate?

- Naming conventions
  - Inconsistent even in base R [read more][inc]
    - lowerCamelCase
    - upperCamelCase
    - alllowercase
    - period.separated
    - underscore_separated

## Interesting packages

- `data.table`
  - enhanced `data.frame`
    - keys to index rows
    - fast grouping
    - fast time series joins

## Must-learn (subjective)

- Shiny!
- knitr
- markdown

[r13]:http://www.edii.uclm.es/~useR-2013/
[r14]: http://user2014.stat.ucla.edu
[inc]: http://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf
[big]: http://bit.ly/bigrdata2
[con]: http://csan.insightful.com
[rex]: http://cran.r-project.org/doc/manuals/R-exts.html#Non_002dSweave-vignettes
