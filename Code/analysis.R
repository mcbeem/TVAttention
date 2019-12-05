################################################################################
#                                                                              #
#   Script for creating the analysis dataset from raw NLSY data.               #
#     and for performing the data analysis.                                    #
#   Project: Challenging the Link Between Early Childhood Television Exposure  #
#     and Later Attention Problems: A Multiverse Analysis                      #
#   Investigators: Matt McBee, Wallace Dixon, & Rebecca Brand                  #
#   Programmers: Matthew McBee     mcbeem@etsu.edu    @TunnelofFire            #                                                     #
################################################################################

# This work is copyrighted by the authors and             
# licensed under a Creative Commons                       
# Attribution-NonCommercial 4.0 International License.    
# see https://creativecommons.org/licenses/by-nc/4.0/     
# for details.                                            

#################################################################################
#                                                                               #
#   IMPORTANT NOTICES TO METHODOLOGICAL TERRORISTS ;)                           #
#                                                                               #
# ** This code requires R 3.6+. It will not run on 3.5.x **                     #
# ** IF YOU ARE RUNNING THIS ON A LOCAL MACHINE:                                #
# ** OPEN THE R PROJECT FILE FIRST, THEN OPEN THIS SCRIPT **                    #
# ** OTHERWISE THE FILE PATHS WILL BE INCORRECT AND NOTHING WILL WORK **        #
#                                                                               #
#  THE DOCKER CONTAINER IS BUILT SUCH THAT THIS IS NOT NECESSARY, BUT IT IS     #
#  NOT HARMFUL, EITHER.                                                         #
#                                                                               #
#   YOU'VE BEEN WARNED ¯\_(ツ)_/¯                                               #
#                                                                               #
#################################################################################
#
# This code has been tested on Mac, Windows, and Linux platforms. Details below 
#
# See sessionInfo() dumps below for verified working package versions on Mac and 
#  Windows platforms. Also note that we have an online Docker image that can
#  reproduce all of our analyses.
#
# One more thing: this code requires several hours to run -- about 12 hours on 
#  a mid-2014 Macbook Pro (Core i5-2600ghz). Plan accordingly!
#
# sessionInfo() -----------------------------------------------------------
# > sessionInfo() for Mac (OSX)
# R version 3.6.1 (2019-07-05)
# Platform: x86_64-apple-darwin15.6.0 (64-bit)
# Running under: macOS Catalina 10.15
# 
# Matrix products: default
# BLAS:   /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
# LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# attached base packages:
#   [1] grid      stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] gridGraphics_0.4-1  ggExtra_0.9         extrafont_0.17      tibble_2.1.3       
# [5] dplyr_0.8.3         multcomp_1.4-10     TH.data_1.0-10      MASS_7.3-51.4      
# [9] mvtnorm_1.0-11      psych_1.8.12        cowplot_1.0.0       stringr_1.4.0      
# [13] mice_3.6.0          data.table_1.12.6   reshape2_1.4.3      broom_0.5.2        
# [17] stargazer_5.2.2     PSAgraphics_2.1.1   rpart_4.1-15        ggplot2_3.2.1      
# [21] twang_1.5           latticeExtra_0.6-28 RColorBrewer_1.1-2  lattice_0.20-38    
# [25] xtable_1.8-4        survey_3.36         survival_2.44-1.1   Matrix_1.2-17      
# [29] gbm_2.1.5           tidyr_1.0.0         here_0.1           
# 
# loaded via a namespace (and not attached):
#   [1] splines_3.6.1    shiny_1.4.0      assertthat_0.2.1 Rttf2pt1_1.3.7   pillar_1.4.2    
# [6] backports_1.1.5  glue_1.3.1       extrafontdb_1.0  digest_0.6.23    promises_1.1.0  
# [11] minqa_1.2.4      colorspace_1.4-1 sandwich_2.5-1   httpuv_1.5.2     htmltools_0.4.0 
# [16] plyr_1.8.4       pkgconfig_2.0.3  purrr_0.3.3      scales_1.1.0     later_1.0.0     
# [21] lme4_1.1-21      generics_0.0.2   withr_2.1.2      pan_1.6          nnet_7.3-12     
# [26] lazyeval_0.2.2   mnormt_1.5-5     mime_0.7         magrittr_1.5     crayon_1.3.4    
# [31] mitml_0.3-7      nlme_3.1-141     foreign_0.8-72   tools_3.6.1      mitools_2.4     
# [36] lifecycle_0.1.0  munsell_0.5.0    packrat_0.5.0    compiler_3.6.1   rlang_0.4.2     
# [41] nloptr_1.2.1     rstudioapi_0.10  miniUI_0.1.1.1   boot_1.3-22      gtable_0.3.0    
# [46] codetools_0.2-16 DBI_1.0.0        R6_2.4.1         gridExtra_2.3    zoo_1.8-6       
# [51] fastmap_1.0.1    zeallot_0.1.0    jomo_2.6-9       rprojroot_1.3-2  stringi_1.4.3   
# [56] parallel_3.6.1   Rcpp_1.0.3       vctrs_0.2.0      tidyselect_0.2.5

# also tested on Windows 10 machine with following sessionInfo()

# > sessionInfo()
# R version 3.6.1 (2019-07-05)
# Platform: x86_64-w64-mingw32/x64 (64-bit)
# Running under: Windows 10 x64 (build 17763)
# 
# Matrix products: default
# 
# locale:
#   [1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252   
# [3] LC_MONETARY=English_United States.1252 LC_NUMERIC=C                          
# [5] LC_TIME=English_United States.1252    
# 
# attached base packages:
#   [1] grid      stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] gridGraphics_0.4-1  ggExtra_0.9         extrafont_0.17      tibble_2.1.3       
# [5] dplyr_0.8.3         multcomp_1.4-10     TH.data_1.0-10      MASS_7.3-51.4      
# [9] mvtnorm_1.0-11      psych_1.8.12        cowplot_1.0.0       stringr_1.4.0      
# [13] mice_3.6.0          data.table_1.12.6   reshape2_1.4.3      broom_0.5.2        
# [17] stargazer_5.2.2     PSAgraphics_2.1.1   rpart_4.1-15        ggplot2_3.2.1      
# [21] twang_1.5           latticeExtra_0.6-28 RColorBrewer_1.1-2  lattice_0.20-38    
# [25] xtable_1.8-4        survey_3.36         survival_2.44-1.1   Matrix_1.2-17      
# [29] gbm_2.1.5           tidyr_1.0.0         here_0.1           
# 
# loaded via a namespace (and not attached):
#   [1] splines_3.6.1    shiny_1.4.0      assertthat_0.2.1 Rttf2pt1_1.3.7   pillar_1.4.2    
# [6] backports_1.1.5  glue_1.3.1       extrafontdb_1.0  digest_0.6.22    promises_1.1.0  
# [11] minqa_1.2.4      colorspace_1.4-1 sandwich_2.5-1   httpuv_1.5.2     htmltools_0.4.0 
# [16] plyr_1.8.4       pkgconfig_2.0.3  purrr_0.3.3      scales_1.1.0     later_1.0.0     
# [21] lme4_1.1-21      generics_0.0.2   withr_2.1.2      pan_1.6          nnet_7.3-12     
# [26] lazyeval_0.2.2   mnormt_1.5-5     mime_0.7         magrittr_1.5     crayon_1.3.4    
# [31] mitml_0.3-7      nlme_3.1-140     foreign_0.8-71   tools_3.6.1      mitools_2.4     
# [36] lifecycle_0.1.0  munsell_0.5.0    compiler_3.6.1   rlang_0.4.1      nloptr_1.2.1    
# [41] rstudioapi_0.10  miniUI_0.1.1.1   boot_1.3-22      gtable_0.3.0     codetools_0.2-16
# [46] DBI_1.0.0        R6_2.4.1         gridExtra_2.3    zoo_1.8-6        fastmap_1.0.1   
# [51] zeallot_0.1.0    jomo_2.6-10      rprojroot_1.3-2  stringi_1.4.3    parallel_3.6.1  
# [56] Rcpp_1.0.3       vctrs_0.2.0      tidyselect_0.2.5

# Load packages -----------------------------------------------------------
#
# Note: If you are running this code in the Docker image, the correct versions
#  of all these packages are pre-installed. 
# 
# It is possible that future updates to these packages will break the code. See
#  working version numbers above. 
#
# 
# install the required packages to your computer
# this only needs to be done once
# uncomment the following lines to download and install packages
# 
# install.packages("here")
# install.packages("tidyr")
# install.packages("twang")
# install.packages("survey")
# install.packages("ggplot2")
# install.packages("PSAgraphics")
# install.packages("stargazer")
# install.packages("broom")
# install.packages("reshape2")
# install.packages("data.table")
# install.packages("mice")
# install.packages("stringr")
# install.packages("cowplot")
# install.packages("psych")
# install.packages("multcomp")
# install.packages("dplyr")
# install.packages("tibble")
# install.packages("extrafont")
# install.packages("ggExtra")
# install.packages("gridGraphics")

# load the required packages
library(here)
library(tidyr)
library(twang)
library(survey)
library(ggplot2)
library(PSAgraphics)
library(stargazer)
library(broom)
library(reshape2)
library(data.table)
library(mice)
library(stringr)
library(cowplot)
library(psych)
library(multcomp)
library(dplyr)
library(tibble)
library(extrafont)
library(ggExtra)
library(gridGraphics)

# Make your system fonts available to R; only needs to be run once
#  this can take a few minutes, so I've commented it out
# font_import()
## Windows only. Uncomment and run to register fonts with R
## this is needed to make the figures use Times New Roman as intended
# loadfonts(device = "win")

# alter the criteria for printing numbers in scientific notation
options(scipen=10)

# Call (source) raw data processing scripts -------------------------------

#  When one downloads R data from NLSY (or our github site)
#   an R script is autogenerated that labels variables, recodes them, and sets up factors.
#   all one must do is pass the correct path to the file.

# running this code produces two dataframes:
#   "new_data", which is raw and
#   "categories" where every variable has been converted to a factor (with applied labels)

# this code calls those two scripts, which have only been altered to 
# use here() instead of fixed file paths

source(here("Code", "NLSY_CYA_rawdata_import.r"))
NLSY.cya.raw <- new_data
NLSY.cya.factors <- categories
# remove objects
rm(new_data, categories)

source(here("Code", "NLSY_rawdata_import.r"))
NLSY.raw <- new_data
NLSY.factors <- categories


# Create 1996 analysis dataset --------------------------------------------

########################################################################################
#                                                                                      #
#        Create analysis dataset for the 1996 Cohort (born circa 1988)                 #
#                                                                                      #
########################################################################################

# Variable inventory / codebook for analysis variables
#  childID :: Identifier for child :: categorical
#  momID :: Identifier for child's mother :: categorical
#  cohort :: Identifies 1996, 1998, or 2000 cohort :: factor
#  momRace :: Mom's racial / ethnic group :: factor
#  female :: dummy variable for female gender :: dummy 0/1
#  age :: Child's age at the final time point, should be ~7 :: continuous
#  attention :: Attention (BPI hyperactivity) at age 7 :: continuous :: mean of 5 BPI items
#  att_sex_ss :: Attention (BPI hyperactivity) within-gender standardized score :: continuous
#  temperament :: mean of five items :: continuous 
#  TV13 :: TV use in hours per day for 1-3 age range :: continuous
#  poorHealth :: Does child have health condition limiting usual activities? dummy 0/1
#  BMI :: circa age 2 :: continuous
#  lowBirthWt :: was birth weight less than 5 lbs 8 oz (2500g)? :: dummy 0/1
#  cogStm02 :: cognitive stimulation of home std score :: continuous
#  emoSupp13 :: emotional support of home std score :: continuous
#  momEdu :: highest grade completed by mom at first time point :: continuous
#  partnerEdu :: highest grade completed by spouse / partner at first time point :: continuous
#  kidsinHouse :: how many children of mother in the house at first time point? :: continuous
#  fatherAbsent :: does father live with mother at first time point? :: dummy 0/1
#  alcohol :: indicator of alcohol use during pregnancy :: dummy 0/1
#  smoke ::  indicator cigarettes smoked by mom during pregnancy :: dummy 0/1
#  momAge :: mother age at birth :: continuous
#  preterm :: was child born < 37 weeks gestation? :: dummy 0/1
#  income :: Total net family income at the first time point :: continuous
#  Rosen87 :: Rosenburg Self-Esteem score from 1987 :: continuous
#  CESD92 :: CES-D depression score from 1992 :: continuous
#  SMSA :: is R in a standard metro statistical area? measures urbanicity on a 
#    4 point scale :: factor
#  sampleWt :: child revised sample weight from index year :: continuous
#  gestationalAge :: gestational age of child, centered at 40 weeks :: continuous

# remove all discrete missing value flags (negative numbers) and replace with NA
NLSY.cya.raw[NLSY.cya.raw<0] <- NA
NLSY.raw[NLSY.raw<0] <- NA

# join raw and factors versions of the dataset together.
# all factor names will be preceeded by F_

names(NLSY.cya.factors) <- paste("F_", names(NLSY.cya.factors), sep="")
names(NLSY.factors) <- paste("F_", names(NLSY.factors), sep="")

NLSY.cya <- cbind(NLSY.cya.raw, NLSY.cya.factors)
NLSY <- cbind(NLSY.raw, NLSY.factors)

# sort (order) the NLSY.CYA data by mother ID then child ID
NLSY.cya <- NLSY.cya[order(NLSY.cya$C0000200, NLSY.cya$C0000100),]

# sort the NLSY data by mother ID
NLSY <- NLSY[order(NLSY$R0000100),]

# prior to merge, the primary key variable (momID) needs to have the same name in both datasets
NLSY.cya$momID <- NLSY.cya$C0000200
NLSY$momID <- NLSY$R0000100

# merge (inner join) the raw versions
NLSY.merged <- merge(NLSY.cya, NLSY, by="momID")

# apply exclusion criteria as per Christakis et al. (2004)
#  "In addition, children with any of the following 4 health conditions were excluded: 
#  serious hearing difficulty or deafness, serious difficulty in seeing or blindness, 
#  serious emotional disturbance, or crippled/orthopedic handicap."

# These items are NA if the child does not have the condition.
# This code excludes from the dataset all children that have ever had a 
#   positive response (e.g., non-missing) to any of these questions. 

NLSY.merged <- filter(NLSY.merged,
                       # child has serious difficulty hearing
                         #  88
                       is.na(C0594300) &
                         #  90
                       is.na(C0813300) &
                         #  92
                       is.na(C1003300) &
                         #  94
                       is.na(C1207000) &
                       # child has serious difficulty seeing
                         #  88
                       is.na(C0594400) &
                         #  90
                       is.na(C0813400) &
                         #  92
                       is.na(C1003400) &
                         #  94
                       # child is crippled or has serious orthopedic handicap
                         #  88
                       is.na(C1207100) &
                         #  90
                       is.na(C0594700) &
                         #  92
                       is.na(C0813700) &
                         #  94
                       is.na(C1003700) &
                       # child has serious emotional disturbance
                         #  88
                       is.na(C1207400) &
                         #  90
                       is.na(C0594500) &
                         #  92
                       is.na(C0813500) &
                         #  94
                       is.na(C1207200)
                    )
                 
### Begin creation of analysis variables ###

##################################################################################
#                                                                                #
#                         1996 Cohort                                            #
#                                                                                #
##################################################################################

# select cases where child's age at the last assessment is approximately 8 years
NLSY.1996 <- filter(NLSY.merged, (C0004743/12) >= 6.75, (C0004743/12) <= 8.75)
 
# Child ID
childID <- NLSY.1996$C0000100

# MomID
momID <- NLSY.1996$momID

# Cohort
cohort <- rep(1996, times=nrow(NLSY.1996))

# MomRace
race <- NLSY.1996$C0005300

# female: dummy variable for female gender, 0=male, 1=female
female <- NLSY.1996$C0005400-1

# Age at final time point , in years
age <- NLSY.1996$C0004743 / 12

# Attention
#  this code selects the relevant variables using select() (from dplyr)
#  and then applies the mean() function across the rows using apply() (MAR=1 for rowwise operation)
#  note: lower score indicates poorer attention
attention <- NLSY.1996 %>% dplyr::select(C1636700, C1636800, C1637300, C1637600, C1637700) %>% 
  apply(1, mean, na.rm=TRUE)

# update: add the within-sex standardized score
att_sex_ss <- NLSY.1996$C1561900

# Temperament
# this code does the following:
#   * for each possible set of temperament items (out of four), it calculates the number of missings
#   * these get bound together into a matrix (cbind()) with one row per child and one column (4)
#     per item set.
#  * a vector (which.temperament)is produced indicating which set of items (1,2,3, or 4) has the 
#    fewest missing values

which.temperament <- cbind(
    # these are the "TMP A (0-11mo) items from birth year 
   NLSY.1996 %>% dplyr::select(C0764600, C0764700, C0764900, C0765400, C0765500, C0765600) %>% 
     apply(c(1,2), is.na) %>% apply(1, sum),
    # these are the "TMP B (12-23mo) items from birth year
   NLSY.1996 %>% dplyr::select(C0765700, C0765800, C0766000, C0766500, C0766600, C0766700) %>% 
     apply(c(1,2), is.na) %>% apply(1, sum),
    # these are the "TMP A (0-11mo) items from birth year + 2
   NLSY.1996 %>% dplyr::select(C0967600, C0967700, C0967900, C0968400, C0968500, C0968600) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
    # these are the "TMP B (12-23mo) items from birth year + 2
   NLSY.1996 %>% dplyr::select(C0968700, C0968800, C0969000, C0969500, C0969600, C0969700) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum)
) %>% apply(1, which.min)

# all.temperament is a matrix where each column is the mean of one of the 4 sets of items

all.temperament <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.1996 %>% dplyr::select(C0764600, C0764700, C0764900, C0765400, C0765500, C0765600) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.1996 %>% dplyr::select(C0765700, C0765800, C0766000, C0766500, C0766600, C0766700) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.1996 %>% dplyr::select(C0967600, C0967700, C0967900, C0968400, C0968500, C0968600) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.1996 %>% dplyr::select(C0968700, C0968800, C0969000, C0969500, C0969600, C0969700) %>% 
    apply(1, mean, na.rm=T))

#  * each child's temperament score is the mean of the best (i.e., fewest missing) set of items, 
#      with preference to chronological earliest if there is a tie
#  * use the contents of which.temperament to index the columns of all.temperament

temperament <- all.temperament[cbind(1:nrow(all.temperament),which.temperament)]
rm(which.temperament, all.temperament)

# TV consumption, circa age ~1.5, in hours per day
# the 1996 cohort could have been born from March 1987 to March 1990 
#   (depending on interview date)
# this means their age 1.5-ish date could range from Sept 1988 to Sept 1991.
# NLSY does not have a TV variable from 1988, so only 1990 and 1992 interviews are used
# the oldest children could turn 1.5 in Sept 1991, so 1992 interview will be closest for them
# the Home A (0-2) item is selected


week1 <- ifelse(!is.na(NLSY.1996$C0953000), NLSY.1996$C0953000, #1990
                ifelse(!is.na(NLSY.1996$C1151100), NLSY.1996$C1151100, NA)) #1992

weekend1 <- ifelse(!is.na(NLSY.1996$C0953100), NLSY.1996$C0953100, #1990
                  ifelse(!is.na(NLSY.1996$C1151200), NLSY.1996$C1151200, NA)) #1992
  
# calculate the average hours per day 
TV1 <- ((week1*5) + (weekend1*2)) / 7
# cap > 16 hours per day at 16 as per Christakis et al.
TV1 <- ifelse(TV1>16, 16, TV1)

# TV consumption, circa age ~3, in hours per day
# the 1996 cohort could have been born from March 1987 to March 1990 
#   (depending on interview date)
# this means their age 3-ish date could range from Mar 1990 to Mar 1993.
# the Home B (3-5) item is selected
# order of preference: if 1992 is available, use it. If not, use 1990. If that's also
#   missing, use 1994.

week3 <-  ifelse(!is.na(NLSY.1996$C1154300), NLSY.1996$C1154300, #1992
              ifelse(!is.na(NLSY.1996$C0956200), NLSY.1996$C0956200, #1990
                   ifelse(!is.na(NLSY.1996$C1405500), NLSY.1996$C1405500, NA))) #1994

weekend3 <- ifelse(!is.na(NLSY.1996$C115440), NLSY.1996$C115440, #1992
                ifelse(!is.na(NLSY.1996$C0956300), NLSY.1996$C0956300, #1990
                       ifelse(!is.na(NLSY.1996$C1405600), NLSY.1996$C1405600, NA))) #1994

# calculate the average hours per day 
TV3 <- ((week3*5) + (weekend3*2)) / 7
# cap > 16 hours per day at 16 as per Christakis et al.
TV3 <- ifelse(TV3>16, 16, TV3)

# clean up
rm(week1, weekend1, week3, weekend3)

# Head Start :: dummy, 0=no, 1=yes
# note: missing for everyone in 1988 (1996 cohort)
headStart <- NLSY.1996$C0592000

# PoorHealth
#  dummy :: 0=no, 1=yes
# If there was at least one positive response to the question in the birth year or birth year + 2
#  "usual childhood activities" is the question
poorHealth <- ifelse(is.na(NLSY.1996$C0593200), NLSY.1996$C0812200, NLSY.1996$C0593200)
  
# BMI
#  calculated using forumula from 
#   https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_2.html
#   take BMI from the birth year if available, otherwise from birth year + 2

BMI_1 <- (NLSY.1996$C0606600 / ((NLSY.1996$C0606300*12)+ NLSY.1996$C0606400 )^2) * 703
BMI_2 <- (NLSY.1996$C0826700 / ((NLSY.1996$C0826400*12)+ NLSY.1996$C0826500 )^2) * 703
BMI <- ifelse(is.na(BMI_1), BMI_2, BMI_1)

rm(BMI_1, BMI_2)

# low birth weight :: was birth weight less than 5 lbs 8 oz (2500g)?
#  28.3495 is conversion factor from oz to grams
#  dummy code: 0=no, 1=yes
lowBirthWt <- (NLSY.1996$C0328600*28.3495 < 2500)*1

#  cogStim13 :: cognitive stimulation of home std score, age 2; replace with age 4 if NA :: continuous
cogStim13 <- ifelse(is.na(NLSY.1996$C0792000), NLSY.1996$C0992000, NLSY.1996$C0792000) / 10

#  emoSupp13 :: emotional support of home std core, age 2; replace with age 4 if NA :: continuous
emoSupp13 <- ifelse(is.na(NLSY.1996$C0792100), NLSY.1996$C0992100, NLSY.1996$C0792100) / 10

#  MomEdu :: highest grade completed by mom at first time point or next one if missing:: continuous
momEdu <- ifelse(is.na(NLSY.1996$C0061100), NLSY.1996$C0061112, NLSY.1996$C0061100)

#  highest grade completed by partner at first time point or next one if missing :: continuous
partner <- ifelse(is.na(NLSY.1996$C0120300), NLSY.1996$C0126900, NLSY.1996$C0120300)
#   :: highest grade completed by spouse at first time point or next one if missing :: continuous
spouse <- ifelse(is.na(NLSY.1996$C0120100), NLSY.1996$C0126600, NLSY.1996$C0120100)

#  keep highest grade completed by partner or spouse
partnerEdu <-ifelse(is.na(spouse), partner, spouse)

#  KidsinHouse :: how many children of mother 
#    in the house by birth year + 2 :: continuous
kidsInHouse <- ifelse(is.na(NLSY.1996$C0119800), NLSY.1996$C0126200, NLSY.1996$C0119800)

#  fatherAbsent :: does father live with mother at first available time point??  
#   dummy variable: 0=yes, 1=no
fatherAbsent <-1 - (ifelse(is.na(NLSY.1996$C0009700), NLSY.1996$C0010200, NLSY.1996$C0009700))

#  Alcohol :: dummy indicator of alcohol use during pregnancy in drinks per week :: factor
alcohol <- NLSY.1996$C0320200

#  Smoking ::  dummy indicator of cigarettes smoked by mom during pregnancy :: factor
smoking <- NLSY.1996$C0320400

#  MomAge :: mother age at birth :: continuous
momAge <- NLSY.1996$C0007000

#  PreTerm :: was child born < 37 weeks gestation? :: dummy, 0=no, 1=yes
preterm <-(NLSY.1996$C0328000<37)*1  

#  Income :: median Total net family income at first available time point  :: continuous
#     note: in thousands of dollars
income <- ifelse(is.na(NLSY.1996$R2870200), NLSY.1996$R3400700, NLSY.1996$R2870200) / 1000

#  SelfEsteem87 :: Rosenburg Self-Esteem score from 1987 :: continuous
Rosen87 <- (NLSY.1996$R2350020/10)-5

#  CESD92 :: CES-D depression score from 1992 :: continuous
CESD92 <- (NLSY.1996$R3896830/10)-5

#  SMSA :: is R in a standard metro statistical area? measures urbanicity on a 
#    4 point scale :: factor
SMSA <- ifelse(is.na(NLSY.1996$F_R2872800), NLSY.1996$R3403200, NLSY.1996$R2872800)

# gestationalAge :: gestational age in weeks, centered at 40 : continuous
gestationalAge <- NLSY.1996$C0328000 - 40

# revised sample weight from index year :: continuous
sampleWt <- NLSY.1996$C1565801

analysis1996 <- data.frame(cbind(childID, momID, cohort, race, female, age, temperament, attention, 
                      TV1, TV3, headStart, poorHealth, BMI, lowBirthWt, cogStim13, 
                      emoSupp13, momEdu, partnerEdu, kidsInHouse, fatherAbsent, alcohol, 
                      smoking, momAge, preterm, income, Rosen87, CESD92, SMSA, gestationalAge, sampleWt,
                      att_sex_ss))


# Create 1998 analysis dataset --------------------------------------------

##################################################################################
#                                                                                #
#                         1998 Cohort                                            #
#                                                                                #
##################################################################################

# clean up workspace
rm(childID, momID, cohort, race, female, age, temperament, attention, 
  TV1, TV3, headStart, poorHealth, BMI, lowBirthWt, cogStim13, 
  emoSupp13, momEdu, partnerEdu, 
  kidsInHouse, fatherAbsent, alcohol, smoking, 
  momAge, preterm, income, Rosen87, CESD92, SMSA, gestationalAge, sampleWt, 
  att_sex_ss)

# select cases where child's age at the last assessment is approximately 8 years
NLSY.1998 <- filter(NLSY.merged, (C0004744/12) >= 6.75, (C0004744/12) <= 8.75)

# Child ID
childID <- NLSY.1998$C0000100

# MomID
momID <- NLSY.1998$momID

# Cohort
cohort <- rep(1998, times=nrow(NLSY.1998))

# MomRace
race <- NLSY.1998$C0005300

# female: dummy variable for female gender, 0=male, 1=female
female <- NLSY.1998$C0005400-1

# Age at final time point , in years
age <- NLSY.1998$C0004744 / 12

# Attention
#  this code selects the relevant variables using select() (from dplyr)
#  and then applies the mean() function across the rows using apply() (MAR=1 for rowwise operation)
attention <- NLSY.1998 %>% dplyr::select(C1977600, C1977700, C1978200, C1978500, C1978600) %>% 
  apply(1, mean, na.rm=TRUE)
# update: add the within-sex standardized score
att_sex_ss <- NLSY.1998$C1797600

# Temperament
# this code does the following:
#   * for each possible set of temperament items (out of four), it calculates the number of missings
#   * these get bound together into a matrix (cbind()) with one row per child and one column (4)
#     per item set.
#  * a vector (which.temperament)is produced indicating which set of items (1,2,3, or 4) has the 
#    fewest missing values

which.temperament <- cbind( 
  # these are the "TMP A (0-11mo) items from birth year
  NLSY.1998 %>% dplyr::select(C0967600, C0967700, C0967900, C0968400, C0968500, C0968600) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.1998 %>% dplyr::select(C0968700, C0968800, C0969000, C0969500, C0969600, C0969700) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.1998 %>% dplyr::select(C1165900, C1166000, C1166200, C1166700, C1166800, C1166900) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.1998 %>% dplyr::select(C1167000, C1167100, C1167300, C1167800, C1167900, C1168000) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum)
) %>% apply(1, which.min)

# all.temperament is a matrix where each column is the mean of one of the 4 sets of items

all.temperament <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.1998 %>% dplyr::select(C0967600, C0967700, C0967900, C0968400, C0968500, C0968600) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.1998 %>% dplyr::select(C0968700, C0968800, C0969000, C0969500, C0969600, C0969700) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.1998 %>% dplyr::select(C1165900, C1166000, C1166200, C1166700, C1166800, C1166900) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.1998 %>% dplyr::select(C1167000, C1167100, C1167300, C1167800, C1167900, C1168000) %>% 
    apply(1, mean, na.rm=T))

#  * each child's temperament score is the mean of the best (i.e., fewest missing) set of items, 
#      with preference to chronological earliest if there is a tie
#  * use the contents of which.temperament to index the columns of all.temperament

temperament <- all.temperament[cbind(1:nrow(all.temperament),which.temperament)]
rm(which.temperament, all.temperament)

# TV consumption, circa age ~1.5, in hours per day
# the 1998 cohort could have been born from March 1989 to March 1992 
#   (depending on interview date)
# this means their age 1.5-ish date could range from Sept 1990 to Sept 1994.
# perference is given to 1992 because that is the most likely to be correct for 
#   most of the sample. if that is missing, the 1990 value is used. if that is missing too,
#   the 1994 value is used.
# the Home A (0-2) item is selected

week1 <- ifelse(!is.na(NLSY.1998$C1151100), NLSY.1998$C1151100,  # 1992
                ifelse(!is.na(NLSY.1998$C0953000), NLSY.1998$C0953000, # 1990
                       ifelse(!is.na(NLSY.1998$C1401900), NLSY.1998$C1401900, NA))) #1994

weekend1 <- ifelse(!is.na(NLSY.1998$C1151200), NLSY.1998$C1151200, #1992
                   ifelse(!is.na(NLSY.1998$C0953100), NLSY.1998$C0953100, #1990
                          ifelse(!is.na(NLSY.1998$C1402000), NLSY.1998$C1402000, NA))) #1994

# calculate the average hours per day 
TV1 <- ((week1*5) + (weekend1*2)) / 7
# cap > 16 hours per day at 16 as per Christakis et al.
TV1 <- ifelse(TV1>16, 16, TV1)

# TV consumption, circa age ~3, in hours per day
# the 1998 cohort could have been born from March 1989 to March 1992 
#   (depending on interview date)
# this means their age 3-ish date could range from Mar 1992 to Mar 1995.
# perference is given to 1994 because that is the most likely to be correct for 
#   most of the sample. if that is missing, the 1992 value is used. if that is missing too,
#   the 1996 value is used.
# the Home B (3-5) item is selected

week3 <- ifelse(!is.na(NLSY.1998$C1405500), NLSY.1998$C1405500, # 1994
                ifelse(!is.na(NLSY.1998$C1154300), NLSY.1998$C1154300, #1992
                       ifelse(!is.na(NLSY.1998$C1607200), NLSY.1998$C1607200, NA))) #1996

weekend3 <- ifelse(!is.na(NLSY.1998$C1405600), NLSY.1998$C1405600, # 1994 
                   ifelse(!is.na(NLSY.1998$C1154400), NLSY.1998$C1154400, # 1992
                          ifelse(!is.na(NLSY.1998$C1607300), NLSY.1998$C1607300, NA))) #1996

# calculate the average hours per day 
TV3 <- ((week3*5) + (weekend3*2)) / 7
# cap > 16 hours per day at 16 as per Christakis et al.
TV3 <- ifelse(TV3>16, 16, TV3)


# Head Start :: dummy, 0=no, 1=yes
# note: missing for everyone in 1988 (1998 cohort)
headStart <- NLSY.1998$C0592000

# PoorHealth
#  dummy :: 0=no, 1=yes
# If there was at least one positive response to the question in the birth year or birth year + 2
#  "usual childhood activities" is the question
poorHealth <- ifelse(is.na(NLSY.1998$C0812200), NLSY.1998$C1002200, NLSY.1998$C0812200)


# BMI
#  calculated using forumula from 
#   https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_2.html
#   take BMI from the birst year if available, otherwise from birth year + 2
BMI_1 <- (NLSY.1998$C0826700 / ((NLSY.1998$C0826400*12)+ NLSY.1998$C0826500)^2) * 703
BMI_2 <- (NLSY.1998$C1017000 / ((NLSY.1998$C1016700*12)+ NLSY.1998$C1016800 )^2) * 703
BMI <- ifelse(is.na(BMI_1), BMI_2, BMI_1)

rm(BMI_1, BMI_2)

# low birth weight :: was birth weight less than 5 lbs 8 oz (2500g)?
#  28.3495 is conversion factor from oz to grams
#  dummy code: 0=no, 1=yes
lowBirthWt <- (NLSY.1998$C0328600*28.3495 < 2500)*1

#  cogStim13 :: cognitive stimulation of home std score, age 2; replace with age 4 if NA :: continuous
cogStim13 <- ifelse(is.na(NLSY.1998$C0992000), NLSY.1998$C1192300, NLSY.1998$C0992000) / 10

#  emoSupp13 :: emotional support of home std core, age 2; replace with age 4 if NA :: continuous
emoSupp13 <- ifelse(is.na(NLSY.1998$C0992100), NLSY.1998$C1192400, NLSY.1998$C0992100) / 10

#  MomEdu :: highest grade completed by mom at first time point or next one if missing:: continuous
momEdu <- ifelse(is.na(NLSY.1998$C0061112), NLSY.1998$C0061116, NLSY.1998$C0061112)

#  highest grade completed by partner at first time point or next one if missing :: continuous
partner <- ifelse(is.na(NLSY.1998$C0126900), NLSY.1998$C0127628, NLSY.1998$C0126900)
#   :: highest grade completed by spouse at first time point or next one if missing :: continuous
spouse <- ifelse(is.na(NLSY.1998$C0126600), NLSY.1998$C0127625, NLSY.1998$C0126600)

#  keep highest grade completed by partner or spouse
partnerEdu <-ifelse(is.na(spouse), partner, spouse)

#  KidsinHouse :: how many children of mother 
#    in the house by birth year + 2 :: continuous
kidsInHouse <- ifelse(is.na(NLSY.1998$C0126200), NLSY.1998$C0127621, NLSY.1998$C0126200)

#  fatherAbsent :: does father live with mother at first available time point??  
#   dummy variable: 0=yes, 1=no
fatherAbsent <- 1 - (ifelse(is.na(NLSY.1998$C0010200), NLSY.1998$C0010700, NLSY.1998$C0010200))

#  Alcohol :: dummy indicator of alcohol use during pregnancy in drinks per week :: factor
alcohol <- NLSY.1998$C0320200

#  Smoking ::  dummy indicator of cigarettes smoked by mom during pregnancy :: factor
smoking <- NLSY.1998$C0320400

#  MomAge :: mother age at birth :: continuous
momAge <- NLSY.1998$C0007000

#  PreTerm :: was child born < 37 weeks gestation? :: dummy, 0=no, 1=yes
preterm <-(NLSY.1998$C0328000<37)*1 

#  Income :: median Total net family income at first available time point  :: continuous
#     note: in thousands of dollars
income <- ifelse(is.na(NLSY.1998$R3400700), NLSY.1998$R4006600, NLSY.1998$R3400700) / 1000

#  SelfEsteem87 :: Rosenburg Self-Esteem score from 1987 :: continuous
Rosen87 <- (NLSY.1998$R2350020/10)-5

#  CESD92 :: CES-D depression score from 1992 :: continuous
CESD92 <- (NLSY.1998$R3896830/10)-5

#  SMSA :: is R in a standard metro statistical area? measures urbanicity on a 
#    4 point scale :: factor
SMSA <- ifelse(is.na(NLSY.1998$R3403200), NLSY.1998$R4009100, NLSY.1998$R3403200)

# gestationalAge :: gestational age in weeks, centered at 40 : continuous
gestationalAge <- NLSY.1998$C0328000 - 40

# revised sample weight from index year :: continuous
sampleWt <- NLSY.1998$C1801201

analysis1998 <- data.frame(cbind(childID, momID, cohort, race, female, age, temperament, attention, 
                                 TV1, TV3, headStart, poorHealth, BMI, lowBirthWt, cogStim13, 
                                 emoSupp13, momEdu, partnerEdu, 
                                 kidsInHouse, fatherAbsent, alcohol, smoking, 
                                 momAge, preterm, income, Rosen87, CESD92, SMSA, gestationalAge, sampleWt,
                                 att_sex_ss))


# Create 2000 analysis dataset --------------------------------------------

##################################################################################
#                                                                                #
#                         2000 Cohort                                            #
#                                                                                #
##################################################################################

# clean up workspace
rm(childID, momID, cohort, race, female, age, temperament, attention, 
   TV1, TV3, headStart, poorHealth, BMI, lowBirthWt, cogStim13, 
   emoSupp13, momEdu, partnerEdu, 
   kidsInHouse, fatherAbsent, alcohol, smoking, 
   momAge, preterm, income, Rosen87, CESD92, SMSA, gestationalAge, sampleWt,
   att_sex_ss)

# select cases where child's age at the last assessment is approximately 8 years
NLSY.2000 <- filter(NLSY.merged, (C0004745/12) >= 6.75, (C0004745/12) <= 8.75)

# Child ID
childID <- NLSY.2000$C0000100

# MomID
momID <- NLSY.2000$momID

# Cohort
cohort <- rep(2000, times=nrow(NLSY.2000))

# MomRace
race <- NLSY.2000$C0005300

# female: dummy variable for female gender, 0=male, 1=female
female <- NLSY.2000$C0005400-1

# Age at final time point , in years
age <- NLSY.2000$C0004745 / 12

# Attention
#  this code selects the relevant variables using dplyr::select() (from dplyr)
#  and then applies the mean() function across the rows using apply() (MAR=1 for rowwise operation)
attention <- NLSY.2000 %>% dplyr::select(C2433200, C2433300, C2433800, C2434100, C2434200) %>% 
  apply(1, mean, na.rm=TRUE)
# update: add the within-sex standardized score
att_sex_ss <- NLSY.2000$C2499700

# Temperament
# this code does the following:
#   * for each possible set of temperament items (out of four), it calculates the number of missings
#   * these get bound together into a matrix (cbind()) with one row per child and one column (4)
#     per item set.
#  * a vector (which.temperament)is produced indicating which set of items (1,2,3, or 4) has the 
#    fewest missing values

which.temperament <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.2000 %>% dplyr::select(C1165900, C1166000, C1166200, C1166700, C1166800, C1166900) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.2000 %>% dplyr::select(C1167000, C1167100, C1167300, C1167800, C1167900, C1168000) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.2000 %>% dplyr::select(C1418300, C1418400, C1418600, C1419100, C1419200, C1419300) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum),
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.2000 %>% dplyr::select(C1419400, C1419500, C1419700, C1420200, C1420300, C1420400) %>% 
    apply(c(1,2), is.na) %>% apply(1, sum)
) %>% apply(1, which.min)

# all.temperament is a matrix where each column is the mean of one of the 4 sets of items

all.temperament <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.2000 %>% dplyr::select(C1165900, C1166000, C1166200, C1166700, C1166800, C1166900) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.2000 %>% dplyr::select(C1167000, C1167100, C1167300, C1167800, C1167900, C1168000) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.2000 %>% dplyr::select(C1418300, C1418400, C1418600, C1419100, C1419200, C1419300) %>% 
    apply(1, mean, na.rm=T),
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.2000 %>% dplyr::select(C1419400, C1419500, C1419700, C1420200, C1420300, C1420400) %>% 
    apply(1, mean, na.rm=T))

#  * each child's temperament score is the mean of the best (i.e., fewest missing) set of items, 
#      with preference to chronological earliest if there is a tie
#  * use the contents of which.temperament to index the columns of all.temperament

temperament <- all.temperament[cbind(1:nrow(all.temperament),which.temperament)]
rm(which.temperament, all.temperament)

# TV consumption, circa age ~1.5, in hours per day
# the 2000 cohort could have been born from March 1991 to March 1993 
#   (depending on interview date)
# this means their age 1.5-ish date could range from Sept 1992 to Sept 1995.
# perference is given to 1994 because that is the most likely to be correct for 
#   most of the sample. if that is missing, the 1992 value is used. if that is missing too,
#   the 1996 value is used.
# the Home A (0-2) item is selected

week1 <- ifelse(!is.na(NLSY.2000$C1401900), NLSY.2000$C1401900,  # 1994
                ifelse(!is.na(NLSY.2000$C1151100), NLSY.2000$C1151100, # 1992
                       ifelse(!is.na(NLSY.2000$C1603600), NLSY.2000$C1603600, NA))) #1996

weekend1 <- ifelse(!is.na(NLSY.2000$C1402000), NLSY.2000$C1402000, #1994
                   ifelse(!is.na(NLSY.2000$C1151200), NLSY.2000$C1151200, #1992
                          ifelse(!is.na(NLSY.2000$C1603700), NLSY.2000$C1603700, NA))) #1996

# calculate the average hours per day 
TV1 <- ((week1*5) + (weekend1*2)) / 7
# cap > 16 hours per day at 16 as per Christakis et al.
TV1 <- ifelse(TV1>16, 16, TV1)

# TV consumption, circa age ~3, in hours per day
# if the Home B (3-5) item is available in 1990, use it. otherwise use 1992. if that's missing,
# use 1994. Rationale: if a child has both a 3 and 5 YO response, the first one is the 3 YO.

week3 <- ifelse(!is.na(NLSY.2000$C1405500), NLSY.2000$C1405500, 
                ifelse(!is.na(NLSY.2000$C1607200), NLSY.2000$C1607200,
                       ifelse(!is.na(NLSY.2000$C1947800), NLSY.2000$C1947800, NA)))

weekend3 <- ifelse(!is.na(NLSY.2000$C1405600), NLSY.2000$C1405600, 
                   ifelse(!is.na(NLSY.2000$C1607300), NLSY.2000$C1607300,
                          ifelse(!is.na(NLSY.2000$C1947900), NLSY.2000$C1947900, NA)))

# calculate the average hours per day 
TV3 <- ((week3*5) + (weekend3*2)) / 7
# cap > 16 hours per day at 16 as per Christakis et al.
TV3 <- ifelse(TV3>16, 16, TV3)


# Head Start :: dummy, 0=no, 1=yes
# note: missing for everyone in 1988 (1998 cohort)
headStart <- NLSY.2000$C0592000

# PoorHealth
#  dummy :: 0=no, 1=yes
# If there was at least one positive response to the question in the birth year or birth year + 2
#  "usual childhood activities" is the question
poorHealth <- ifelse(is.na(NLSY.2000$C1002200), NLSY.2000$C1205900, NLSY.2000$C1002200)

# BMI
#  calculated using forumula from 
#   https://www.cdc.gov/nccdphp/dnpao/growthcharts/training/bmiage/page5_2.html
#   take BMI from the birth year if available, otherwise from birth year + 2
BMI_1 <- (NLSY.2000$C1017000 / ((NLSY.2000$C1016700*12)+ NLSY.2000$C1016800 )^2) * 703
BMI_2 <- (NLSY.2000$C1220500 / ((NLSY.2000$C1220200*12)+ NLSY.2000$C1220300 )^2) * 703
BMI <- ifelse(is.na(BMI_1), BMI_2, BMI_1)

rm(BMI_1, BMI_2)

# low birth weight :: was birth weight less than 5 lbs 8 oz (2500g)?
#  28.3495 is conversion factor from oz to grams
#  dummy code: 0=no, 1=yes
lowBirthWt <- (NLSY.2000$C0328600*28.3495 < 2500)*1

#  cogStim13 :: cognitive stimulation of home std score, age 2; replace with age 4 if NA :: continuous
cogStim13 <- ifelse(is.na(NLSY.2000$C1192300), NLSY.2000$C1500100, NLSY.2000$C1192300) / 10

#  emoSupp13 :: emotional support of home std core, age 2; replace with age 4 if NA :: continuous
emoSupp13 <- ifelse(is.na(NLSY.2000$C1192400), NLSY.2000$C1500200, NLSY.2000$C1192400) / 10

#  MomEdu :: highest grade completed by mom at first time point or next one if missing:: continuous
momEdu <- ifelse(is.na(NLSY.2000$C0061116), NLSY.2000$C0061120, NLSY.2000$C0061116)

#  highest grade completed by partner at first time point or next one if missing :: continuous
partner <- ifelse(is.na(NLSY.2000$C0127628), NLSY.2000$C0127928, NLSY.2000$C0127628)
#   :: highest grade completed by spouse at first time point or next one if missing :: continuous
spouse <- ifelse(is.na(NLSY.2000$C0127625), NLSY.2000$C0127925, NLSY.2000$C0127625)
#  keep highest grade completed by partner or spouse
partnerEdu <-ifelse(is.na(spouse), partner, spouse)

#  KidsinHouse :: how many children of mother
#    in the house by birth year + 2 :: continuous
kidsInHouse <- ifelse(is.na(NLSY.2000$C0127621), NLSY.2000$C0127921, NLSY.2000$C0127621)

#  fatherAbsent :: does father live with mother at first available time point??  
#   dummy variable: 0=yes, 1=no
fatherAbsent <-1 - (ifelse(is.na(NLSY.2000$C0010700), NLSY.2000$C0011112, NLSY.2000$C0010700))

#  Alcohol :: dummy indicator of alcohol use during pregnancy in drinks per week :: factor
alcohol <- NLSY.2000$C0320200

#  Smoking ::  dummy indicator of cigarettes smoked by mom during pregnancy :: factor
smoking <- NLSY.2000$C0320400

#  MomAge :: mother age at birth :: continuous
momAge <- NLSY.2000$C0007000

#  PreTerm :: was child born < 37 weeks gestation? :: dummy, 0=no, 1=yes
preterm <-(NLSY.2000$C0328000<37)*1 

#  Income :: median Total net family income at first available time point  :: continuous
#     note: in thousands of dollars
income <- ifelse(is.na(NLSY.2000$R4006600), NLSY.2000$R5080700, NLSY.2000$R4006600) / 1000

#  SelfEsteem87 :: Rosenburg Self-Esteem score from 1987 :: continuous
Rosen87 <- (NLSY.2000$R2350020/10)-5

#  CESD92 :: CES-D depression score from 1992 :: continuous
CESD92 <- (NLSY.2000$R3896830/10)-5

#  SMSA :: is R in a standard metro statistical area? measures urbanicity on a 
#    4 point scale :: factor
SMSA <- ifelse(is.na(NLSY.2000$R4009100), NLSY.2000$R5083200, NLSY.2000$R4009100)

# gestationalAge :: gestational age in weeks, centered at 40 : continuous
gestationalAge <- NLSY.2000$C0328000 - 40

# revised sample weight from index year :: continuous
sampleWt <- NLSY.2000$C2495501

analysis2000 <- data.frame(cbind(childID, momID, cohort, race, female, age, temperament, attention, 
                                 TV1, TV3, headStart, poorHealth, BMI, lowBirthWt, cogStim13, 
                                 emoSupp13, momEdu, partnerEdu, 
                                 kidsInHouse, fatherAbsent, alcohol, smoking, 
                                 momAge, preterm, income, Rosen87, CESD92, SMSA, gestationalAge, sampleWt,
                                 att_sex_ss))


# Create overall combined analysis dataset --------------------------------

##################################################################################
#                                                                                #
#                        Create anaylsis dataset                                 #
#                                                                                #
##################################################################################

data <- rbind(analysis1996, analysis1998, analysis2000)
data <- data.frame(data)

# make factors where needed

data$SMSA <- data$SMSA %>% 
  factor(labels=c("Not in SMSA", "SMSA; not central city", "SMSA; central city unknown", 
                  "SMSA; in central city"))

# create rurality variable for replicating original covariate set
data$rural <- ifelse(as.numeric(data$SMSA)==1, 1, 
                         ifelse(as.numeric(data$SMSA) %in% (2:4), 0, NA))

data$rural <- factor(data$rural, labels=c("Not rural", "Rural"))
                         
data$smoking <- data$smoking %>%
  factor(labels=c("No", "Yes"))

data$alcohol <-data$alcohol %>%
  factor(labels=c("No", "Yes"))

data$race <- data$race %>% 
  factor(labels=c("Hispanic", "Black", "White"))

data$cohort <- data$cohort %>%
  factor(labels=c("1996", "1998", "2000"))


# income has some questionable values: see text from the variable R4006600 description
# on the NLSY Explorer:
# NOTE: SEVERAL CASES HAVE BEEN DETECTED WHICH CONTAIN ONE OR MORE EXCEEDINGLY 
# HIGH INCOME VALUES, THAT APPEAR TO BE QUESTIONABLE WHEN COMPARED BOTH TO OTHER 
# 1992 INCOME VALUES, AND TO 1991 AND PRELIMINARY 1993 DATA FOR THE SAME CASES, 
# CHRR IS INVESTIGATING THESE DISCREPANCIES. THESE VALUES WERE NOT CHANGED FOR THE
# 1979-1992 DATA RELEASE. AS A RESULT, THESE HIGH VALUES WERE INCLUDED IN THE 
# SUBSET OF CASES TO BE TOP-CODED ON ONE OR MORE INCOME VARIABLES IN THIS 1992 
# RELEASE. THE AVERAGED VALUE ASSIGNED TO ALL RESPONDENTS REPORTING OVER A CERTAIN
# LEVEL OF INCOME DOES INCLUDE THE APPARENTLY EXCESSIVE VALUES FOR THESE 
# RESPONDENTS ON AFFECTED VARIABLES WILL BE RELEASED AS SOON AS THEY ARE 
# AVAILABLE. IN THE INTERIM, USERS SHOULD BE AWARE THAT THESE CASES EXIST AND MAY 
# HAVE AFFECTED THE TOP-CODING FOR SOME VARIABLES. THE FOLLOWING 8 CASES HAVE BEEN
# IDENTIFIED: 1620, 2894, 3546, 4226, 4289, 5723, 5940, 8963.

# if income is 839.078 (the untrustworthy value), set it to missing
data$income[data$income==839.078] <- NA
plot(density(data$income, na.rm=T))

# BMI has some totally wacky values
#  according to the CDC BMI-for-age charts, anything out of the 13-21 range is exceedingly unlikely
#  see https://www.cdc.gov/growthcharts/data/set2clinical/cj41l073.pdf 
#  and
#  https://www.cdc.gov/growthcharts/data/set2clinical/cj41l074.pdf
# set those out of range values to missing

data$BMI[data$BMI<13] <- NA
data$BMI[data$BMI>22] <- NA

plot(density(data$BMI, na.rm=T))

# momEdu and partnerEdu also has some out-of-range values
#  set anything above 24 to missing
data$momEdu[data$momEdu>24] <- NA
data$partnerEdu[data$partnerEdu>24] <- NA

# replace all NaNs in dataset
num.vars <- ncol(data)
for (i in 1:num.vars) {
  data[is.nan(as.numeric(data[,i])),i] <- NA
}

#### analysis data frame ####

# the analysis dataset will drop the ID variables, and the 
#  headStart variable (which is always NA)
analysis <- dplyr::select(data, -childID, -momID, -headStart)

# remove all cases with NAs on the attention variable
analysis <- analysis[!is.na(analysis$attention),]


# Make density plots of TV use at age ~1.5 and age ~3 ---------------------

# Figure: Density plot of TV consumption at age 1

p1 <- ggplot(data=analysis, aes(x=TV1))+geom_density()+theme_classic()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
      axis.title = element_text(family = "Times New Roman",size=11),
      legend.text=element_text(family="Times New Roman", size=7), 
      legend.title=element_text(family="Times New Roman", size=10),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank())+
      labs(x="Television hours per day for age ~1.5 yr", y=NULL)

d1 <- ggplot_build(p1)$data[[1]]
p1 <- p1 + geom_area(data = d1, aes(x=x, y=y), fill="gray", alpha=.4)
p1

ggsave(filename=here("Manuscript", "Figures", "fig_TV1_density.png"), 
       plot=p1, width=6, height=4, scale=1.2, dpi=200)

# Figure: Density plot of TV consumption at age ~3

p3 <- ggplot(data=analysis, aes(x=TV3))+geom_density()+theme_classic()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman",size=11),
        legend.text=element_text(family="Times New Roman", size=7), 
        legend.title=element_text(family="Times New Roman", size=10),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())+
  labs(x="Television hours per day for age ~3 yr", y=NULL)

d3 <- ggplot_build(p3)$data[[1]]
p3 <- p3 + geom_area(data = d3, aes(x=x, y=y), fill="gray", alpha=.4)
p3

ggsave(filename=here("Manuscript", "Figures", "fig_TV3_density.png"), 
       plot=p3, width=6, height=4, scale=1.2, dpi=200)


# Create marginal descriptive statistics tables ---------------------------

# save a copy of the analysis dataset 
# convert factors to numeric first
analysis.nofactors <- analysis

analysis.nofactors$race <- as.numeric(analysis$race)
analysis.nofactors$alcohol <- as.numeric(analysis$alcohol) - 1
analysis.nofactors$smoking <- as.numeric(analysis$smoking) - 1
analysis.nofactors$SMSA <- as.numeric(analysis$SMSA)
analysis.nofactors$rural <- as.numeric(analysis$rural) - 1


##### descriptive statistics ######

analysis.factors <- analysis
analysis.factors$female <- factor(analysis.factors$female, labels=c("Male", "Female"))
analysis.factors$poorHealth <- factor(analysis.factors$poorHealth, labels=c("No", "Yes"))
analysis.factors$preterm <- factor(analysis.factors$preterm, labels=c("No", "Yes"))
analysis.factors$lowBirthWt <- factor(analysis.factors$lowBirthWt, labels=c("No", "Yes"))
analysis.factors$fatherAbsent <- factor(analysis.factors$fatherAbsent, labels=c("No", "Yes"))

# functions to calculate summary statistics in the presence of missing data

Validn <- function(x) {length(which(!is.na(x)))}
Mean <- function(x) {mean(x, na.rm=T) %>% formatC(digits=2, format="f")}
Sd <- function(x) {sd(x, na.rm=T) %>% formatC(digits=2, format="f")}
Min <- function(x) {min(x, na.rm=T) %>% formatC(digits=2, format="f")}
Max <- function(x) {max(x, na.rm=T) %>% formatC(digits=2, format="f")}

# compute descriptives overall (marginal)
#   continuous variables

dtable <-analysis %>% 
  dplyr::select("Age (yrs) when attention was measured" = age,
       "Temperament" = temperament,
       "TV hours per day age 1.5" = TV1,
       "TV hours per day age 3" = TV3,
       "Cognitive stimulation of home age 1-3" = cogStim13,
       "Emotional support of home age 1-3" = emoSupp13,
       "Mother's years of schooling" = momEdu,
       "Partner's years of schooling" = partnerEdu,
       "Number of children in household" = kidsInHouse,
       "Mother's age at birth" = momAge,
       "Gestational age at birth" = gestationalAge,
       "Annual family income (thousands)" = income,
       "Rosenberg self-esteem score (1987)" = Rosen87,
       "CES-D Depression score (1992)" = CESD92,
       "Attention (raw)" = attention,
       "Attention within-sex SS" = att_sex_ss) %>%
  summarise_all(lst(Validn, Mean, Sd, Min, Max)) %>%
  gather(key, value, everything()) %>%
  separate(key, into=c("variable", "stat"), sep="_") %>%
  spread(stat, value) %>%
  dplyr::select(variable, Validn, Mean, Sd, Min, Max) 

names(dtable) <- c("Variable", "Valid n", "Mean", "Std Dev", "Min", "Max")

stargazer(dtable, summary=F, rownames=F, header=F,
          notes=" ", column.sep.width="20pt",
          type="text",
          out=here("Manuscript", "Tables", "table_descr_continuous.html"))

#   categorical variables

ctable <- 
  analysis.factors %>%
  gather(variable, value, cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
         alcohol, smoking, preterm, SMSA) %>%
  group_by(variable, value) %>%
  summarise (n = n()) %>%
  mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))

for (i in seq(nrow(ctable), 2, by=-1)) {
  if (ctable$variable[i] == ctable$variable[i-1]) {ctable$variable[i] <- ""}
}

ctable$variable <- 
  ifelse(ctable$variable=="alcohol", 
         "Maternal alcohol use during pregnancy", 
         ifelse(ctable$variable=="cohort",
                "Cohort", 
                ifelse(ctable$variable=="fatherAbsent", 
                       "Father is absent from household", 
                       ifelse(ctable$variable=="female",
                              "Female", 
                              ifelse(ctable$variable=="lowBirthWt",
                                     "Low Birth Weight", 
                                     ifelse(ctable$variable=="race",
                                            "Race",
                                            ifelse(ctable$variable=="smoking",
                                                   "Maternal smoking during pregnancy",
                                                   ifelse(ctable$variable=="SMSA",
                                                          "Standard metropolitan statistical area",
                                                          ifelse(ctable$variable=="poorHealth",
                                                                 "Health condition limiting school or play",
                                                                 ifelse(ctable$variable=="preterm",
                                                                        "Premature birth",
                                                          ctable$variable))))))))))
stargazer(ctable, summary=F, rownames=F, header=F,
          notes=" ", column.sep.width="20pt",
          out=here("Manuscript", "Tables", "table_descr_factor.html"))

# Export the analysis dataset as a CSV file -------------------------------

# save the analysis dataset
write.csv(analysis.nofactors, file=here("Data", "NLSY_analysis_dataset.csv"), 
          row.names=F)


# EFA of temperament to address reviewer concern --------------------------

#############################################################################
# address reviewer concern from Psychological Science round 1 submission:   #
# "Furthermore, the authors could possibly use factor analyses to           #
#  probe whether temperament and attentional problems are separate          #
#  constructs in an additional data-driven approach to supplement           #
#  their theoretical argumentation."                                        #
#############################################################################         

# first approach: correlation
cor(analysis$temperament, analysis$attention, use="complete.obs")
# write it to a file
write.table(
  paste0("The correlation between temperament and raw attention is ", 
         format(round(cor(analysis$temperament, analysis$attention, use="complete.obs"),3), nsmall=3), "<br>",
        "The correlation between temperament and within-sex standardized attention is ", 
         format(round(cor(analysis$temperament, analysis$att_sex_ss, use="complete.obs"),3), nsmall=3), ".<br>"),
  file=here("Manuscript", "Tables", "corr_temp_att.html"), row.names=F, col.names=F)

# second approach, factor analysis
# Prep 1996 data

# this ended up being quite complicated because the particular "item" variables
#  measured at different moments in time have different item codes in the NLSY
#  dataset. Generally all of these except one set will be missing depending on 
#  exactly how old the child was on the date that the mother was interviewed.
#
# ** Doubtless there is a more elegant way to accomplish this. **
#
# Step 1: figure out which set of items has the least missingness
#  This code selects the six items (4 different sets) and computes how 
#  many are missing. This gets placed in a matrix where each row is a subject,
#  and there are four columns correponding to the 4 different sets of possible
#  items. The numbers in each row are the number of missing values in each item.
#  set.
missing.temp.items.1996 <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.1996 %>% dplyr::select(C0764600, C0764700, C0764900, C0765400, C0765500, C0765600) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.1996 %>% dplyr::select(C0765700, C0765800, C0766000, C0766500, C0766600, C0766700) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.1996 %>% dplyr::select(C0967600, C0967700, C0967900, C0968400, C0968500, C0968600) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.1996 %>% dplyr::select(C0968700, C0968800, C0969000, C0969500, C0969600, C0969700) %>% 
    is.na() %>% apply(1, sum, na.rm=F)
)
# This code identifies which of the four sets has the minimum amount of missing
#  items responses. If there is a tie, the latest set is kept.
index1996 <- apply(missing.temp.items.1996, 1, 
                   function(x) {which(x==min(x))}) %>% lapply(max) %>% unlist()
# initialize and empty data frame to hold the temperament (and soon, attention)
#  item responses
temp1996 <- data.frame(matrix(rep(NA, 6), ncol=6, nrow=length(index1996)))
names(temp1996) <- c("temp1", "temp2", "temp3", "temp4", "temp5", "temp6")
# loop over the data, selecting the set of item responses with the 
#  least missingness as per the above
for (i in 1:length(index1996)) {
  if (index1996[i]==1) {
    temp1996$temp1[i] <- NLSY.1996$C0764600[i]
    temp1996$temp2[i] <- NLSY.1996$C0764700[i]
    temp1996$temp3[i] <- NLSY.1996$C0764900[i]
    temp1996$temp4[i] <- NLSY.1996$C0765400[i]
    temp1996$temp5[i] <- NLSY.1996$C0765500[i]
    temp1996$temp6[i] <- NLSY.1996$C0765600[i]
  }
  if (index1996[i]==2) {
    temp1996$temp1[i] <- NLSY.1996$C0765700[i]
    temp1996$temp2[i] <- NLSY.1996$C0765800[i]
    temp1996$temp3[i] <- NLSY.1996$C0766000[i]
    temp1996$temp4[i] <- NLSY.1996$C0766500[i]
    temp1996$temp5[i] <- NLSY.1996$C0766600[i]
    temp1996$temp6[i] <- NLSY.1996$C0766700[i]
  }
  if (index1996[i]==3) {
    temp1996$temp1[i] <- NLSY.1996$C0967600[i]
    temp1996$temp2[i] <- NLSY.1996$C0967700[i]
    temp1996$temp3[i] <- NLSY.1996$C0967900[i]
    temp1996$temp4[i] <- NLSY.1996$C0968400[i]
    temp1996$temp5[i] <- NLSY.1996$C0968500[i]
    temp1996$temp6[i] <- NLSY.1996$C0968600[i]
  }
  if (index1996[i]==4) {
    temp1996$temp1[i] <- NLSY.1996$C0968700[i]
    temp1996$temp2[i] <- NLSY.1996$C0968800[i]
    temp1996$temp3[i] <- NLSY.1996$C0969000[i]
    temp1996$temp4[i] <- NLSY.1996$C0969500[i]
    temp1996$temp5[i] <- NLSY.1996$C0969600[i]
    temp1996$temp6[i] <- NLSY.1996$C0969700[i]
  }
}
# append the attention items
temp1996$att1 <- NLSY.1996$C1636700
temp1996$att2 <- NLSY.1996$C1636800
temp1996$att3 <- NLSY.1996$C1637300
temp1996$att4 <- NLSY.1996$C1637600
temp1996$att5 <- NLSY.1996$C1637700

# Prep 1998 data

missing.temp.items.1998 <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.1998 %>% dplyr::select(C0967600, C0967700, C0967900, C0968400, C0968500, C0968600) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.1998 %>% dplyr::select(C0968700, C0968800, C0969000, C0969500, C0969600, C0969700) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.1998 %>% dplyr::select(C1165900, C1166000, C1166200, C1166700, C1166800, C1166900) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.1998 %>% dplyr::select(C1167000, C1167100, C1167300, C1167800, C1167900, C1168000) %>% 
    is.na() %>% apply(1, sum, na.rm=F)
)

index1998 <- apply(missing.temp.items.1998, 1, 
                   function(x) {which(x==min(x))}) %>% lapply(max) %>% unlist()

temp1998 <- data.frame(matrix(rep(NA, 6), ncol=6, nrow=length(index1998)))
names(temp1998) <- c("temp1", "temp2", "temp3", "temp4", "temp5", "temp6")

for (i in 1:length(index1998)) {
  if (index1998[i]==1) {
    temp1998$temp1[i] <- NLSY.1998$C0967600[i]
    temp1998$temp2[i] <- NLSY.1998$C0967700[i]
    temp1998$temp3[i] <- NLSY.1998$C0967900[i]
    temp1998$temp4[i] <- NLSY.1998$C0968400[i]
    temp1998$temp5[i] <- NLSY.1998$C0968500[i]
    temp1998$temp6[i] <- NLSY.1998$C0968600[i]
  }
  if (index1998[i]==2) {
    temp1998$temp1[i] <- NLSY.1998$C0968700[i]
    temp1998$temp2[i] <- NLSY.1998$C0968800[i]
    temp1998$temp3[i] <- NLSY.1998$C0969000[i]
    temp1998$temp4[i] <- NLSY.1998$C0969500[i]
    temp1998$temp5[i] <- NLSY.1998$C0969600[i]
    temp1998$temp6[i] <- NLSY.1998$C0969700[i]
  }
  if (index1998[i]==3) {
    temp1998$temp1[i] <- NLSY.1998$C1165900[i]
    temp1998$temp2[i] <- NLSY.1998$C1166000[i]
    temp1998$temp3[i] <- NLSY.1998$C1166200[i]
    temp1998$temp4[i] <- NLSY.1998$C1166700[i]
    temp1998$temp5[i] <- NLSY.1998$C1166800[i]
    temp1998$temp6[i] <- NLSY.1998$C1166900[i]
  }
  if (index1998[i]==4) {
    temp1998$temp1[i] <- NLSY.1998$C1167000[i]
    temp1998$temp2[i] <- NLSY.1998$C1167100[i]
    temp1998$temp3[i] <- NLSY.1998$C1167300[i]
    temp1998$temp4[i] <- NLSY.1998$C1167800[i]
    temp1998$temp5[i] <- NLSY.1998$C1167900[i]
    temp1998$temp6[i] <- NLSY.1998$C1168000[i]
  }
}

temp1998$att1 <- NLSY.1998$C1977600
temp1998$att2 <- NLSY.1998$C1977700
temp1998$att3 <- NLSY.1998$C1978200
temp1998$att4 <- NLSY.1998$C1978500
temp1998$att5 <- NLSY.1998$C1978600

# Prep 2000 data

missing.temp.items.2000 <- cbind(
  # these are the "TMP A (0-11mo) items from birth year 
  NLSY.2000 %>% dplyr::select(C1165900, C1166000, C1166200, C1166700, C1166800, C1166900) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP B (12-23mo) items from birth year
  NLSY.2000 %>% dplyr::select(C1167000, C1167100, C1167300, C1167800, C1167900, C1168000) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP A (0-11mo) items from birth year + 2
  NLSY.2000 %>% dplyr::select(C1418300, C1418400, C1418600, C1419100, C1419200, C1419300) %>% 
    is.na() %>% apply(1, sum, na.rm=F), 
  # these are the "TMP B (12-23mo) items from birth year + 2
  NLSY.2000 %>% dplyr::select(C1419400, C1419500, C1419700, C1420200, C1420300, C1420400) %>% 
    is.na() %>% apply(1, sum, na.rm=F)
)

index2000 <- apply(missing.temp.items.2000, 1, 
                   function(x) {which(x==min(x))}) %>% lapply(max) %>% unlist()

temp2000 <- data.frame(matrix(rep(NA, 6), ncol=6, nrow=length(index2000)))
names(temp2000) <- c("temp1", "temp2", "temp3", "temp4", "temp5", "temp6")

for (i in 1:length(index2000)) {
  if (index2000[i]==1) {
    temp2000$temp1[i] <- NLSY.2000$C1165900[i]
    temp2000$temp2[i] <- NLSY.2000$C1166000[i]
    temp2000$temp3[i] <- NLSY.2000$C1166200[i]
    temp2000$temp4[i] <- NLSY.2000$C1166700[i]
    temp2000$temp5[i] <- NLSY.2000$C1166800[i]
    temp2000$temp6[i] <- NLSY.2000$C1166900[i]
  }
  if (index2000[i]==2) {
    temp2000$temp1[i] <- NLSY.2000$C1167000[i]
    temp2000$temp2[i] <- NLSY.2000$C1167100[i]
    temp2000$temp3[i] <- NLSY.2000$C1167300[i]
    temp2000$temp4[i] <- NLSY.2000$C1167800[i]
    temp2000$temp5[i] <- NLSY.2000$C1167900[i]
    temp2000$temp6[i] <- NLSY.2000$C1168000[i]
  }
  if (index2000[i]==3) {
    temp2000$temp1[i] <- NLSY.2000$C1418300[i]
    temp2000$temp2[i] <- NLSY.2000$C1418400[i]
    temp2000$temp3[i] <- NLSY.2000$C1418600[i]
    temp2000$temp4[i] <- NLSY.2000$C1419100[i]
    temp2000$temp5[i] <- NLSY.2000$C1419200[i]
    temp2000$temp6[i] <- NLSY.2000$C1419300[i]
  }
  if (index2000[i]==4) {
    temp2000$temp1[i] <- NLSY.2000$C1419400[i]
    temp2000$temp2[i] <- NLSY.2000$C1419500[i]
    temp2000$temp3[i] <- NLSY.2000$C1419700[i]
    temp2000$temp4[i] <- NLSY.2000$C1420200[i]
    temp2000$temp5[i] <- NLSY.2000$C1420300[i]
    temp2000$temp6[i] <- NLSY.2000$C1420400[i]
  }
}

temp2000$att1 <- NLSY.2000$C2433200
temp2000$att2 <- NLSY.2000$C2433300
temp2000$att3 <- NLSY.2000$C2433800
temp2000$att4 <- NLSY.2000$C2434100
temp2000$att5 <- NLSY.2000$C2434200

########################################################3
# combine datasets
analysisEFA <- rbind(temp1996, temp1998, temp2000)

# Fit EFA models to data

# fit one-factor model
efa_1factor <- fa(r=analysisEFA, nfactors=1, fm="minres")

efa_1factor$Structure[1:11,] %>% data.frame() %>% 
  stargazer(summary=F, rownames=T, header=F, column.sep.width="20pt",
            type="text",
            out=here("Manuscript", "Tables", "temp_att_EFA_1factor.html"),
            title="EFA results",
            notes=c("Structure coefficients for a 1-factor solution"))

# fit two-factor model
efa_2factor <- fa(r=analysisEFA , nfactors=2, fm="minres", rotate="oblimin")

efa_2factor$Structure[1:11,] %>% data.frame() %>% 
  stargazer(summary=F, rownames=T, header=F, column.sep.width="20pt",
            type="text",
            out=here("Manuscript", "Tables", "temp_att_EFA_2factor.html"),
            title="EFA results",
            notes=c("Structure coefficients for a 2-factor solution",
                   "Minimum residual solution",
                   "Direct oblimin rotation"))

efa_2factor$Phi %>% data.frame() %>% 
  stargazer(summary=F, rownames=T, header=F, column.sep.width="20pt",
            type="text",
            out=here("Manuscript", "Tables", "temp_att_EFA_2factor_Phi.html"),
            title="EFA results",
            notes=c("Factor intercorrelation matrix for a 2-factor solution",
                    "Minimum residual solution",
                    "Direct oblimin rotation"))
            

# Make raw and residualized scatterplots for TV-attention relationship --------
##### Unadjusted and adjusted scatterplots of the TV-attention relationship at age 1.5 and 3
#####  Standardized attention outcome

# save residuals based on a model including all of both covariate sets except where redundant
#  e.g., rural and SMSA can't both be included because rural is just a coarser categorization
#  of SMSA. Same for preterm and gestationalAge, more or less.

# need to run model on complete data only to merge residuals back in
analysis.complete <- analysis[complete.cases(analysis),]

# calculate the attention residuals after controlling for all the covariates
#  note that TV is left out but all covariates are included
analysis.complete$resid.ss <- lm(data=analysis.complete, 
                                 att_sex_ss ~ age+temperament+cogStim13+emoSupp13+momEdu+partnerEdu+
                                   kidsInHouse+momAge+income+Rosen87+CESD92+gestationalAge+cohort+race+
                                   female+alcohol+fatherAbsent+smoking+SMSA+lowBirthWt+poorHealth)$resid

# identify rows from analysis dataframe that have missing data
analysis.missingrows <- !complete.cases(select(analysis, att_sex_ss, TV1, TV3,
                      age, temperament, cogStim13, emoSupp13, momEdu, partnerEdu, 
                      kidsInHouse, momAge, income, Rosen87, CESD92, gestationalAge, cohort, race, 
                      female, alcohol, fatherAbsent, smoking, SMSA, lowBirthWt, poorHealth))

# make a single multiply-imputed dataset for plotting
analysis.imputed <- mice(dplyr::select(analysis, att_sex_ss, TV1, TV3,
                                       age, temperament, cogStim13, emoSupp13, momEdu, partnerEdu, 
                                       kidsInHouse, momAge, income, Rosen87, CESD92, gestationalAge, cohort, race, 
                                       female, alcohol, fatherAbsent, smoking, SMSA, lowBirthWt, poorHealth),
                         method=c(rep("pmm", 15), rep("polyreg", 2), rep("pmm", 4), "polyreg", rep("pmm", 2)),
                         m=1, maxit=50) %>% complete()

# calculate the attention residuals after controlling for all the covariates
#  note that, as before, TV is left out but all covariates are included
analysis.imputed$resid.ss <- lm(data=analysis.imputed, 
                                 att_sex_ss ~ age+temperament+cogStim13+emoSupp13+momEdu+partnerEdu+
                                   kidsInHouse+momAge+income+Rosen87+CESD92+gestationalAge+cohort+race+
                                   female+alcohol+fatherAbsent+smoking+SMSA+lowBirthWt+poorHealth)$resid

# make the scatterplots
#  unadjusted standardized attention vs TV at age ~ 1.5
scatter.1.std.unadj <- ggplot(data=analysis, aes(x=TV1, y=att_sex_ss))+
  geom_jitter(shape=21, cex=.8, alpha=.65, fill="gray80", color="gray20", width=.2)+
  # display loess fitted line for complete data with shaded CI
  geom_line(stat="smooth", method="loess", color="blue", alpha=.7, cex=.9)+
  geom_ribbon(stat="smooth", method="loess", alpha=.1, se=T, level=.95, 
              fill="gray20")+
  labs(x="", y='Standardized Attention at Age 7')+
  theme_classic()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=9),
        axis.text = element_text(family = "Times New Roman", size=9),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10))

#  unadjusted standardized attention vs TV at age ~3
scatter.3.std.unadj <- ggplot(data=analysis, aes(x=TV3, y=att_sex_ss))+
  geom_jitter(shape=21, cex=.8, alpha=.65, fill="gray80", color="gray20", width=.2)+
  # display loess fitted line for complete data with shaded CI
  geom_line(stat="smooth", method="loess", color="blue", alpha=.7, cex=.9)+
  geom_ribbon(stat="smooth", method="loess", alpha=.1, se=T, level=.95, 
              fill="gray20")+
  labs(x="", y="")+
  theme_classic()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=9),
        axis.text = element_text(family = "Times New Roman", size=9),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10))

#  covariate-adjusted standardized attention vs TV at age ~1.5
scatter.1.std.adj <- ggplot(data=analysis.complete, aes(x=TV1, y=resid.ss))+
  # display points from complete data
  geom_jitter(shape=21, cex=.8, alpha=.65, fill="gray80", color="gray20", width=.2)+
  # add imputed datapoints
  geom_jitter(data=analysis.complete[analysis.missingrows,], aes(x=TV1, y=resid.ss),
               shape=4, cex=1.5, color="red", alpha=.45, width=.2)+
  # display loess fitted line for complete + imputed data with shaded CI
  geom_line(data=analysis.imputed, aes(x=TV1, y=resid.ss),stat="smooth", 
            method="loess", color="red", alpha=.7, cex=.9, linetype="dashed")+
  geom_ribbon(data=analysis.imputed, aes(x=TV1, y=resid.ss), stat="smooth", 
               method="loess", alpha=.2, 
               se=T, level=.95, fill="red")+
  # display loess fitted line for complete data with shaded CI
  geom_line(data=analysis.complete, aes(x=TV1, y=resid.ss),stat="smooth", 
            method="loess", color="blue", alpha=.7, cex=.9)+
  geom_ribbon(data=analysis.complete, aes(x=TV1, y=resid.ss), stat="smooth", 
              method="loess", alpha=.1, 
              se=T, level=.95, fill="gray20")+
  labs(x="TV consumption at Age ~1.5 (hours per day)", y='Covariate-adjusted Attention at Age 7')+
  theme_classic()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=9),
        axis.text = element_text(family = "Times New Roman", size=9),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10))

#  covariate-adjusted standardized attention vs TV at age ~3
scatter.3.std.adj <- ggplot(data=analysis.complete, aes(x=TV3, y=resid.ss))+
  # display points from complete data
  geom_jitter(shape=21, cex=.8, alpha=.65, fill="gray80", color="gray20", width=.2)+
  # add imputed datapoints
  geom_jitter(data=analysis.complete[analysis.missingrows,], aes(x=TV3, y=resid.ss),
              shape=4, cex=1.5, color="red", alpha=.45, width=.2)+
  # display loess fitted line for complete + imputed data with shaded CI
  geom_line(data=analysis.imputed, aes(x=TV3, y=resid.ss),stat="smooth", 
            method="loess", color="red", alpha=.7, cex=.9, linetype="dashed")+
  geom_ribbon(data=analysis.imputed, aes(x=TV3, y=resid.ss), stat="smooth", 
              method="loess", alpha=.2, 
              se=T, level=.95, fill="red")+
  # display loess fitted line for complete data with shaded CI
  geom_line(data=analysis.complete, aes(x=TV3, y=resid.ss),stat="smooth", 
            method="loess", color="blue", alpha=.7, cex=.9)+
  geom_ribbon(data=analysis.complete, aes(x=TV3, y=resid.ss), stat="smooth", 
              method="loess", alpha=.1, 
              se=T, level=.95, fill="gray20")+
  labs(x="TV consumption at Age ~3 (hours per day)", y='Covariate-adjusted Attention at Age 7')+
  theme_classic()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=9),
        axis.text = element_text(family = "Times New Roman", size=9),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10))

# set font and size for plot_grid panel labels
theme_set(theme_cowplot(font_size=14, font_family = "Times New Roman"))

# arrange panels in a grid
att_TV_scatterplots_std <- plot_grid(scatter.1.std.unadj, scatter.3.std.unadj, 
                                     scatter.1.std.adj, scatter.3.std.adj,
                                     labels=c("A", "B", "C", "D"),
                                     label_x=c(.83, .83, .83, .83))

ggsave(filename=here("Manuscript", "Figures", "scatterplots_std.png"),
       plot=att_TV_scatterplots_std, width=7, height=6, scale=1.0, dpi=200)

# define functions for multiverse analysis --------------------------------
#################################################################
#                                                               #
#   Define functions for performing the multiverse analysis     #
#                                                               #
#################################################################

    #################################################
    #                                               #
    #   Function for propensity score analysis      #
    #                                               #
    #################################################


# Define the function for propensity score analysis -----------------------

psa <- function(data, subdirectory, iterations, estimand, TVage, covariates, 
                method, TVpercentiles, strata=5, title=TRUE, order=1) {
  
  if(method=="stratification" & estimand=="ATT") {
    stop("Stratification should only be used to estimate ATE. Re-run with estimand=\"ATE\"")
  }
  
  # make temp copy of data frame
  df <- data
  
  # convert female and fatherAbsent variables to factors
  df$female <- factor(df$female, levels=c(0,1), labels=c("No", "Yes"))
  df$fatherAbsent <- factor(df$fatherAbsent,levels=c(0,1), labels=c("No", "Yes"))
  
  output_string <- paste0(method, "_", estimand, "_", "Age", TVage, "_", 
                          "Cut", str_c(as.character(TVpercentiles*10), collapse="-"), "_", covariates)
  
  title_string <- paste0("Estimand: ", estimand, ", TV age: ", 
                         ifelse(TVage==1, "~1.5", "~3"), ", TV cutpoint percentiles: ", 
                         ifelse(length(TVpercentiles)==2, 
                                str_c(as.character(TVpercentiles*100), collapse="/"), 
                                str_c(as.character(c(TVpercentiles, 1-TVpercentiles)*100), 
                                      collapse="/")), ", ", covariates, " covariate set")
  
  # create the TV variable according to the requested percentiles
  
  if (TVage=="1") {df$TV <- df$TV1} else
    if (TVage=="3") {df$TV <- df$TV3}
  
  TVquantiles <- quantile(df$TV, TVpercentiles, na.rm=T)
  if (length(TVquantiles) == 1) {TVquantiles <- rep(TVquantiles, 2)}
  
  df$TVcat <- ifelse(df$TV<=TVquantiles[1], 0, 
                     ifelse(df$TV>=TVquantiles[2], 1, NA))
  
  # remove all cases with NAs on the attention and TV variables
  df <- filter(df, !is.na(attention) & !is.na(TVcat))
  
  # check if path subdirectory for results exists
  # if not, create it
  
  if (!dir.exists(here(subdirectory, output_string))) {
    dir.create(here(subdirectory, output_string), showWarnings=F)
  } 
  
  if (covariates=="Original") {
    covs <- "cohort+age+cogStim13+emoSupp13+
              momEdu+kidsInHouse+momAge+Rosen87+CESD92+
              alcohol+fatherAbsent+female+gestationalAge+
              race+smoking+SMSA"
    
    ncovs <- 16
    
    cov.labels <- c(ifelse(TVage==1, 
                           "TV category (age ~1.5)", 
                           "TV category (age ~3)"), 
                    "Cohort = 1998", "Cohort = 2000", 
                    "Age at index", "Cognitive stimulation of home",
                    "Emotional support of home", "Maternal years of education",
                    "Children in the household", "Maternal age at birth",
                    "Maternal self-esteem (1987)", 
                    "Maternal depression (1992)", "Alcohol use in pregnancy",
                    "Father absent from household",
                    "Sex = female", "Gestational age at birth", "Race = Black", 
                    "Race = White", "Smoking in pregnancy", 
                    "SMSA; not central city", "SMSA; central city unknown", 
                    "SMSA; in central city",
                    "Intercept")
    
    # make descriptives table for continuous variables by group 
    dtable <-   
      melt(setDT(
        dplyr::select(df, 
                      "TV hours per day" = TV,
                      "Attention (raw)" = attention,
                      "Attention within-sex SS" = att_sex_ss,
                      "Age (yrs) when attention was measured" = age,
                      "Cognitive stimulation of home age 1-3" = cogStim13,
                      "Emotional support of home age 1-3" = emoSupp13,
                      "Mother's years of schooling" = momEdu,
                      "Number of children in household" = kidsInHouse,
                      "Mother's age at birth" = momAge,
                      "Rosenberg self-esteem score (1987)" = Rosen87,
                      "CES-D Depression score (1992)" = CESD92,
                      "Gestational age (in weeks relative to term)" = gestationalAge,
                      "TVgroup" = TVcat)),
        id=c("TVgroup"))[, .(mean = Mean(value),
                             sd = Sd(value),
                             n = Validn(value),
                             min = Min(value),
                             max = Max(value)),
                         .(TVgroup, variable)] %>%
      # reorder the variables
      dplyr::select(variable, TVgroup, n, mean, sd, min, max) 
    # give names
    names(dtable) <- c("Variable", "TVgroup", "Valid n", "Mean", "Std Dev", "Min", "Max")
    # convert Variable to character (somehow it became a factor)
    dtable$Variable <- as.character(dtable$Variable)
    # label the levels of TVgroup
    dtable$TVgroup <- factor(dtable$TVgroup, labels=c("Low", "High"))
    # replace the Variable field with blanks for every other row
    dtable$Variable[seq(2, nrow(dtable), by=2)] <- ""
    
    # write the table out
    # make the table and write it to a file
    if (title==T) {
      stargazer(dtable, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_continuous_", output_string, ".html")),
                title=paste0("Descriptive statistics for continuous variables by group<br>",
                             substr(title_string, 16, nchar(title_string))))
    } else {
      stargazer(dtable, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_continuous_", output_string, ".html")))
    }
    
    #   make descriptives table for categorical variables
    ctable <- 
      df %>% dplyr::select(TVcat, cohort, race, female, fatherAbsent,
                           alcohol, smoking, SMSA) %>%
      transmute_all(factor) %>% 
      gather(variable, value, cohort, race, female, fatherAbsent,
             alcohol, smoking, SMSA) %>% 
      group_by(TVcat, variable, value) %>%
      summarise (n = n()) %>%
      mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
    
    # label the levels of the TVcat variable
    ctable$TVcat <- factor(ctable$TVcat, labels=c("Low", "High"))
    
    # merge the low and high-TV descriptives horizontally
    ctable2 <- merge(
      filter(ctable, TVcat=="Low"),
      filter(ctable, TVcat=="High"),
      by=c("variable", "value"))
    
    # sort within groups so NA is always last
    ctable2 <- ctable2 %>% group_by(variable) %>% 
      dplyr::arrange(value, .by_group=T)
    
    # set variable names
    names(ctable2) <- c("Variable", "Value", "Low TV",  "N", "Percent", "High TV", "N", "Percent")
    
    # get rid of repeated names in the Variable field
    for (i in seq(nrow(ctable2), 2, by=-1)) {
      if (ctable2$Variable[i] == ctable2$Variable[i-1]) {ctable2$Variable[i] <- ""}
    }
    
    # convert factors in the Value variable  to character and label
    #  1=Yes, 0=No
    ctable2$Value <- as.character(ctable2$Value)
    ctable2$Value <- ifelse(ctable2$Value=="1", "Yes", 
                            ifelse(ctable2$Value=="0", "No", ctable2$Value))
    
    # remove all the values in the Low TV and High TV columns
    #  (keep these columns in the table header
    ctable2[, c(3,6)] <- ""
    
    # change NAs (which render as blanks) to "(missing)" in the table
    ctable2$Value <- ifelse(is.na(ctable2$Value), "(missing)", 
                            ctable2$Value)
    
    ctable2$Variable <- 
      ifelse(ctable2$Variable=="alcohol", 
             "Maternal alcohol use during pregnancy", 
             ifelse(ctable2$Variable=="cohort",
                    "Cohort", 
                    ifelse(ctable2$Variable=="fatherAbsent", 
                           "Father is absent from household", 
                           ifelse(ctable2$Variable=="female",
                                  "Female", 
                                  ifelse(ctable2$Variable=="lowBirthWt",
                                         "Low Birth Weight", 
                                         ifelse(ctable2$Variable=="race",
                                                "Race",
                                                ifelse(ctable2$Variable=="smoking",
                                                       "Maternal smoking during pregnancy",
                                                       ifelse(ctable2$Variable=="SMSA",
                                                              "Standard metropolitan statistical area",
                                                              ctable2$Variable))))))))
    
    # make the table and write it to a file
    if (title==T) {
      stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_categorical_", output_string, ".html")),
                title=paste0("Descriptive statistics for categorical variables by group<br>",
                             substr(title_string, 16, nchar(title_string))))
    } else {
      stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_categorical_", output_string, ".html")))
    }
    
  } else if (covariates=="Expanded") {
    covs <- "cohort+age+temperament+cogStim13+emoSupp13+momEdu+partnerEdu+kidsInHouse+
              momAge+income+Rosen87+CESD92+alcohol+fatherAbsent+female+lowBirthWt+
              poorHealth+preterm+race+smoking+SMSA"
    
    ncovs <- 21
    
    cov.labels <- c(ifelse(TVage==1, 
                           "TV category (age ~1.5)", 
                           "TV category (age ~3)"),  
                    "Cohort = 1998", "Cohort = 2000", 
                    "Age at index", "Temperament", 
                    "Cognitive stimulation of home",
                    "Emotional support of home", 
                    "Maternal years of education",
                    "Partner years of education",
                    "Children in the household", "Maternal age at birth",
                    "Family income ($k)", "Maternal self-esteem (1987)", 
                    "Maternal depression (1992)", "Alcohol use during pregnancy",
                    "Father absent from household", "Sex = female", 
                    "Low birth weight", "Child poor health", "Preterm delivery", 
                    "Race = Black", "Race = White", "Smoking in pregnancy", 
                    "SMSA; not central city", "SMSA; central city unknown", 
                    "SMSA; in central city", "Intercept")
    
    # make descriptives table for continuous variables by group 
    dtable <-   
      melt(setDT(
        dplyr::select(df, 
                      "TV hours per day" = TV,
                      "Attention (raw)" = attention,
                      "Attention within-sex SS" = att_sex_ss,
                      "Age (yrs) when attention was measured" = age,
                      "Temperament" = temperament,
                      "Cognitive stimulation of home age 1-3" = cogStim13,
                      "Emotional support of home age 1-3" = emoSupp13,
                      "Mother's years of schooling" = momEdu,
                      "Partner's years of schooling" = partnerEdu,
                      "Number of children in household" = kidsInHouse,
                      "Mother's age at birth" = momAge,
                      "Annual family income (thousands)" = income,
                      "Rosenberg self-esteem score (1987)" = Rosen87,
                      "CES-D Depression score (1992)" = CESD92,
                      "TVgroup" = TVcat)),
        id=c("TVgroup"))[, .(mean = Mean(value),
                             sd = Sd(value),
                             n = Validn(value),
                             min = Min(value),
                             max = Max(value)),
                         .(TVgroup, variable)] %>%
      # reorder the variables
      dplyr::select(variable, TVgroup, n, mean, sd, min, max) 
    # give names
    names(dtable) <- c("Variable", "TVgroup", "Valid n", "Mean", "Std Dev", "Min", "Max")
    # convert Variable to character (somehow it became a factor)
    dtable$Variable <- as.character(dtable$Variable)
    # label the levels of TVgroup
    dtable$TVgroup <- factor(dtable$TVgroup, labels=c("Low", "High"))
    # replace the Variable field with blanks for every other row
    dtable$Variable[seq(2, nrow(dtable), by=2)] <- ""
    
    # write the table out
    # make the table and write it to a file
    if (title==T) {
      stargazer(dtable, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_continuous_", output_string, ".html")),
                title=paste0("Descriptive statistics for continuous variables by group<br>",
                             substr(title_string, 16, nchar(title_string))))
    } else {
      stargazer(dtable, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                paste0("descriptives_continuous_", output_string, ".html"))
      
    }
    
    #   make descriptives table for categorical variables
    ctable <- 
      df %>% dplyr::select(TVcat, cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
                           alcohol, smoking, preterm, SMSA) %>%
      transmute_all(factor) %>% 
      gather(variable, value, cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
             alcohol, smoking, preterm, SMSA) %>% 
      group_by(TVcat, variable, value) %>%
      summarise (n = n()) %>%
      mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
    
    # label the levels of the TVcat variable
    ctable$TVcat <- factor(ctable$TVcat, labels=c("Low", "High"))
    
    # merge the low and high-TV descriptives horizontally
    ctable2 <- merge(
      filter(ctable, TVcat=="Low"),
      filter(ctable, TVcat=="High"),
      by=c("variable", "value"))
    
    # sort within groups so NA is always last
    ctable2 <- ctable2 %>% group_by(variable) %>% 
      dplyr::arrange(value, .by_group=T)
    
    # set variable names
    names(ctable2) <- c("Variable", "Value", "Low TV",  "N", "Percent", "High TV", "N", "Percent")
    
    # get rid of repeated names in the Variable field
    for (i in seq(nrow(ctable2), 2, by=-1)) {
      if (ctable2$Variable[i] == ctable2$Variable[i-1]) {ctable2$Variable[i] <- ""}
    }
    
    # convert factors in the Value variable  to character and label
    #  1=Yes, 0=No
    ctable2$Value <- as.character(ctable2$Value)
    ctable2$Value <- ifelse(ctable2$Value=="1", "Yes", 
                            ifelse(ctable2$Value=="0", "No", ctable2$Value))
    
    # remove all the values in the Low TV and High TV columns
    #  (keep these columns in the table header
    ctable2[, c(3,6)] <- ""
    
    # change NAs (which render as blanks) to "(missing)" in the table
    ctable2$Value <- ifelse(is.na(ctable2$Value), "(missing)", 
                            ctable2$Value)
    
    ctable2$Variable <- 
      ifelse(ctable2$Variable=="alcohol", 
             "Maternal alcohol use during pregnancy", 
             ifelse(ctable2$Variable=="cohort",
                    "Cohort", 
                    ifelse(ctable2$Variable=="fatherAbsent", 
                           "Father is absent from household", 
                           ifelse(ctable2$Variable=="female",
                                  "Female", 
                                  ifelse(ctable2$Variable=="lowBirthWt",
                                         "Low Birth Weight", 
                                         ifelse(ctable2$Variable=="poorHealth",
                                                "Poor health",
                                                ifelse(ctable2$Variable=="preterm",
                                                       "Preterm birth",
                                                       ifelse(ctable2$Variable=="race",
                                                              "Race",
                                                              ifelse(ctable2$Variable=="rural",
                                                                     "Rural",
                                                                     ifelse(ctable2$Variable=="smoking",
                                                                            "Maternal smoking during pregnancy",
                                                                            ifelse(ctable2$Variable=="SMSA",
                                                                                   "Standard metropolitan statistical area",
                                                                                   ctable2$Variable)))))))))))
    
    # make the table and write it to a file
    if (title==T) {
      stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_categorical_", output_string, ".html")),
                title=paste0("Descriptive statistics for categorical variables by group<br>",
                             substr(title_string, 16, nchar(title_string))))
    } else {
      stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string, 
                         paste0("descriptives_categorical_", output_string, ".html")))
    }
  }
  
  # set the random number seed
  set.seed(1)
  
  # fit the propensity score model with boosted classification trees
  
  ps.analysis <- ps(as.formula(c("TVcat ~ ", covs)),
                    data = df,
                    distribution="Bernoulli",
                    n.trees=iterations,
                    interaction.depth=3,
                    shrinkage=.005,
                    bag.fraction=.8,
                    cv.folds=2,
                    n.minobsinnode=5,
                    train.fraction = 1,
                    perm.test.iters = 0, 
                    estimand = estimand,
                    stop.method="ks.max")
  
  # create cross-classification table and calculate model hit rate
  hittable <- table(as.numeric((unlist(round(ps.analysis$ps,0)))), 
                    ps.analysis$treat)
  # hitrate
  hitrate <- sum(diag(hittable))/sum(hittable)
  
  relative.inf <- summary(ps.analysis$gbm.obj, n.trees = ps.analysis$desc$ks.max$n.trees)
  
  relative.inf$var <- factor(relative.inf$var, 
                             levels = relative.inf$var[order(relative.inf$rel.inf)])
  
  p <- ggplot(relative.inf , aes(x=factor(var), y=rel.inf, fill=log(rel.inf)))+
    geom_bar(stat="identity", col="black", cex=.2, show.legend=FALSE) + coord_flip() + theme_classic()+
    ylab("Relative Influence")+xlab("")+
    theme(text=element_text(family="Times New Roman"))
  if (title==T) {p <- p + ggtitle(
    paste0("Relative influence of each covariate on the propensity score\n", 
           title_string))+
    theme(plot.title=element_text(size=10, hjust=.5, 
                                  family="Times New Roman"))}
  
  ggsave(filename=here(subdirectory, output_string, 
                       paste0("pscore_var_contribution_", output_string, ".png")),
         plot=p, width=5.5, height=4, scale=1.1, dpi=200)
  
  #plot relationship between each variable and the probability of TV=high
  p <- list()
  for (i in 1:ncovs) {
    p[[i]] <-  plot(ps.analysis$gbm.obj, i.var=i, 
                    n.trees=ps.analysis$desc$ks.max$n.tree, 
                    ylab="", cex.axis=.6, las=2,
                    main="", ann=FALSE, xact=NULL)
  }
  
  plots <- cowplot::plot_grid(plotlist=p)
  
  if (title==TRUE) {
    plots <- plots +  ggtitle(paste0(
      paste0("Relationship between each covariate and the logit probability of being in the high-TV group\n", 
             title_string)))+
      theme(plot.title=element_text(size=20, hjust=.5, 
                                    family="Times New Roman"))
  } 
  
  ggsave(filename=here(subdirectory, output_string, 
                       paste0("pscore_var_relationships_", output_string, ".png")), 
         plot=plots, width=10, height=7, scale=1.5, dpi=200)
  
  # append the propensity scores to the data frame
  #  naughty! this relies on partial matching. The list component's
  #  full name is either ks.max.ATE or ks.max.ATT
  df$pscores <- ps.analysis$ps$ks.max
  
  # make a plot of the distribution of the propensity scores in the two groups
  p <- ggplot(data=df, aes(pscores, fill=factor(TVcat, labels=c("Low", "High"))))+
    geom_density(alpha=.5)+
    scale_fill_brewer(palette="Set1")+
    theme_classic()+labs(fill="TV group", x="Propensity score", y=NULL)+
    theme(plot.title= element_text(family="Times New Roman", size=11),
          axis.title = element_text(family = "Times New Roman",size=11),
          legend.text=element_text(family="Times New Roman", size=7), 
          legend.title=element_text(family="Times New Roman", size=10),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank())
  if (title==T) {p <- p + ggtitle(
    paste0("Density of propensity scores by TV category \n", 
           title_string))+
    theme(plot.title=element_text(size=10, hjust=0.5, 
                                  family="Times New Roman"))}
  
  ggsave(filename=here(subdirectory, output_string, paste0("pscore_density_", output_string, ".png")),
         plot=p, width=5, height=4, scale=1.2, dpi=200)
  
  if (method=="IPTW") {
    
    # examine a balance table
    tbl.balance <- cbind(bal.table(ps.analysis)$unw[,c(1,2,3,4,5)], 
                         bal.table(ps.analysis)$ks.max[,c(1,2,3,4,5)])
    
    if (title==T) {
      stargazer(tbl.balance, type="text", summary=FALSE, 
                out=here(subdirectory, output_string, paste0("balance_", output_string, ".html")),
                digits=2,
                title=paste0("Covariate balance before and after applying IPTW weights <br>", 
                             title_string))
    } else {
      stargazer(tbl.balance, type="text", summary=FALSE, 
                out=here(subdirectory, output_string, paste0("balance_", output_string, ".html")),
                digits=2)
    }
    
    # make a figure showing covariate balance before and after weighting
    # add variable names as a variable (for melting)
    tbl.balance$variable <- rownames(tbl.balance)
    
    # select the variable names and pre- and post-weighting d effect sizez  
    tbl.balance.plot <- tbl.balance[,c(11, 5, 10)]
    
    # name the columns      
    names(tbl.balance.plot)=c("var", "d_before", "d_after")
    
    # drop the rows showing balance for missingness and melt for ggplot
    tbl.balance.plot <- filter(tbl.balance.plot, !grepl("<NA>", var)) %>%
      melt()
    
    # convert variable to factor with labels
    tbl.balance.plot$variable <- factor(tbl.balance.plot$variable,
                                        labels=c("Unweighted", "Weighted"))
    
    # make the plot
    p <- ggplot(data=tbl.balance.plot, aes(x=variable, y=abs(value), group=var))+
      geom_point(alpha=.6, size=2, shape=22, fill="red",
                 position=position_dodge(.075))+
      geom_line(alpha=.2, col="blue", position=position_dodge(.075))+
      theme_bw()+labs(x="", y="Absolute value of d")+
      theme(plot.title= element_text(family="Times New Roman", size=11),
            axis.text = element_text(family = "Times New Roman",size=11),
            axis.title = element_text(family = "Times New Roman",size=11),
            legend.text=element_text(family="Times New Roman", size=7), 
            legend.title=element_text(family="Times New Roman", size=10))
    # add title to plot if argument title==TRUE
    if (title==T) {p <- p + ggtitle(
      paste0("Covariate balance before and after weighting \n", 
             title_string))+
      theme(plot.title=element_text(size=10, hjust=0.5, 
                                    family="Times New Roman"))}
    
    # export it
    ggsave(filename=here(subdirectory, output_string, 
                         paste0("/balanceplot_", output_string, ".png")), 
           plot=p, width=5, height=4, scale=1.2, dpi=200)
    dev.off()
    
    # find most unbalanced variables
    tbl.balance.plot$factorvar <- substr(tbl.balance.plot$var, 1, (regexpr(":", tbl.balance.plot$var)-1))
    tbl.balance.plot$factorvar <- ifelse(tbl.balance.plot$factorvar=="", 
                                         tbl.balance.plot$var, 
                                         tbl.balance.plot$factorvar)
    
    most.unbalanced.covs <- tbl.balance.plot %>% 
      filter(variable=="Weighted") %>% 
      group_by(factorvar) %>% 
      filter(abs(value)==max(abs(value))) %>% 
      ungroup() %>% 
      arrange(desc(abs(value))) %>% 
      slice(1:4) %>% 
      dplyr::select(factorvar) %>% 
      unlist() %>% 
      paste0(collapse="+")
    
    # calculate the IPTW weights and append to analysis dataset
    df$weights <- get.weights(ps.analysis, stop.method = "ks.max")
    
    # calculate the treatment effect with IPTW weights - no sample weights
    design.ps <- svydesign(ids = ~1, weights = ~weights, data = df) 
    
    # calculate the treatment effect with IPTW weights and sample weights
    df$compositeWts <- df$weights * (df$sampleWt/100)
    design.ps.wts <- svydesign(ids = ~1, weights = ~compositeWts, data = df) 
    
    IPTWresult_raw <- svyglm(attention ~ TVcat, design = design.ps)
    IPTWresult_std <- svyglm(att_sex_ss ~ TVcat, design = design.ps)
    
    IPTWresult_raw_wts <- svyglm(attention ~ TVcat, design = design.ps.wts)
    IPTWresult_std_wts <- svyglm(att_sex_ss ~ TVcat, design = design.ps.wts)
    
    # doubly-robust estimation with and without sample weights
    IPTWresult_raw_dr <- svyglm(as.formula(c("attention~TVcat+", 
                                             most.unbalanced.covs)), 
                                design = design.ps)
    
    IPTWresult_std_dr <- svyglm(as.formula(c("att_sex_ss~TVcat+", 
                                             most.unbalanced.covs)), 
                                design = design.ps)
    
    IPTWresult_raw_dr_wts <- svyglm(as.formula(c("attention~TVcat+", 
                                                 most.unbalanced.covs)), 
                                    design = design.ps.wts)
    
    IPTWresult_std_dr_wts <- svyglm(as.formula(c("att_sex_ss~TVcat+", 
                                                 most.unbalanced.covs)), 
                                    design = design.ps.wts)
    if (title==T) {
      stargazer(IPTWresult_raw, IPTWresult_raw_wts,
                IPTWresult_raw_dr, IPTWresult_raw_dr_wts,
                IPTWresult_std,  IPTWresult_std_wts,
                IPTWresult_std_dr, IPTWresult_std_dr_wts,
                ci=TRUE, type="text", star.cutoffs=c(.05, .01, .001),
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(4, 4),
                dep.var.labels.include=F,
                dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                notes=c("(1) (2) (5) (6) Propensity score adjustment only; (3) (4) (7) (8) Doubly-robust model.", 
                        "(1) (3) (5) (7) No sample weights; (2) (4) (6) (8) Sample weights applied.",
                        "Raw attention: lower is more impaired.", 
                        "Standardized attention: higher is more impaired."),
                notes.align="l", align=F,
                out=here(subdirectory, output_string, paste0("results_", output_string, ".html")),
                title=paste0("IPTW Propensity Score Analayis Results Summary<br>", 
                             title_string))
    } else {
      stargazer(IPTWresult_raw, IPTWresult_raw_wts,
                IPTWresult_raw_dr, IPTWresult_raw_dr_wts,
                IPTWresult_std,  IPTWresult_std_wts,
                IPTWresult_std_dr, IPTWresult_std_dr_wts,
                ci=TRUE, type="text", star.cutoffs=c(.05, .01, .001),
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(4, 4),
                dep.var.labels.include=F,
                dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                notes=c("(1) (2) (5) (6) Propensity score adjustment only; (3) (4) (7) (8) Doubly-robust model.", 
                        "(1) (3) (5) (7) No sample weights; (2) (4) (6) (8) Sample weights applied.",
                        "Raw attention: lower is more impaired.", 
                        "Standardized attention: higher is more impaired."),
                notes.align="l", align=F,
                out=here(subdirectory, output_string, paste0("results_", output_string, ".html")))
    }
    # collect results for plotting
    IPTW <- rbind(
      summary(IPTWresult_raw)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_raw_wts)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_raw_dr)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_raw_dr_wts)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_std)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_std_wts)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_std_dr)$coefficients[2, c(1,2,4)],
      summary(IPTWresult_std_dr_wts)$coefficients[2, c(1,2,4)])
    
    #names = "Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
    #"Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
    #"Attention cutpoint", "Estimate", "StdErr", "p")
    
    results <- matrix(c(
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Raw", "No", covariates, "trees", NA,  NA, NA,
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Raw", "No", covariates, "trees", NA, "Sample weights", NA,
      
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Raw", "Yes", covariates, "trees", NA, NA, NA,
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Raw", "Yes", covariates, "trees", NA, "Sample weights", NA,
      
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Within-sex SS", "No", covariates, "trees", NA, NA, NA,
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Within-sex SS", "No", covariates, "trees", NA, "Sample weights", NA,
      
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Within-sex SS", "Yes", covariates, "trees", NA, NA, NA,
      "PSA", method, estimand,  NA, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Within-sex SS", "Yes", covariates, "trees", NA, "Sample weights", NA),
      nrow=8, byrow=T) %>% data.frame()
    
    results <- cbind(results, IPTW) 
    
    names(results) <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
                        "Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
                        "Attention cutpoint", "Estimate", "StdErr", "p")
  }
  
  if (method == "stratification") {
    
    # make strata with boundaries such that all strata have equal n
    bounds <- quantile(df$pscores, seq(0, 1, 1/strata)) 
    
    df$strat <- cut(df$pscores, breaks=bounds, 
                    labels = FALSE, include.lowest=TRUE)
    
    # identify any strata with no treated or control cases inside
    #  drop that stratum from the data
    emptystrat <- as.numeric(
      which(
        apply(with(df, table(strat, TVcat)), 1, min)==0)
    )
    
    if (length(emptystrat>0)) {
      df <- filter(df, strat != emptystrat)
    }
    
    # make a series of plots illustrating covariate balance within strata
    #  part 1: continuous variables
    
    # define functions to pick out categorical or continuous variables
    is.categorical <- function(x, levels=4) {length(table(x)) <= levels}
    is.notcategorical <- function(...) {!is.categorical(...)}
    
    df_subset <- dplyr::select(df,  unlist(strsplit(gsub(" ", "", gsub("\n", "", gsub("+", ", ", covs, fixed=T)), fixed=T), split=",", fixed=T)),
                               TVcat, pscores)
    
    # need to identify continuous variables vs factors
    df_names_categorical <- df_subset[,sapply(df_subset, is.categorical)] %>% 
      names() %>% append("strat")
    
    df_names_continuous <- df_subset[,sapply(df_subset, is.notcategorical)] %>%
      names() %>% append("TVcat") %>% append("strat")
    
    # set margins for each panel
    par(mar=rep(1, 4))
    p_continuous <- list()
    p_categorical <- list()
    
    dev.control('enable')
    
    oldw <- getOption("warn")
    options(warn = -1)
    
    df_subset_continuous <- df[df_names_continuous]
    
    for (i in 1:(length(df_names_continuous)-2)) {
      
      df_target_subset_continuous <-  df_subset_continuous[!is.na(df_subset_continuous[,i]),]
      
      plot.new()
      
      try(suppressWarnings(with(df_target_subset_continuous,
                                box.psa(continuous=(df_target_subset_continuous[,i]), 
                                        treatment=TVcat, 
                                        strata=strat, 
                                        balance=F, main=names(df_target_subset_continuous)[i],
                                        legend.xy=c(1000,1000), cex=.85))), silent=T)
      p_continuous[[i]] <- recordPlot()
    }
    
    df_subset_categorical <- df[df_names_categorical]
    
    for (i in 1:(length(df_names_categorical)-2)) {
      df_target_subset_categorical <-  df_subset_categorical[!is.na(df_subset_categorical[,i]),]# & analysis$strat != 1,]
      
      plot.new()
      
      try(suppressWarnings(with(df_target_subset_categorical,
                                cat.psa(categorical=df_target_subset_categorical[,i], treatment=TVcat, 
                                        strata=strat, balance=F, main=names(df_target_subset_categorical)[i],
                                        legend.xy=c(1000,1000), cex=.85))), silent=T)
      p_categorical[[i]] <- recordPlot()
    }
    
    p <- plot_grid(plotlist=c(p_continuous, p_categorical),
                   axis="lr", scale=0.75, greedy=T)
    if (title==T) {
      p <- p + ggtitle(
        paste0("Covariate balance within strata defined by the propensity score\n", 
               title_string, ", Strata: ", strata))+
        theme(plot.title=element_text(size=30, hjust=0.5, 
                                      family="Times New Roman"))
    }
    
    ggsave(filename=here(subdirectory, output_string, paste0("balanceplot_", output_string, "_k=", strata,".png")),
           plot=p, 
           width=16, height=12, 
           dpi=200, scale=1.4)   
    
    dev.off()
    options(warn = oldw)
    
    # remove missings, as the circ.psa() function can't handle them.
    df_complete <- filter(df, 
                          !is.na(attention), 
                          !is.na(att_sex_ss),
                          !is.na(TVcat), !is.na(strat))
    
    par(mfrow=c(1,1), mar=c(.2,.2,.2,.2), cex=1)
    
    plot.new()
    strat.raw <- with(df_complete, 
                      circ.psa(attention, treatment=TVcat,
                               strata=strat, summary = FALSE,
                               statistic = "mean", trim = 0, revc = F, 
                               confint = TRUE))
    title(main=paste0("Stratified propensity score model results\n", 
                      title_string, ", Strata: ", strata, "\nOutcome: raw attention"), cex=.6, outer=T, line=-4)
    
    p_raw <- recordPlot()
    
    ggsave(filename=here(subdirectory, output_string, 
                         paste0("result_raw_", output_string, "_k=", strata, ".png")),
           plot=cowplot::plot_grid(p_raw),
           width=5, height=4, 
           dpi=200, scale=1.5)  
    
    dev.off()
    
    plot.new()
    strat.std <- with(df_complete, 
                      circ.psa(att_sex_ss, treatment=TVcat,
                               strata=strat, summary = FALSE,
                               statistic = "mean", trim = 0, revc = F, 
                               confint = TRUE))
    title(main=paste0("Stratified propensity score model results\n", 
                      title_string, ", Strata: ", strata, "\nOutcome: within-sex standarized attention"), cex=.6, outer=T, line=-4)
    
    p_std <- recordPlot()
    
    ggsave(filename=here(subdirectory, output_string, 
                         paste0("result_std_", output_string, "_k=", strata, ".png")),
           plot=plot_grid(p_std),
           width=5, height=4, 
           dpi=200, scale=1.5)  
    
    dev.off()
    
    strat.raw$summary.strata %>%
      as.data.frame() %>% 
      mutate(rawES = means.1 - means.0) %>%
      mutate(d = rawES / sd(df$attention, na.rm=T)) %>%
      mutate(stratum = 1:nrow(strat.raw$summary.strata)) %>%
      dplyr::select(stratum, everything()) %>%   
      setNames(c("stratum", "n (low TV)", 
                 "n (high TV)", 
                 "mean (low TV)", "mean (high TV)", 
                 "raw effect size", "d")) %>%
      stargazer(summary=F, type="text",
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(4,4), 
                colnames=T,
                digits=2, rownames=F,
                notes=c(paste0("Estimated ATE: ", format(round(strat.raw$ATE, 3), nsmall=3), 
                               "; 95% CI [", format(round(strat.raw$CI.95[1], 3), nsmall=3), 
                               ", ", format(round(strat.raw$CI.95[2], 3), nsmall=3), "], d = ", 
                               format(round((strat.raw$ATE/sd(df$attention, na.rm=T)), 3), nsmall=3)),
                        "(lower is more impaired)"),
                notes.align="l", align=F,
                title = paste0("Stratification propensity score model results<br>Outcome: Raw attention, ",  
                               title_string, ", Strata: ", strata),
                out=here(subdirectory, output_string, paste0("result_raw_", output_string, "_k=", strata, ".html"))
      )
    
    strat.std$summary.strata %>%
      as.data.frame() %>% 
      mutate(rawES = means.1 - means.0) %>%
      mutate(d = rawES / sd(df$att_sex_ss, na.rm=T)) %>%
      mutate(stratum = 1:nrow(strat.std$summary.strata)) %>%
      dplyr::select(stratum, everything()) %>%   
      setNames(c("stratum", "n (low TV)", 
                 "n (high TV)", 
                 "mean (low TV)", "mean (high TV)", 
                 "raw effect size", "d")) %>%
      stargazer(summary=F, type="text",
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(4,4), 
                colnames=T,
                digits=2, rownames=F,
                notes=c(paste0("Estimated ATE: ", format(round(strat.std$ATE, 3), nsmall=3), 
                               "; 95% CI [", format(round(strat.std$CI.95[1], 3), nsmall=3), 
                               ", ", format(round(strat.std$CI.95[2], 3), nsmall=3), "], d = ", 
                               format(round((strat.std$ATE/sd(df$att_sex_ss, na.rm=T)), 3), nsmall=3)),
                        "(higher is more impaired)"),
                notes.align="l", align=F,
                title = paste0("Stratification propensity score model results<br>Outcome: Within-sex standardized attention, ", 
                               title_string, ", Strata: ", strata),
                out=here(subdirectory, output_string, paste0("result_std_", output_string, "_k=", strata, ".html"))
      )
    # collect results for plotting
    
    strat.results <- rbind(
      c(strat.raw$ATE, strat.raw$se.wtd, strat.raw$df),
      c(strat.std$ATE, strat.std$se.wtd, strat.std$df)
    )
    
    # calculate approximate 2-tailed p-value
    # note: this overwrites the 3rd column (which used to contain the df)
    #  with the p-value
    strat.results[,3] <-
      2*pt(abs(strat.results[,1]/strat.results[,2]),
           df=strat.results[,3], lower.tail=F)
    
    # names: number, analysis, method, effect, cutpoint, TVage, outcome,
    #  doubly robust, covariates
    
    results <- matrix(c(
      "PSA", method, estimand, strata, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Raw", "No", covariates, "trees", NA, NA, NA,
      "PSA", method, estimand, strata, str_c(as.character(TVpercentiles*100), collapse="/"), ifelse(TVage=="1", "~1.5", "~3"), "Within-sex SS", "No", covariates, "trees", NA, NA, NA),
      nrow=2, byrow=T) %>% data.frame()
    
    results <- cbind(results, strat.results) 
    
    names(results) <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
                        "Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
                        "Attention cutpoint", "Estimate", "StdErr", "p")
    
    
  }
  
  return(results)
}

# Test the propensity score analysis function -----------------------------

# test the function
# psa(data=analysis, subdirectory="Results", iterations=4000, estimand="ATE", TVage=3, covariates="Original",
#     method="IPTW", TVpercentiles=c(.2, .8), strata=5, title=TRUE, order=1)
# 
# psa(data=analysis, subdirectory="Results", iterations=4000, estimand="ATE", TVage=3, covariates="Original",
#    method="stratification", TVpercentiles=c(.2, .8), strata=5, title=TRUE, order=1)
# 
# psa(data=analysis, subdirectory="Results", iterations=4000, estimand="ATE", TVage=3, covariates="Expanded",
#     method="IPTW", TVpercentiles=c(.2, .8), strata=5, title=TRUE, order=1)
# 
# psa(data=analysis, subdirectory="Results", iterations=4000, estimand="ATE", TVage=3, covariates="Original",
#     method="stratification", TVpercentiles=c(.4, .6), strata=4, title=TRUE, order=1)
# 
# psa(data=analysis, subdirectory="Results", iterations=4000, estimand="ATE", TVage=3, covariates="Expanded",
#     method="stratification", TVpercentiles=c(.2, .8), strata=4, title=TRUE, order=1)


# Define the function for linear regression analysis ----------------------

##################################################
#                                                #
#   Function for linear regression analysis      #
#                                                #
##################################################

# define function to pool contrasts from multiple imputation
pooled.contrast <- function(x) {
  
  # convert the contrast object to numeric and return it to a matrix structure
  # note: the estimate is in col 3, the std err in col 4
  #  the matrix has m rows, where m is the number of imputations
  x.numeric <-  matrix(as.numeric(x), ncol=6)
  
  pool.est <- apply(x.numeric, 2, mean)[3]
  between.var <- apply(x.numeric, 2, var)[3]
  within.var <- apply(x.numeric, 2, mean)[4]^2
  se.pool <- sqrt(within.var+between.var+between.var/ nrow(x.numeric)) 
  return(c(pool.est, se.pool))
}

regression <- function(data, subdirectory, missing, covariates, order=1, title=TRUE,
                       m=10, maxit=50, seed=1) {
  
  # some of these function calls produce meaningless warnings
  # this suppresses them. You can comment this out for safety
  options(warn = -1)      
  
  # make temp copy of data frame
  df <- data
  
  # convert female and fatherAbsent variables to factors
  df$female <- factor(df$female, levels=c(0,1), labels=c("No", "Yes"))
  df$fatherAbsent <- factor(df$fatherAbsent, levels=c(0,1), labels=c("No", "Yes"))
  df$poorHealth <- factor(df$poorHealth, levels=c(0,1), labels=c("No", "Yes"))
  df$preterm <- factor(df$preterm, levels=c(0,1), labels=c("No", "Yes"))
  df$lowBirthWt <- factor(df$lowBirthWt, levels=c(0,1), labels=c("No", "Yes"))
  
  # calculate the median TV for the age 1 and age 3 groups
  #  this will be the linearization point for the quadratic models
  TV1.median <- median(df$TV1, na.rm=T)
  TV3.median <- median(df$TV3, na.rm=T)
  
  
  output_string <- paste0("regression", "_", covariates, "_", ifelse(missing=="MI", "MI", "listwise"), "_order=", order)
  
  title_string <- paste0(covariates, " covariate set, Missing data by ",  
                         ifelse(missing=="MI", "multiple imputation", "listwise deletion"), 
                         ", Model specification for TV: ",
                         ifelse(order==1, "linear", 
                                ifelse(order==2, "squared", 
                                       ifelse(order==3, "cubed", 
                                              paste0(order, "th order polynomial")))))
  
  # check if subdirectory exists
  # if not, create it
  if (!dir.exists(here(subdirectory, output_string))) {
    dir.create(here(subdirectory, output_string), showWarnings=F)
  } 
  
  
  TV1vars <- ifelse(order==1, "TV1+", 
                    ifelse(order==2, "TV1+TV1_2+", 
                           ifelse(order==3, "TV1+TV1_2+TV1_3+", 
                                  ifelse(order==4, "TV1+TV1_2+TV1_3+TV1_4+", 
                                         "TV1+TV1_2+TV1_3+TV1_4+TV1_5+")))) 
  
  TV3vars <- ifelse(order==1, "TV3+", 
                    ifelse(order==2, "TV3+TV3_2+", 
                           ifelse(order==3, "TV3+TV3_2+TV3_3+", 
                                  ifelse(order==4, "TV3+TV3_2+TV3_3+TV3_4+", 
                                         "TV3+TV3_2+TV3_3+TV3_4+TV3_5+")))) 
  
  
  if (covariates=="Original") {
    covs <- "cohort+age+cogStim13+emoSupp13+
              momEdu+kidsInHouse+momAge+Rosen87+CESD92+
              alcohol+fatherAbsent+female+gestationalAge+
              race+smoking+SMSA"
    
    ncovs <- 16
    
    cov.labels <- c("TV category (age ~1.5)", 
                    "TV category (age ~3)", 
                    "Cohort = 1998", "Cohort = 2000", 
                    "Age at index", "Cognitive stimulation of home",
                    "Emotional support of home", "Maternal years of education",
                    "Children in the household", "Maternal age at birth",
                    "Maternal self-esteem (1987)", 
                    "Maternal depression (1992)", "Alcohol use in pregnancy",
                    "Father absent from household",
                    "Sex = female", "Gestational age at birth", "Race = Black", 
                    "Race = White", "Smoking in pregnancy", 
                    "SMSA; not central city", "SMSA; central city unknown", 
                    "SMSA; in central city",
                    "Intercept")
    
  } # closes if covariates==original
  
  if (covariates=="Expanded") {
    
    covs <- "cohort+age+temperament+cogStim13+emoSupp13+momEdu+partnerEdu+kidsInHouse+
              momAge+income+Rosen87+CESD92+alcohol+fatherAbsent+female+lowBirthWt+
              poorHealth+preterm+race+smoking+SMSA"
    
    ncovs <- 21
    
    cov.labels <- c("TV category (age ~1.5)", 
                    "TV category (age ~3)",  
                    "Cohort = 1998", "Cohort = 2000", 
                    "Age at index", "Temperament", 
                    "Cognitive stimulation of home",
                    "Emotional support of home", 
                    "Maternal years of education",
                    "Partner years of education",
                    "Children in the household", "Maternal age at birth",
                    "Family income ($k)", "Maternal self-esteem (1987)", 
                    "Maternal depression (1992)", "Alcohol use during pregnancy",
                    "Father absent from household", "Sex = female", 
                    "Low birth weight", "Child poor health", "Preterm delivery", 
                    "Race = Black", "Race = White", "Smoking in pregnancy", 
                    "SMSA; not central city", "SMSA; central city unknown", 
                    "SMSA; in central city", "Intercept")
    
  } # closes if covariates==expanded
  
  if (missing=="listwise") { 
    
    if (covariates=="Original") {
      
      # make descriptives table for continuous variables
      
      dtable <-  df %>% 
        dplyr::select("TV hours per day age 1.5" = TV1,
                      "TV hours per day age 3" = TV3,
                      "Attention (raw)" = attention,
                      "Attention within-sex SS" = att_sex_ss,
                      "Age (yrs) when attention was measured" = age,
                      "Cognitive stimulation of home age 1-3" = cogStim13,
                      "Emotional support of home age 1-3" = emoSupp13,
                      "Mother's years of schooling" = momEdu,
                      "Number of children in household" = kidsInHouse,
                      "Mother's age at birth" = momAge,
                      "Rosenberg self-esteem score (1987)" = Rosen87,
                      "CES-D Depression score (1992)" = CESD92,
                      "Gestational age (in weeks relative to term)" = gestationalAge) %>%
        summarise_all(lst(Validn, Mean, Sd, Min, Max)) %>%
        gather(key, value, everything()) %>%
        separate(key, into=c("variable", "stat"), sep="_") %>%
        pivot_wider(names_from="stat", values_from="value")
      
      names(dtable) <- c("Variable", "Valid n", "Mean", "Std Dev", "Min", "Max")
      
      
      # make descriptives table for categorical variables
      
      ctable <- 
        df %>%
        dplyr::select(cohort, race, female, fatherAbsent,
                      alcohol, smoking, SMSA) %>%
        transmute_all(as.character) %>% 
        gather(key="variable", value="value", cohort, race, female, fatherAbsent,
               alcohol, smoking, SMSA) %>%
        group_by(variable, value) %>%
        summarise (n = n()) %>%
        mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
      
      # sort within groups so NA is always last
      ctable <- ctable %>% group_by(variable) %>% 
        dplyr::arrange(value, .by_group=T)
      
      # change NAs (which render as blanks) to "(missing)" in the table
      ctable$value <- ifelse(is.na(ctable$value), "(missing)", 
                             ctable$value)
      
      ctable$variable <- 
        ifelse(ctable$variable=="alcohol", 
               "Maternal alcohol use during pregnancy", 
               ifelse(ctable$variable=="cohort",
                      "Cohort", 
                      ifelse(ctable$variable=="fatherAbsent", 
                             "Father is absent from household", 
                             ifelse(ctable$variable=="female",
                                    "Female", 
                                    ifelse(ctable$variable=="lowBirthWt",
                                           "Low Birth Weight", 
                                           ifelse(ctable$variable=="race",
                                                  "Race",
                                                  ifelse(ctable$variable=="smoking",
                                                         "Maternal smoking during pregnancy",
                                                         ifelse(ctable$variable=="SMSA",
                                                                "Standard metropolitan statistical area",
                                                                ctable$variable))))))))
      
      for (i in seq(nrow(ctable), 2, by=-1)) {
        if (ctable$variable[i] == ctable$variable[i-1]) {ctable$variable[i] <- ""}
      }
      
      names(ctable) <- c("Variable", "Value", "n", "Percent")
      
      ### Save the correlation matrix of continuous variables
      
      # define functions to pick out categorical or continuous variables
      is.categorical <- function(x, levels=4) {length(table(x))<=levels}
      is.notcategorical <- function(...) {!is.categorical(...)}
      
      df_subset <- dplyr::select(df,  unlist(strsplit(gsub(" ", "", gsub("\n", "", gsub("+", ", ", covs, fixed=T)), fixed=T), split=",", fixed=T)),
                                 attention, att_sex_ss, TV1, TV3)
      
      # need to identify continuous variables vs factors
      df_names_categorical <- df_subset[,sapply(df_subset, is.categorical)] %>% 
        names() 
      df_names_continuous <- df_subset[,sapply(df_subset, is.notcategorical)] %>%
        names() 
      
      r_continuous <- round(cor(dplyr::select(df,df_names_continuous), 
                                use="complete.obs"),2)
      
      
      r_continuous[upper.tri(r_continuous)]<-NA
      r_continuous <- as.data.frame(r_continuous)
      
      
      if (title==T) {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")),
                  title=paste0("Descriptive statistics for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Listwise deletion"))
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")),
                  title=paste0("Descriptive statistics for categorical variables<br>", 
                               covariates, " covariate set<br>",
                               "Listwise deletion"))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")),
                  title=paste0("Correlation matrix for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Listwise deletion"))
      } else {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")))
        
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")))
      }
      
    } # closes if covariates==original
    
    if (covariates=="Expanded") {
      # make descriptives table for continuous variables
      
      dtable <-  df %>% 
        dplyr::select( "TV hours per day age 1.5" = TV1,
                       "TV hours per day age 3" = TV3,
                       "Attention (raw)" = attention,
                       "Attention within-sex SS" = att_sex_ss,
                       "Age (yrs) when attention was measured" = age,
                       "Temperament" = temperament,
                       "Cognitive stimulation of home age 1-3" = cogStim13,
                       "Emotional support of home age 1-3" = emoSupp13,
                       "Mother's years of schooling" = momEdu,
                       "Partner's years of schooling" = partnerEdu,
                       "Number of children in household" = kidsInHouse,
                       "Mother's age at birth" = momAge,
                       "Annual family income (thousands)" = income,
                       "Rosenberg self-esteem score (1987)" = Rosen87,
                       "CES-D Depression score (1992)" = CESD92) %>%
        summarise_all(lst(Validn, Mean, Sd, Min, Max)) %>%
        gather(key, value, everything()) %>%
        separate(key, into=c("variable", "stat"), sep="_") %>%
        pivot_wider(names_from="stat", values_from="value")
      
      names(dtable) <- c("Variable", "Valid n", "Mean", "Std Dev", "Min", "Max")
      
      
      # make descriptives table for categorical variables
      
      ctable <- 
        df %>%
        dplyr::select(cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
                      alcohol, smoking, preterm, SMSA) %>% 
        transmute_all(as.character) %>% 
        gather(key="variable", value="value", cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
               alcohol, smoking, preterm, SMSA) %>%
        group_by(variable, value) %>%
        summarise (n = n()) %>%
        mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
      
      # sort within groups so NA is always last
      ctable <- ctable %>% group_by(variable) %>% 
        dplyr::arrange(value, .by_group=T)
      
      # change NAs (which render as blanks) to "(missing)" in the table
      ctable$value <- ifelse(is.na(ctable$value), "(missing)", 
                             ctable$value)
      
      ctable$variable <- 
        ifelse(ctable$variable=="alcohol", 
               "Maternal alcohol use during pregnancy", 
               ifelse(ctable$variable=="cohort",
                      "Cohort", 
                      ifelse(ctable$variable=="fatherAbsent", 
                             "Father is absent from household", 
                             ifelse(ctable$variable=="female",
                                    "Female", 
                                    ifelse(ctable$variable=="lowBirthWt",
                                           "Low Birth Weight", 
                                           ifelse(ctable$variable=="poorHealth",
                                                  "Poor health",
                                                  ifelse(ctable$variable=="preterm",
                                                         "Preterm birth",
                                                         ifelse(ctable$variable=="race",
                                                                "Race",
                                                                 ifelse(ctable$variable=="smoking",
                                                                       "Maternal smoking during pregnancy",
                                                                         ifelse(ctable$variable=="SMSA",
                                                                                "Standard metropolitan statistical area",
                                                                                 ctable$variable))))))))))
      
      for (i in seq(nrow(ctable), 2, by=-1)) {
        if (ctable$variable[i] == ctable$variable[i-1]) {ctable$variable[i] <- ""}
      }
      
      names(ctable) <- c("Variable", "Value", "n", "Percent")
      
      ### Save the correlation matrix of continuous variables
      
      # define functions to pick out categorical or continuous variables
      is.categorical <- function(x, levels=4) {length(table(x))<=levels}
      is.notcategorical <- function(...) {!is.categorical(...)}
      
      df_subset <- dplyr::select(df,  unlist(strsplit(gsub(" ", "", gsub("\n", "", gsub("+", ", ", covs, fixed=T)), fixed=T), split=",", fixed=T)),
                                 attention, att_sex_ss, TV1, TV3)
      
      # need to identify continuous variables vs factors
      df_names_categorical <- df_subset[,sapply(df_subset, is.categorical)] %>% 
        names() 
      df_names_continuous <- df_subset[,sapply(df_subset, is.notcategorical)] %>%
        names() 
      
      r_continuous <- round(cor(dplyr::select(df,df_names_continuous), 
                                use="complete.obs"),2)
      
      
      r_continuous[upper.tri(r_continuous)]<-NA
      r_continuous <- as.data.frame(r_continuous)
      
      
      if (title==T) {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")),
                  title=paste0("Descriptive statistics for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Listwise deletion"))
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")),
                  title=paste0("Descriptive statistics for categorical variables<br>", 
                               covariates, " covariate set<br>",
                               "Listwise deletion"))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")),
                  title=paste0("Correlation matrix for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Listwise deletion"))
        
      } else {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")))
        
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")))
      } 
      
    } #closes if covariates==expanded
    
    # compute polynomial terms
    df$TV1_2 <- df$TV1^2
    df$TV1_3 <- df$TV1^3
    df$TV1_4 <- df$TV1^4
    df$TV1_5 <- df$TV1^5
    
    df$TV3_2 <- df$TV3^2
    df$TV3_3 <- df$TV3^3
    df$TV3_4 <- df$TV3^4
    df$TV3_5 <- df$TV3^5
    
    # fit nested models to each case: TV1/3 std/raw attention
    #  and compute joint test of TV
    m0_TV1_raw <- lm(data=filter(df, !is.na(TV1)), as.formula(c("attention~", covs)))
    m1_TV1_raw <- lm(data=filter(df, !is.na(TV1)), as.formula(c("attention~", TV1vars, covs)))
    TV1_raw_result <- anova(m0_TV1_raw, m1_TV1_raw) %>% tidy()
    TV1_raw_result_string <- with(TV1_raw_result, paste0("F(", df[2], ", ", res.df[2], ") = ", 
                                                         round(statistic[2],3), ifelse(p.value[2]<.001, " ***",
                                                                                       ifelse(p.value[2]<.01, " **",
                                                                                              ifelse(p.value[2]<.05, " *", "")))))
    
    m0_TV3_raw <- lm(data=filter(df, !is.na(TV3)), as.formula(c("attention~", covs)))
    m1_TV3_raw <- lm(data=filter(df, !is.na(TV3)), as.formula(c("attention~", TV3vars, covs)))
    TV3_raw_result <- anova(m0_TV3_raw, m1_TV3_raw) %>% tidy()
    TV3_raw_result_string <- with(TV3_raw_result, paste0("F(", df[2], ", ", res.df[2], ") = ", 
                                                         round(statistic[2],3), ifelse(p.value[2]<.001, " ***",
                                                                                       ifelse(p.value[2]<.01, " **",
                                                                                              ifelse(p.value[2]<.05, " *", "")))))
    
    m0_TV1_std <- lm(data=filter(df, !is.na(TV1)), as.formula(c("att_sex_ss~", covs)))
    m1_TV1_std <- lm(data=filter(df, !is.na(TV1)), as.formula(c("att_sex_ss~", TV1vars, covs)))
    TV1_std_result <- anova(m0_TV1_std, m1_TV1_std) %>% tidy()
    TV1_std_result_string <- with(TV1_std_result, paste0("F(", df[2], ", ", res.df[2], ") = ", 
                                                         round(statistic[2],3), ifelse(p.value[2]<.001, " ***",
                                                                                       ifelse(p.value[2]<.01, " **",
                                                                                              ifelse(p.value[2]<.05, " *", "")))))
    
    m0_TV3_std <- lm(data=filter(df, !is.na(TV3)), as.formula(c("att_sex_ss~", covs)))
    m1_TV3_std <- lm(data=filter(df, !is.na(TV3)), as.formula(c("att_sex_ss~", TV3vars, covs)))
    TV3_std_result <- anova(m0_TV3_std, m1_TV3_std) %>% tidy()
    TV3_std_result_string <- with(TV3_std_result, paste0("F(", df[2], ", ", res.df[2], ") = ", 
                                                         round(statistic[2],3), ifelse(p.value[2]<.001, " ***",
                                                                                       ifelse(p.value[2]<.01, " **",
                                                                                              ifelse(p.value[2]<.05, " *", "")))))
    
    # fit the same models with sample weights
    df_complete_1 <- filter(df, !is.na(TV1))
    df_complete_3 <- filter(df, !is.na(TV3))
    
    # create the survey design objects
    des_1_raw <- svydesign(ids = ~1, data=df_complete_1, weights=df_complete_1$sampleWt, 
                           variables=as.formula(c("attention~", TV1vars, covs)))
    
    des_3_raw <- svydesign(ids = ~1, data=df_complete_3, weights=df_complete_3$sampleWt,  
                           variables=as.formula(c("attention~", TV3vars, covs)))
    
    des_1_std <- svydesign(ids = ~1, data=df_complete_1, weights=df_complete_1$sampleWt,  
                           variables=as.formula(c("att_sex_ss~", TV1vars, covs)))
    
    des_3_std <- svydesign(ids = ~1, data=df_complete_3, weights=df_complete_3$sampleWt,
                           variables=as.formula(c("att_sex_ss~", TV3vars, covs)))
    
    # TV 1, raw attention, models m0 and m1
    m0_TV1_raw_wts <- with(df_complete_1, 
                           svyglm(as.formula(c("attention~", covs)),
                                  design=des_1_raw))
    m1_TV1_raw_wts <- with(df_complete_1, 
                           svyglm(as.formula(c("attention~", TV1vars, covs)),
                                  design=des_1_raw))
    TV1_raw_result_wts <- anova(m0_TV1_raw_wts, m1_TV1_raw_wts, method="Wald")
    TV1_raw_result_wts_string <- with(TV1_raw_result_wts, 
                                      paste0("F(", df, ", ", ddf, ") = ", 
                                             round(Ftest,3), ifelse(p<.001, " ***",
                                                                    ifelse(p<.01, " **",
                                                                           ifelse(p<.05, " *", "")))))
    
    # TV 3, raw attention, models m0 and m1
    m0_TV3_raw_wts <- with(df_complete_3, 
                           svyglm(as.formula(c("attention~", covs)),
                                  design=des_3_raw))
    m1_TV3_raw_wts <- with(df_complete_3, 
                           svyglm(as.formula(c("attention~", TV3vars, covs)),
                                  design=des_3_raw))
    TV3_raw_result_wts <- anova(m0_TV3_raw_wts, m1_TV3_raw_wts, method="Wald")
    TV3_raw_result_wts_string <- with(TV3_raw_result_wts, 
                                      paste0("F(", df, ", ", ddf, ") = ", 
                                             round(Ftest,3), ifelse(p<.001, " ***",
                                                                    ifelse(p<.01, " **",
                                                                           ifelse(p<.05, " *", "")))))
    
    # TV 1, std attention, models m0 and m1
    m0_TV1_std_wts <- with(df_complete_1, 
                           svyglm(as.formula(c("att_sex_ss~", covs)),
                                  design=des_1_std))
    m1_TV1_std_wts <- with(df_complete_1, 
                           svyglm(as.formula(c("att_sex_ss~", TV1vars, covs)),
                                  design=des_1_std))
    TV1_std_result_wts <- anova(m0_TV1_std_wts, m1_TV1_std_wts, method="Wald")
    TV1_std_result_wts_string <- with(TV1_std_result_wts, 
                                      paste0("F(", df, ", ", ddf, ") = ", 
                                             round(Ftest,3), ifelse(p<.001, " ***",
                                                                    ifelse(p<.01, " **",
                                                                           ifelse(p<.05, " *", "")))))
    
    # TV 3, std attention, models m0 and m1
    m0_TV3_std_wts <- with(df_complete_3, 
                           svyglm(as.formula(c("att_sex_ss~", covs)),
                                  design=des_3_std))
    m1_TV3_std_wts <- with(df_complete_3, 
                           svyglm(as.formula(c("att_sex_ss~", TV3vars, covs)),
                                  design=des_3_std))
    TV3_std_result_wts <- anova(m0_TV3_std_wts, m1_TV3_std_wts, method="Wald")
    TV3_std_result_wts_string <- with(TV3_std_result_wts, 
                                      paste0("F(", df, ", ", ddf, ") = ", 
                                             round(Ftest,3), ifelse(p<.001, " ***",
                                                                    ifelse(p<.01, " **",
                                                                           ifelse(p<.05, " *", "")))))
    
    
    # create covariate labels for the stargazer table
    #  depending on the order of the model
    
    cov.labels.expanded <- c(if(order==1) {c("TV hours per day age ~1.5", "TV hours per day age ~3")}, 
                             
                             if(order==2) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)")},
                             
                             if(order==3) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)", "TV age ~1.5 (cubed)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)", "TV age ~3 (cubed)")},
                             
                             if(order==4) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)", "TV age ~1.5 (cubed)", "TV age ~1.5 (4th power)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)", "TV age ~3 (cubed)", "TV age ~3 (4th power)")},
                             
                             if(order==5) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)", "TV age ~1.5 (cubed)", "TV age ~1.5 (4th power)", "TV age ~1.5 (5th power)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)", "TV age ~3 (cubed)", "TV age ~3 (4th power)", "TV age ~3 (5th power)")},
                             
                             cov.labels[2:length(cov.labels)])
    
    
    # make the stargazer table
    if (title==T) {
      stargazer(m1_TV1_raw, m1_TV1_raw_wts,
                m1_TV3_raw, m1_TV3_raw_wts,
                m1_TV1_std, m1_TV1_std_wts,
                m1_TV3_std, m1_TV3_std_wts,
                ci=TRUE, type="text", star.cutoffs=c(.05, .01, .001),
                covariate.labels=cov.labels.expanded,
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(4, 4),
                dep.var.labels.include=F,
                model.names=F,
                dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                notes=c("(1) (2) (5) (6) TV measured at age ~1.5; (3) (4) (7) (8) TV measured at age ~3", 
                        "(1) (3) (5) (7) No sample weights; (2) (4) (6) (8) Sample weights incorporated",
                        "Raw attention: lower is more impaired.", 
                        "Standardized attention: higher is more impaired."),
                notes.align="l", align=F,
                omit.stat=c("f", "ser", "ll", "aic"),
                add.lines=list(c("Joint test of TV  ", 
                                 TV1_raw_result_string, TV1_raw_result_wts_string,
                                 TV3_raw_result_string, TV3_raw_result_wts_string,
                                 TV1_std_result_string, TV1_std_result_wts_string,   
                                 TV3_std_result_string, TV3_std_result_wts_string), 
                               
                               c("", paste0("p = ", format(round(TV1_raw_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV1_raw_result_wts$p,4), nsmall=4)), #
                                 
                                 paste0("p = ", format(round(TV3_raw_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_raw_result_wts$p,4), nsmall=4)), #
                                 
                                 paste0("p = ", format(round(TV1_std_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV1_std_result_wts$p,4), nsmall=4)), # 
                                 
                                 paste0("p = ", format(round(TV3_std_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_std_result_wts$p,4), nsmall=4))),
                               c("", "", "", "", "")),
                out=here(subdirectory, output_string, 
                         paste0("results_", output_string, ".html")),
                title=paste0("Linear Regression Results Summary<br>", 
                             title_string))
    } else {
      stargazer(m1_TV1_raw, m1_TV1_raw_wts,
                m1_TV3_raw, m1_TV3_raw_wts,
                m1_TV1_std, m1_TV1_std_wts,
                m1_TV3_std, m1_TV3_std_wts,
                ci=TRUE, type="text", star.cutoffs=c(.05, .01, .001),
                covariate.labels=cov.labels.expanded,
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(4, 4),
                dep.var.labels.include=F,
                model.names=F,
                dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                notes=c("(1) (2) (5) (6) TV measured at age ~1.5; (3) (4) (7) (8) TV measured at age ~3", 
                        "(1) (3) (5) (7) No sample weights; (2) (4) (6) (8) Sample weights incorporated",
                        "Raw attention: lower is more impaired.", 
                        "Standardized attention: higher is more impaired."),
                notes.align="l", align=F,
                omit.stat=c("f", "ser", "ll", "aic"),
                add.lines=list(c("Joint test of TV  ", 
                                 TV1_raw_result_string, TV1_raw_result_wts_string,
                                 TV3_raw_result_string, TV3_raw_result_wts_string,
                                 TV1_std_result_string, TV1_std_result_wts_string,   
                                 TV3_std_result_string, TV3_std_result_wts_string), 
                               
                               c("", paste0("p = ", format(round(TV1_raw_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV1_raw_result_wts$p,4), nsmall=4)), #
                                 
                                 paste0("p = ", format(round(TV3_raw_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_raw_result_wts$p,4), nsmall=4)), #
                                 
                                 paste0("p = ", format(round(TV1_std_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV1_std_result_wts$p,4), nsmall=4)), # 
                                 
                                 paste0("p = ", format(round(TV3_std_result$p.value[2],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_std_result_wts$p,4), nsmall=4))),
                               c("", "", "", "", "")),
                out=here(subdirectory, output_string, 
                         paste0("results_", output_string, ".html")))
    }
    
    if (order==1) {
      reg_results <- rbind(
        c(summary(m1_TV1_raw)$coef[2,1:2], TV1_raw_result$p.value[2]),
        c(summary(m1_TV3_raw)$coef[2,1:2], TV3_raw_result$p.value[2]),
        c(summary(m1_TV1_std)$coef[2,1:2], TV1_std_result$p.value[2]),
        c(summary(m1_TV3_std)$coef[2,1:2], TV3_std_result$p.value[2]),
        
        c(summary(m1_TV1_raw_wts)$coef[2,1:2], TV1_raw_result_wts$p),
        c(summary(m1_TV3_raw_wts)$coef[2,1:2], TV3_raw_result_wts$p),
        c(summary(m1_TV1_std_wts)$coef[2,1:2], TV1_std_result_wts$p),
        c(summary(m1_TV3_std_wts)$coef[2,1:2], TV3_std_result_wts$p)
      )
    } else if (order==2) {   #f(TV) = b1(TV) + b2(TV^2), f'(TV) = b1 + b2*2*TV
      
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, rep(0,  (length(m1_TV1_raw$coef)-3))), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, rep(0,  (length(m1_TV3_raw$coef)-3))), nrow=1)
      
      reg_results <- rbind(
        c(tidy(summary(glht(m1_TV1_raw, contrasts.TV1)))[3:4], TV1_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_raw, contrasts.TV3)))[3:4], TV3_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV1_std, contrasts.TV1)))[3:4], TV1_std_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_std, contrasts.TV3)))[3:4], TV3_std_result$p.value[2]),
        
        unlist(c(tidy(summary(glht(m1_TV1_raw_wts, contrasts.TV1)))[3:4], TV1_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_raw_wts, contrasts.TV3)))[3:4], TV3_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV1_std_wts, contrasts.TV1)))[3:4], TV1_std_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_std_wts, contrasts.TV3)))[3:4], TV3_std_result_wts$p))
      )
    } else if (order==3) {   #f(TV) = b1(TV) + b2(TV^2) + b3(TV^3), f'(TV) = b1 + b2*2*TV + b3*3*TV^2
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, 3*TV1.median^2, rep(0,  (length(m1_TV1_raw$coef)-4))), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, 3*TV3.median^2, rep(0,  (length(m1_TV3_raw$coef)-4))), nrow=1)
      
      reg_results <- rbind(
        c(tidy(summary(glht(m1_TV1_raw, contrasts.TV1)))[3:4], TV1_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_raw, contrasts.TV3)))[3:4], TV3_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV1_std, contrasts.TV1)))[3:4], TV1_std_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_std, contrasts.TV3)))[3:4], TV3_std_result$p.value[2]),
        
        unlist(c(tidy(summary(glht(m1_TV1_raw_wts, contrasts.TV1)))[3:4], TV1_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_raw_wts, contrasts.TV3)))[3:4], TV3_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV1_std_wts, contrasts.TV1)))[3:4], TV1_std_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_std_wts, contrasts.TV3)))[3:4], TV3_std_result_wts$p))
      )
    } else if (order==4) {   #f(TV) = b1(TV) + b2(TV^2) + b3(TV^3) + b4(TV^4) 
      #f'(TV) = b1 + b2*2*TV + b3*3*TV^2 + b4*4*TV^3
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, 3*TV1.median^2, 4*TV1.median^3, 
                                rep(0,  (length(m1_TV1_raw$coef)-5))), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, 3*TV3.median^2, 4*TV3.median^3,
                                rep(0,  (length(m1_TV3_raw$coef)-5))), nrow=1)
      
      reg_results <- rbind(
        c(tidy(summary(glht(m1_TV1_raw, contrasts.TV1)))[3:4], TV1_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_raw, contrasts.TV3)))[3:4], TV3_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV1_std, contrasts.TV1)))[3:4], TV1_std_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_std, contrasts.TV3)))[3:4], TV3_std_result$p.value[2]),
        
        unlist(c(tidy(summary(glht(m1_TV1_raw_wts, contrasts.TV1)))[3:4], TV1_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_raw_wts, contrasts.TV3)))[3:4], TV3_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV1_std_wts, contrasts.TV1)))[3:4], TV1_std_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_std_wts, contrasts.TV3)))[3:4], TV3_std_result_wts$p))
      )
    } else if (order==5) {   #f(TV) = b1(TV) + b2(TV^2) + b3(TV^3) + b4(TV^4) + b5(TV^5)
      #f'(TV) = b1 + b2*2*TV + b3*3*TV^2 + b4*4*TV^3 + b5*5*TV^4
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, 3*TV1.median^2, 4*TV1.median^3, 5*TV1.median^4,
                                rep(0,  (length(m1_TV1_raw$coef)-6))), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, 3*TV3.median^2, 4*TV3.median^3, 5*TV1.median^4,
                                rep(0,  (length(m1_TV3_raw$coef)-6))), nrow=1)
      
      reg_results <- rbind(
        c(tidy(summary(glht(m1_TV1_raw, contrasts.TV1)))[3:4], TV1_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_raw, contrasts.TV3)))[3:4], TV3_raw_result$p.value[2]),
        c(tidy(summary(glht(m1_TV1_std, contrasts.TV1)))[3:4], TV1_std_result$p.value[2]),
        c(tidy(summary(glht(m1_TV3_std, contrasts.TV3)))[3:4], TV3_std_result$p.value[2]),
        
        unlist(c(tidy(summary(glht(m1_TV1_raw_wts, contrasts.TV1)))[3:4], TV1_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_raw_wts, contrasts.TV3)))[3:4], TV3_raw_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV1_std_wts, contrasts.TV1)))[3:4], TV1_std_result_wts$p)),
        unlist(c(tidy(summary(glht(m1_TV3_std_wts, contrasts.TV3)))[3:4], TV3_std_result_wts$p))
      )
    } else {
      
      reg_results <- rbind(
        c(NA, NA, TV1_raw_result$p.value[2]),
        c(NA, NA, TV3_raw_result$p.value[2]),
        c(NA, NA, TV1_std_result$p.value[2]),
        c(NA, NA, TV3_std_result$p.value[2]),
        
        c(NA, NA, TV1_raw_result_wts$p),
        c(NA, NA, TV3_raw_result_wts$p),
        c(NA, NA, TV1_std_result_wts$p),
        c(NA, NA, TV3_std_result_wts$p)
      )
    }
    
    results <- matrix(c(
      "Regression", NA, "ATE",  NA, NA, "~1.5", "Raw", NA, covariates, "listwise", order, NA, NA,
      "Regression", NA, "ATE",  NA, NA, "~3", "Raw", NA, covariates, "listwise", order, NA, NA,
      "Regression", NA, "ATE",  NA, NA, "~1.5", "Within-sex SS", NA, covariates, "listwise", order, NA, NA,
      "Regression", NA, "ATE",  NA, NA, "~3", "Within-sex SS", NA, covariates, "listwise", order, NA, NA,
      "Regression", NA, "ATE",  NA, NA, "~1.5", "Raw", NA, covariates, "listwise", order, "Sample weights", NA,
      "Regression", NA, "ATE",  NA, NA, "~3", "Raw", NA, covariates, "listwise", order, "Sample weights", NA, 
      "Regression", NA, "ATE",  NA, NA, "~1.5", "Within-sex SS", NA, covariates, "listwise", order, "Sample weights", NA, 
      "Regression", NA, "ATE",  NA, NA, "~3", "Within-sex SS", NA, covariates, "listwise", order, "Sample weights", NA),
      nrow=8, byrow=T) %>% data.frame()
    
    results <- cbind(results, reg_results) 
    
    names(results) <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
                        "Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
                        "Attention cutpoint", "Estimate", "StdErr", "p")
    
  } # closes if missing==listwise
  
  if (missing=="MI") { 
    
    # compute polynomial terms
    df$TV1_2 <- NA
    df$TV1_3 <- NA
    df$TV1_4 <- NA
    df$TV1_5 <- NA
    
    df$TV3_2 <- NA
    df$TV3_3 <- NA
    df$TV3_4 <- NA
    df$TV3_5 <- NA
    
    
    if (covariates=="Original") {
      
      df.mi <- mice(dplyr:: select(df,  unlist(strsplit(gsub(" ", "", 
                                                             gsub("\n", "", gsub("+", ", ", covs, fixed=T)), 
                                                             fixed=T), split=",", fixed=T)),
                                   TV1, TV3, att_sex_ss, attention, TV1_2,
                                   TV1_3, TV1_4, TV1_5, TV3_2, TV3_3, TV3_4,
                                   TV3_5), method=c("polyreg",
                                                    rep("pmm", 8), 
                                                    rep("logreg", 3),
                                                    "pmm",
                                                    "polyreg",
                                                    "logreg",
                                                    "polyreg",
                                                    rep("pmm", 4),
                                                    "~I(TV1^2)", "~I(TV1^3)",  "~I(TV1^4)",
                                                    "~I(TV1^5)",  "~I(TV3^2)",
                                                    "~I(TV3^3)",  "~I(TV3^4)",
                                                    "~I(TV3^5)"),
                    m=m, maxit=maxit, seed=seed)
      
      # make descriptives table for continuous variables
      
      dtable <-  complete(df.mi) %>% 
        dplyr::select("TV hours per day age 1.5" = TV1,
                      "TV hours per day age 3" = TV3,
                      "Attention (raw)" = attention,
                      "Attention within-sex SS" = att_sex_ss,
                      "Age (yrs) when attention was measured" = age,
                      "Cognitive stimulation of home age 1-3" = cogStim13,
                      "Emotional support of home age 1-3" = emoSupp13,
                      "Mother's years of schooling" = momEdu,
                      "Number of children in household" = kidsInHouse,
                      "Rosenberg self-esteem score (1987)" = Rosen87,
                      "CES-D Depression score (1992)" = CESD92,
                      "Gestational age (in weeks relative to term)" = gestationalAge) %>%
        summarise_all(lst(Validn, Mean, Sd, Min, Max)) %>%
        gather(key, value, everything()) %>%
        separate(key, into=c("variable", "stat"), sep="_") %>%
        pivot_wider(names_from="stat", values_from="value")
      
      names(dtable) <- c("Variable", "Valid n", "Mean", "Std Dev", "Min", "Max")
      
      
      # make descriptives table for categorical variables
      
      ctable <- 
        complete(df.mi) %>%
        dplyr::select(cohort, race, female, fatherAbsent,
                      alcohol, smoking, SMSA) %>%
        transmute_all(as.character) %>% 
        gather(key="variable", value="value", cohort, race, female, fatherAbsent,
               alcohol, smoking, SMSA) %>%
        group_by(variable, value) %>%
        summarise (n = n()) %>%
        mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
      
      # sort within groups so NA is always last
      ctable <- ctable %>% group_by(variable) %>% 
        dplyr::arrange(value, .by_group=T)
      
      # change NAs (which render as blanks) to "(missing)" in the table
      ctable$value <- ifelse(is.na(ctable$value), "(missing)", 
                             ctable$value)
      
      ctable$variable <- 
        ifelse(ctable$variable=="alcohol", 
               "Maternal alcohol use during pregnancy", 
               ifelse(ctable$variable=="cohort",
                      "Cohort", 
                      ifelse(ctable$variable=="fatherAbsent", 
                             "Father is absent from household", 
                             ifelse(ctable$variable=="female",
                                    "Female", 
                                    ifelse(ctable$variable=="lowBirthWt",
                                           "Low Birth Weight", 
                                           ifelse(ctable$variable=="race",
                                                  "Race",
                                                  ifelse(ctable$variable=="smoking",
                                                         "Maternal smoking during pregnancy",
                                                         ifelse(ctable$variable=="SMSA",
                                                                "Standard metropolitan statistical area",
                                                                ctable$variable))))))))
      
      for (i in seq(nrow(ctable), 2, by=-1)) {
        if (ctable$variable[i] == ctable$variable[i-1]) {ctable$variable[i] <- ""}
      }
      
      names(ctable) <- c("Variable", "Value", "n", "Percent")
      
      ### Save the correlation matrix of continuous variables
      
      # define functions to pick out categorical or continuous variables
      is.categorical <- function(x, levels=4) {length(table(x))<=levels}
      is.notcategorical <- function(...) {!is.categorical(...)}
      
      df_subset <- dplyr::select(complete(df.mi), unlist(strsplit(gsub(" ", "", gsub("\n", "", gsub("+", ", ", covs, fixed=T)), fixed=T), split=",", fixed=T)),
                                 attention, att_sex_ss, TV1, TV3)
      
      # need to identify continuous variables vs factors
      df_names_categorical <- df_subset[,sapply(df_subset, is.categorical)] %>% 
        names() 
      df_names_continuous <- df_subset[,sapply(df_subset, is.notcategorical)] %>%
        names() 
      
      r_continuous <- round(cor(dplyr::select(df,df_names_continuous), 
                                use="complete.obs"),2)
      
      
      r_continuous[upper.tri(r_continuous)]<-NA
      r_continuous <- as.data.frame(r_continuous)
      
      if (title==T) {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")),
                  title=paste0("Descriptive statistics for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Multiple imputation<br>",
                               "Descriptives from first imputed dataset"))
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")),
                  title=paste0("Descriptive statistics for categorical variables<br>", 
                               covariates, " covariate set<br>",
                               "Multiple imputation<br>",
                               "Descriptives from first imputed dataset"))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")),
                  title=paste0("Correlation matrix for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Multiple imputation<br>",
                               "Correlations computed on first imputed dataset"))
        
      } else {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")))
        
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")))
        
      } 
    } # closes if covariates==original
    
    if (covariates=="Expanded") { 
      df.mi <- mice(dplyr:: select(df,  unlist(strsplit(gsub(" ", "", 
                                                             gsub("\n", "", gsub("+", ", ", covs, fixed=T)), 
                                                             fixed=T), split=",", fixed=T)),
                                   TV1, TV3, att_sex_ss, attention, TV1_2,
                                   TV1_3, TV1_4, TV1_5, TV3_2, TV3_3, TV3_4,
                                   TV3_5), method=c("polyreg",
                                                    rep("pmm", 11), 
                                                    rep("logreg" ,6),
                                                    "polyreg",
                                                    "logreg",
                                                    "polyreg",
                                                    rep("pmm", 4),
                                                    "~I(TV1^2)", "~I(TV1^3)",  "~I(TV1^4)",
                                                    "~I(TV1^5)",  "~I(TV3^2)",
                                                    "~I(TV3^3)",  "~I(TV3^4)",
                                                    "~I(TV3^5)"),
                    m=m, maxit=maxit, seed=seed)
      
      # make descriptives table for continuous variables
      
      dtable <-  complete(df.mi) %>% 
        dplyr::select( "TV hours per day age 1.5" = TV1,
                       "TV hours per day age 3" = TV3,
                       "Attention (raw)" = attention,
                       "Attention within-sex SS" = att_sex_ss,
                       "Age (yrs) when attention was measured" = age,
                       "Temperament" = temperament,
                       "Cognitive stimulation of home age 1-3" = cogStim13,
                       "Emotional support of home age 1-3" = emoSupp13,
                       "Mother's years of schooling" = momEdu,
                       "Partner's years of schooling" = partnerEdu,
                       "Number of children in household" = kidsInHouse,
                       "Mother's age at birth" = momAge,
                       "Annual family income (thousands)" = income,
                       "Rosenberg self-esteem score (1987)" = Rosen87,
                       "CES-D Depression score (1992)" = CESD92) %>%
        summarise_all(lst(Validn, Mean, Sd, Min, Max)) %>%
        gather(key, value, everything()) %>%
        separate(key, into=c("variable", "stat"), sep="_") %>%
        pivot_wider(names_from="stat", values_from="value")
      
      names(dtable) <- c("Variable", "Valid n", "Mean", "Std Dev", "Min", "Max")
      
      
      # make descriptives table for categorical variables
      
      ctable <-
        complete(df.mi) %>%
        dplyr::select(cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
                      alcohol, smoking, preterm, SMSA) %>%
        transmute_all(as.character) %>% 
        gather(key="variable", value="value", cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
               alcohol, smoking, preterm, SMSA) %>%
        group_by(variable, value) %>%
        summarise (n = n()) %>%
        mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
      
      # sort within groups so NA is always last
      ctable <- ctable %>% group_by(variable) %>% 
        dplyr::arrange(value, .by_group=T)
      
      # change NAs (which render as blanks) to "(missing)" in the table
      ctable$value <- ifelse(is.na(ctable$value), "(missing)", 
                             ctable$value)
      
      ctable$variable <- 
        ifelse(ctable$variable=="alcohol", 
               "Maternal alcohol use during pregnancy", 
               ifelse(ctable$variable=="cohort",
                      "Cohort", 
                      ifelse(ctable$variable=="fatherAbsent", 
                             "Father is absent from household", 
                             ifelse(ctable$variable=="female",
                                    "Female", 
                                    ifelse(ctable$variable=="lowBirthWt",
                                           "Low Birth Weight", 
                                           ifelse(ctable$variable=="poorHealth",
                                                  "Poor health",
                                                  ifelse(ctable$variable=="preterm",
                                                         "Preterm birth",
                                                         ifelse(ctable$variable=="race",
                                                                "Race",
                                                                 ifelse(ctable$variable=="smoking",
                                                                        "Maternal smoking during pregnancy",
                                                                        ifelse(ctable$variable=="SMSA",
                                                                               "Standard metropolitan statistical area",
                                                                                ctable$variable))))))))))
      
      for (i in seq(nrow(ctable), 2, by=-1)) {
        if (ctable$variable[i] == ctable$variable[i-1]) {ctable$variable[i] <- ""}
      }
      
      names(ctable) <- c("Variable", "Value", "n", "Percent")
      
      ### Save the correlation matrix of continuous variables
      
      # define functions to pick out categorical or continuous variables
      is.categorical <- function(x, levels=4) {length(table(x))<=levels}
      is.notcategorical <- function(...) {!is.categorical(...)}
      
      df_subset <- dplyr::select(df,  unlist(strsplit(gsub(" ", "", gsub("\n", "", gsub("+", ", ", covs, fixed=T)), fixed=T), split=",", fixed=T)),
                                 attention, att_sex_ss, TV1, TV3)
      
      # need to identify continuous variables vs factors
      df_names_categorical <- df_subset[,sapply(df_subset, is.categorical)] %>% names() 
      df_names_continuous <- df_subset[,sapply(df_subset, is.notcategorical)] %>% names() 
      
      r_continuous <- round(cor(dplyr::select(df,df_names_continuous), 
                                use="complete.obs"),2)
      
      r_continuous[upper.tri(r_continuous)]<-NA
      r_continuous <- as.data.frame(r_continuous)
      
      
      if (title==T) {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")),
                  title=paste0("Descriptive statistics for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Multiple imputation<br>",
                               "Descriptives from first imputed dataset"))
        
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")),
                  title=paste0("Descriptive statistics for categorical variables<br>", 
                               covariates, " covariate set<br>",
                               "Multiple imputation<br>",
                               "Descriptives from first imputed dataset"))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")),
                  title=paste0("Correlation matrix for continuous variables<br>", 
                               covariates, " covariate set<br>",
                               "Multiple imputation<br>",
                               "Descriptives from first imputed dataset"))
        
      } else {
        stargazer(dtable, summary=F, rownames=F, header=F,
                  notes=" ", column.sep.width="20pt",
                  type="text",
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_continuous_", output_string, ".html")))
        
        stargazer(ctable, 
                  type="text", 
                  summary=F, 
                  rownames=F, 
                  header=F,
                  out=here(subdirectory, output_string, 
                           paste0("descriptives_categorical_", output_string, ".html")))
        
        stargazer(r_continuous,
                  type="text",
                  summary=F,
                  out=here(subdirectory, output_string, 
                           paste0("corr_matrix_", output_string, ".html")))
      } 
      
      
      
    } # closes if covariates==expanded
    
    m0_TV1_raw <- with(df.mi, lm(as.formula(c("attention~", covs))))
    m1_TV1_raw <- with(df.mi, lm(as.formula(c("attention~", TV1vars, covs))))
    TV1_raw_result <- mitml::testModels(model=m1_TV1_raw$analyses, 
                                        null.model=m0_TV1_raw$analyses, 
                                        method="D1")
    TV1_raw_result_string <- paste0("F(", TV1_raw_result$test[2],
                                    ", ", round(TV1_raw_result$test[3],2), ") = ", 
                                    round(TV1_raw_result$test[1],3), 
                                    ifelse(TV1_raw_result$test[4]<.001, " ***",
                                           ifelse(TV1_raw_result$test[4]<.01, " **",
                                                  ifelse(TV1_raw_result$test[4]<.05, " *", ""))))
    
    m0_TV3_raw <- with(df.mi, lm(as.formula(c("attention~", covs))))
    m1_TV3_raw <- with(df.mi, lm(as.formula(c("attention~", TV3vars, covs))))
    TV3_raw_result <- mitml::testModels(model=m1_TV3_raw$analyses, 
                                        null.model=m0_TV3_raw$analyses, 
                                        method="D1") 
    TV3_raw_result_string <- paste0("F(", TV3_raw_result$test[2],
                                    ", ", round(TV3_raw_result$test[3],2), ") = ", 
                                    round(TV3_raw_result$test[1],3), 
                                    ifelse(TV3_raw_result$test[4]<.001, " ***",
                                           ifelse(TV3_raw_result$test[4]<.01, " **",
                                                  ifelse(TV3_raw_result$test[4]<.05, " *", ""))))
    
    m0_TV1_std <- with(df.mi, lm(as.formula(c("att_sex_ss~", covs))))
    m1_TV1_std <- with(df.mi, lm(as.formula(c("att_sex_ss~", TV1vars, covs))))
    TV1_std_result <- mitml::testModels(model=m1_TV1_std$analyses, 
                                        null.model=m0_TV1_std$analyses, 
                                        method="D1") 
    TV1_std_result_string <- paste0("F(", TV1_std_result$test[2],
                                    ", ", round(TV1_std_result$test[3],2), ") = ", 
                                    round(TV1_std_result$test[1],3), 
                                    ifelse(TV1_std_result$test[4]<.001, " ***",
                                           ifelse(TV1_std_result$test[4]<.01, " **",
                                                  ifelse(TV1_std_result$test[4]<.05, " *", ""))))
    
    m0_TV3_std <- with(df.mi, lm(as.formula(c("att_sex_ss~", covs))))
    m1_TV3_std <- with(df.mi, lm(as.formula(c("att_sex_ss~", TV3vars, covs))))
    TV3_std_result <- mitml::testModels(model=m1_TV3_std$analyses, 
                                        null.model=m0_TV3_std$analyses, 
                                        method="D1") 
    TV3_std_result_string <- paste0("F(", TV3_std_result$test[2],
                                    ", ", round(TV3_std_result$test[3],2), ") = ", 
                                    round(TV3_std_result$test[1],3), 
                                    ifelse(TV3_std_result$test[4]<.001, " ***",
                                           ifelse(TV3_std_result$test[4]<.01, " **",
                                                  ifelse(TV3_std_result$test[4]<.05, " *", ""))))
    
    m1_TV1_raw_pooled <- summary(pool(m1_TV1_raw))
    m1_TV3_raw_pooled <- summary(pool(m1_TV3_raw))
    m1_TV1_std_pooled <- summary(pool(m1_TV1_std))
    m1_TV3_std_pooled <- summary(pool(m1_TV3_std))
    
    # make the stargazer tables
    
    # create covariate labels for the stargazer table
    #  depending on the order of the model
    
    dummymodel_raw1 <- lm(data=complete(df.mi), as.formula(c("attention~", TV1vars, covs)))
    dummymodel_raw3 <- lm(data=complete(df.mi), as.formula(c("attention~", TV3vars, covs)))
    dummymodel_std1 <- lm(data=complete(df.mi), as.formula(c("att_sex_ss~", TV1vars, covs)))
    dummymodel_std3 <- lm(data=complete(df.mi), as.formula(c("att_sex_ss~", TV3vars, covs)))
    
    cov.labels.expanded <- c(if(order==1) {c("TV hours per day age ~1.5", "TV hours per day age ~3")}, 
                             
                             if(order==2) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)")},
                             
                             if(order==3) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)", "TV age ~1.5 (cubed)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)", "TV age ~3 (cubed)")},
                             
                             if(order==4) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)", "TV age ~1.5 (cubed)", "TV age ~1.5 (4th power)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)", "TV age ~3 (cubed)", "TV age ~3 (4th power)")},
                             
                             if(order==5) {c("TV hours per day age ~1.5", "TV age ~1.5 (squared)", "TV age ~1.5 (cubed)", "TV age ~1.5 (4th power)", "TV age ~1.5 (5th power)",
                                             "TV hours per day age ~3", "TV age ~3 (squared)", "TV age ~3 (cubed)", "TV age ~3 (4th power)", "TV age ~3 (5th power)")},
                             
                             cov.labels[2:length(cov.labels)])
    
    if (title==T) { 
      stargazer(dummymodel_raw1, dummymodel_raw3, dummymodel_std1, dummymodel_std3, 
                type="text",
                coef=list(m1_TV1_raw_pooled[,1], m1_TV3_raw_pooled[,1], 
                          m1_TV1_std_pooled[,1], m1_TV3_std_pooled[,1]),
                se=list(m1_TV1_raw_pooled[,2], m1_TV3_raw_pooled[,2], 
                        m1_TV1_std_pooled[,2], m1_TV3_std_pooled[,2]),
                ci=T,
                star.cutoffs=c(.05, .01, .001),
                covariate.labels=cov.labels.expanded,
                multicolumn=T,
                model.names=F,
                omit.stat=c("ll", "aic", "rsq", "adj.rsq", "ser", "f"),
                dep.var.labels.include=F,
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(2,2),
                dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                notes=c("(1) (3) TV measured at age ~1.5; (2) (4) TV measured at age ~3", 
                        "Raw attention: lower is more impaired.", 
                        "Standardized attention: higher is more impaired."),
                notes.align="l", align=F,
                add.lines=list(c("Joint test of TV  ", 
                                 TV1_raw_result_string,  
                                 TV3_raw_result_string, 
                                 TV1_std_result_string,   
                                 TV3_std_result_string), 
                               c("", paste0("p = ", format(round(TV1_raw_result$test[4],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_raw_result$test[4],4), nsmall=4)),
                                 paste0("p = ", format(round(TV1_std_result$test[4],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_std_result$test[4],4), nsmall=4))),
                               c("", "", "", "", "")),
                out=here(subdirectory, output_string, 
                         paste0("results_", output_string, "_MI.html")),
                title=paste0("Linear Regression Results Summary<br>", 
                             "Sample weights incorporated<br>",
                             title_string))
    } else {
      stargazer(dummymodel_raw1, dummymodel_raw3, dummymodel_std1, dummymodel_std3, 
                type="text",
                coef=list(m1_TV1_raw_pooled[,1], m1_TV3_raw_pooled[,1], 
                          m1_TV1_std_pooled[,1], m1_TV3_std_pooled[,1]),
                se=list(m1_TV1_raw_pooled[,2], m1_TV3_raw_pooled[,2], 
                        m1_TV1_std_pooled[,2], m1_TV3_std_pooled[,2]),
                ci=T,
                star.cutoffs=c(.05, .01, .001),
                covariate.labels=cov.labels.expanded,
                multicolumn=T,
                model.names=F,
                omit.stat=c("ll", "aic", "rsq", "adj.rsq", "ser", "f"),
                dep.var.labels.include=F,
                column.labels=c("Raw attention", "Within-sex standardized attention"),
                column.separate=c(2,2),
                dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                notes=c("(1) (3) TV measured at age ~1.5; (2) (4) TV measured at age ~3", 
                        "Raw attention: lower is more impaired.", 
                        "Standardized attention: higher is more impaired."),
                notes.align="l", align=F,
                add.lines=list(c("Joint test of TV  ", 
                                 TV1_raw_result_string,  
                                 TV3_raw_result_string, 
                                 TV1_std_result_string,   
                                 TV3_std_result_string), 
                               c("", paste0("p = ", format(round(TV1_raw_result$test[4],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_raw_result$test[4],4), nsmall=4)),
                                 paste0("p = ", format(round(TV1_std_result$test[4],4), nsmall=4)),
                                 paste0("p = ", format(round(TV3_std_result$test[4],4), nsmall=4))),
                               c("", "", "", "", "")),
                out=here(subdirectory, output_string, 
                         paste0("results_", output_string, "_MI.html")))
    } # closes else if title=T
    
    
    if (order==1) {
      reg_results <- rbind(
        c(m1_TV1_raw_pooled[2,1:2], TV1_raw_result$test[4]),
        c(m1_TV1_raw_pooled[2,1:2], TV3_raw_result$test[4]),
        c(m1_TV1_std_pooled[2,1:2], TV1_std_result$test[4]),
        c(m1_TV1_std_pooled[2,1:2], TV3_std_result$test[4])
      )
      
    } else if (order==2) {  #f(TV) = b1(TV) + b2(TV^2)
      #f'(TV) = b1 + b2*2*TV 
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, rep(0,  nrow(m1_TV1_raw_pooled)-3)), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, rep(0,  nrow(m1_TV3_raw_pooled)-3)), nrow=1)
      
      TV1_raw_derivative <- t(sapply(m1_TV1_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_raw_derivative <- t(sapply(m1_TV3_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      TV1_std_derivative <- t(sapply(m1_TV1_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_std_derivative <- t(sapply(m1_TV3_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      reg_results <- rbind(
        c(pooled.contrast(TV1_raw_derivative), TV1_raw_result$test[4]),
        c(pooled.contrast(TV3_raw_derivative), TV3_raw_result$test[4]),
        c(pooled.contrast(TV1_std_derivative), TV1_std_result$test[4]),
        c(pooled.contrast(TV3_std_derivative), TV3_std_result$test[4])
      )
    } else if (order==3) {   #f(TV) = b1(TV) + b2(TV^2) + b3(TV^3)
      #f'(TV) = b1 + b2*2*TV + b3*3*TV^2 
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, 3*TV1.median^2, 
                                rep(0,  nrow(m1_TV1_raw_pooled)-4)), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, 3*TV3.median^2, 
                                rep(0,  nrow(m1_TV3_raw_pooled)-4)), nrow=1)
      
      TV1_raw_derivative <- t(sapply(m1_TV1_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_raw_derivative <- t(sapply(m1_TV3_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      TV1_std_derivative <- t(sapply(m1_TV1_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_std_derivative <- t(sapply(m1_TV3_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      reg_results <- rbind(
        c(pooled.contrast(TV1_raw_derivative), TV1_raw_result$test[4]),
        c(pooled.contrast(TV3_raw_derivative), TV3_raw_result$test[4]),
        c(pooled.contrast(TV1_std_derivative), TV1_std_result$test[4]),
        c(pooled.contrast(TV3_std_derivative), TV3_std_result$test[4])
      )
      
    } else if (order==4) {   #f(TV) = b1(TV) + b2(TV^2) + b3(TV^3)
      #f'(TV) = b1 + b2*2*TV + b3*3*TV^2 
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, 3*TV1.median^2, 4*TV1.median^3,
                                rep(0,  nrow(m1_TV1_raw_pooled)-5)), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, 3*TV3.median^2, 4*TV3.median^3,
                                rep(0,  nrow(m1_TV3_raw_pooled)-5)), nrow=1)
      
      TV1_raw_derivative <- t(sapply(m1_TV1_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_raw_derivative <- t(sapply(m1_TV3_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      TV1_std_derivative <- t(sapply(m1_TV1_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_std_derivative <- t(sapply(m1_TV3_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      reg_results <- rbind(
        c(pooled.contrast(TV1_raw_derivative), TV1_raw_result$test[4]),
        c(pooled.contrast(TV3_raw_derivative), TV3_raw_result$test[4]),
        c(pooled.contrast(TV1_std_derivative), TV1_std_result$test[4]),
        c(pooled.contrast(TV3_std_derivative), TV3_std_result$test[4])
      )
    } else if (order==5) {   #f(TV) = b1(TV) + b2(TV^2) + b3(TV^3)
      #f'(TV) = b1 + b2*2*TV + b3*3*TV^2 
      
      contrasts.TV1 <- matrix(c(0,1, 2*TV1.median, 3*TV1.median^2, 4*TV1.median^3, 5*TV1.median^4,
                                rep(0,  nrow(m1_TV1_raw_pooled)-6)), nrow=1)
      contrasts.TV3 <- matrix(c(0,1, 2*TV3.median, 3*TV3.median^2, 4*TV3.median^3, 5*TV3.median^4,
                                rep(0,  nrow(m1_TV3_raw_pooled)-6)), nrow=1)
      
      TV1_raw_derivative <- t(sapply(m1_TV1_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_raw_derivative <- t(sapply(m1_TV3_raw$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      TV1_std_derivative <- t(sapply(m1_TV1_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV1)))}))
      
      TV3_std_derivative <- t(sapply(m1_TV3_std$analyses, 
                                     function(x){tidy(summary(glht(x, linfct=contrasts.TV3)))}))
      
      reg_results <- rbind(
        c(pooled.contrast(TV1_raw_derivative), TV1_raw_result$test[4]),
        c(pooled.contrast(TV3_raw_derivative), TV3_raw_result$test[4]),
        c(pooled.contrast(TV1_std_derivative), TV1_std_result$test[4]),
        c(pooled.contrast(TV3_std_derivative), TV3_std_result$test[4])
      )
    } else {
      reg_results <- rbind(
        c(NA, NA, TV1_raw_result$test[4]),
        c(NA, NA, TV3_raw_result$test[4]),
        c(NA, NA, TV1_std_result$test[4]),
        c(NA, NA, TV3_std_result$test[4])
      )
    }
    
    results <- matrix(c(
      "Regression", NA, "ATE",  NA, NA, "~1.5", "Raw", NA, covariates, "multiple imputation", order, NA, NA, 
      "Regression", NA, "ATE",  NA, NA, "~3", "Raw", NA, covariates, "multiple imputation", order, NA, NA, 
      "Regression", NA, "ATE",  NA, NA, "~1.5", "Within-sex SS", NA, covariates, "multiple imputation", order, NA, NA, 
      "Regression", NA, "ATE",  NA, NA, "~3", "Within-sex SS", NA, covariates, "multiple imputation", order, NA, NA),
      nrow=4, byrow=T) %>% data.frame()
    
    results <- cbind(results, reg_results) 
    
    names(results) <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
                        "Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
                        "Attention cutpoint", "Estimate", "StdErr", "p")
    
  } # closes if missing==MI
  
  return(results)  
  # turn warnings back on
  options(warn = 0)    
}

# Test the regression analysis function -----------------------------------

# test it
# regression(data=analysis, subdirectory="Results", missing="listwise",
#            covariates="Original", order=1, title=TRUE,
#            m=2, maxit=3, seed=1)
# 
# regression(data=analysis, subdirectory="Results", missing="listwise",
#            covariates="Expanded", order=1, title=TRUE,
#            m=3, maxit=3, seed=1)
# 
# regression(data=analysis, subdirectory="Results", missing="MI",
#            covariates="Original", order=2, title=TRUE,
#            m=3, maxit=3, seed=1)
# 
# regression(data=analysis, subdirectory="Results", missing="MI",
#            covariates="Expanded", order=2, title=TRUE,
#            m=3, maxit=3, seed=1)


# Define the logistic regression function ---------------------------------

####################################################
#                                                  #
#   Function for logistic regression analysis      #
#                                                  #
####################################################

logistic <- function(data, subdirectory, missing, covariates, att_cutpoints, title=TRUE,
                     m=10, maxit=50, seed=1) {
  
  results <- list()
  
  # some of these function calls produce meaningless warnings
  # this suppresses them. You can comment this out for safety
  options(warn = -1)      
  
  # make temp copy of data frame
  df <- data
  
  # convert female and fatherAbsent variables to factors
  df$female <- factor(df$female, levels=c(0,1), labels=c("No", "Yes"))
  df$fatherAbsent <- factor(df$fatherAbsent, levels=c(0,1), labels=c("No", "Yes"))
  df$poorHealth <- factor(df$poorHealth, levels=c(0,1), labels=c("No", "Yes"))
  df$preterm <- factor(df$preterm, levels=c(0,1), labels=c("No", "Yes"))
  df$lowBirthWt <- factor(df$lowBirthWt, levels=c(0,1), labels=c("No", "Yes"))
  
  # find the percentile for standardized attention at the current cutpoint
  #   and the corresponding raw attention cutpoint at an equivalent percentile
  percentiles <- sapply(att_cutpoints, function(x) {nrow(df[df$att_sex_ss < x,])}) / nrow(df)
  raw_attn_cutpoints <- quantile(df$attention, probs=(1-percentiles), na.rm=T)
  
  if (covariates=="Original") {
    covs <- "cohort+age+cogStim13+emoSupp13+
              momEdu+kidsInHouse+momAge+Rosen87+CESD92+
              alcohol+fatherAbsent+female+gestationalAge+
              race+smoking+SMSA"
    
    ncovs <- 16
    
    cov.labels <- c("TV hour per day (age ~1.5)", 
                    "TV hours per day (age ~3)", 
                    "Cohort = 1998", "Cohort = 2000", 
                    "Age at index", "Cognitive stimulation of home",
                    "Emotional support of home", "Maternal years of education",
                    "Children in the household", "Maternal age at birth",
                    "Maternal self-esteem (1987)", 
                    "Maternal depression (1992)", "Alcohol use in pregnancy",
                    "Father absent from household",
                    "Sex = female", "Gestational age at birth", "Race = Black", 
                    "Race = White", "Smoking in pregnancy", 
                    "SMSA; not central city", "SMSA; central city unknown", 
                    "SMSA; in central city",
                    "Intercept")
    
  } # closes if covariates==original
  
  if (covariates=="Expanded") {
    
    covs <- "cohort+age+temperament+cogStim13+emoSupp13+momEdu+partnerEdu+kidsInHouse+
              momAge+income+Rosen87+CESD92+alcohol+fatherAbsent+female+lowBirthWt+
              poorHealth+preterm+race+smoking+SMSA"
    
    ncovs <- 21
    
    
    cov.labels <- c("TV hours per day (age ~1.5)", 
                    "TV hours per day (age ~3)", 
                    "Cohort = 1998", "Cohort = 2000", 
                    "Age at index", "Temperament", 
                    "Cognitive stimulation of home",
                    "Emotional support of home", 
                    "Maternal years of education",
                    "Partner years of education",
                    "Children in the household", "Maternal age at birth",
                    "Family income ($k)", "Maternal self-esteem (1987)", 
                    "Maternal depression (1992)", "Alcohol use during pregnancy",
                    "Father absent from household", "Sex = female", 
                    "Low birth weight", "Child poor health", "Preterm delivery", 
                    "Race = Black", "Race = White", "Smoking in pregnancy", 
                    "SMSA; not central city", "SMSA; central city unknown", 
                    "SMSA; in central city", "Intercept")
  } # closes if covariates==expanded
  
  if (missing=="MI") {
    att_cats_empty_df <- matrix(ncol=length(att_cutpoints)*2, nrow=nrow(df)) %>% as.data.frame()
    df.expanded <- cbind(df, att_cats_empty_df)
    
    names(df.expanded) <- c(names(df), paste0("att_sex_ss_cat_", att_cutpoints),
                            paste0("attention_cat_", att_cutpoints))
    
    if (covariates=="Original") {
      
      df.mi <- mice(dplyr::select(df.expanded,  unlist(strsplit(gsub(" ", "", 
                                                                     gsub("\n", "", gsub("+", ", ", covs, fixed=T)), 
                                                                     fixed=T), split=",", fixed=T)),
                                  TV1, TV3, att_sex_ss, attention, sampleWt, 
                                  names(df.expanded)[(ncol(df.expanded)-(2*length(att_cutpoints))+1):ncol(df.expanded)]), 
                    method=c("polyreg", rep("cart", 8), rep("logreg", 3), "cart", "polyreg",
                             "logreg", "polyreg", rep("cart", 4), "",
                             c(paste0("~I(ifelse(att_sex_ss >", att_cutpoints, ", 1, 0))")),
                             c(paste0("~I(ifelse(attention <", raw_attn_cutpoints, ", 1, 0))"))),
                    
                    m=m, maxit=maxit, seed=seed)
    } # closes if covariates=Original
    
    if (covariates=="Expanded") {
      
      df.mi <- mice(dplyr::select(df.expanded,  unlist(strsplit(gsub(" ", "", 
                                                                     gsub("\n", "", gsub("+", ", ", covs, fixed=T)), 
                                                                     fixed=T), split=",", fixed=T)),
                                  TV1, TV3, att_sex_ss, attention, sampleWt, 
                                  names(df.expanded)[(ncol(df.expanded)-(2*length(att_cutpoints))+1):ncol(df.expanded)]), 
                    method=c("polyreg",
                             rep("cart", 11), 
                             rep("logreg" ,6),
                             "polyreg",
                             "logreg",
                             "polyreg",
                             rep("cart", 4),
                             "",
                             c(paste0("~I(ifelse(att_sex_ss >", att_cutpoints, ", 1, 0))")),
                             c(paste0("~I(ifelse(attention <", raw_attn_cutpoints, ", 1, 0))"))),
                    
                    m=m, maxit=maxit, seed=seed)
    } # closes if covariates=Expanded
    
  } # closes if missing=MI
  
  if (missing=="listwise") {
    # add attention variables to df
    df.expanded <- cbind(df, 
                         sapply(att_cutpoints, function(x) {ifelse(df$att_sex_ss > x, 1, 0)}),
                         sapply(raw_attn_cutpoints, function(x) {ifelse(df$attention < x, 1, 0)})
    )
    
    names(df.expanded) <- c(names(df), paste0("att_sex_ss_cat_", att_cutpoints),
                            paste0("attention_cat_", att_cutpoints))
  } # close if missing=listwise
  
  for (i in 1:length(att_cutpoints)) {
    
    print(i)
    
    output_string <- paste0("logistic", "_", covariates, "_", ifelse(missing=="MI", "MI", "listwise"), 
                            "_attCutpoint=", att_cutpoints[i])
    
    title_string <- paste0(covariates, " covariate set, Missing data by ",  
                           ifelse(missing=="MI", "multiple imputation", "listwise deletion"), 
                           ", Attention cutoff = ", att_cutpoints[i])
    
    # check if subdirectory exists
    # if not, create it
    if (!dir.exists(here(subdirectory, output_string))) {
      dir.create(here(subdirectory, output_string), showWarnings=F)
    } 
    
    if (missing=="listwise") {
      
      des_1_raw <- svydesign(ids = ~1, data=df.expanded, weights=df.expanded$sampleWt, 
                             variables=as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV1+"), covs)))
      
      des_3_raw <- svydesign(ids = ~1, data=df.expanded, weights=df.expanded$sampleWt, 
                             variables=as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV3+"), covs)))
      
      des_1_std <- svydesign(ids = ~1, data=df.expanded, weights=df.expanded$sampleWt, 
                             variables=as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV1+"), covs)))
      
      des_3_std <- svydesign(ids = ~1, data=df.expanded, weights=df.expanded$sampleWt, 
                             variables=as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV3+"), covs)))
      
      # fit models with sample weights
      
      logit_1_raw_wts <- with(df.expanded, svyglm(as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV1+"), covs)),
                                                  design=des_1_raw, 
                                                  family=quasibinomial(link="logit")))
      
      logit_3_raw_wts <- with(df.expanded, svyglm(as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV3+"), covs)),
                                                  design=des_3_raw, 
                                                  family=quasibinomial(link="logit")))
      
      logit_1_std_wts <- with(df.expanded, svyglm(as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV1+"), covs)),
                                                  design=des_1_std, 
                                                  family=quasibinomial(link="logit")))
      
      logit_3_std_wts <- with(df.expanded, svyglm(as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV3+"), covs)),
                                                  design=des_3_std, 
                                                  family=quasibinomial(link="logit")))
      
      # fit models without weights
      
      
      logit_1_raw <- with(df.expanded, glm(as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV1+"), covs)),
                                           family=binomial(link="logit")))
      
      logit_3_raw <- with(df.expanded, glm(as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV3+"), covs)),
                                           family=binomial(link="logit")))
      
      logit_1_std <- with(df.expanded, glm(as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV1+"), covs)),
                                           family=binomial(link="logit")))
      
      logit_3_std <- with(df.expanded, glm(as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV3+"), covs)),
                                           family=binomial(link="logit")))
      
      logistic_results <- rbind(
        c(summary(logit_1_raw_wts)$coef[2,c(1,2,4)]),
        c(summary(logit_3_raw_wts)$coef[2,c(1,2,4)]),
        c(summary(logit_1_std_wts)$coef[2,c(1,2,4)]),
        c(summary(logit_3_std_wts)$coef[2,c(1,2,4)]),
        c(summary(logit_1_raw)$coef[2,c(1,2,4)]),
        c(summary(logit_3_raw)$coef[2,c(1,2,4)]),
        c(summary(logit_1_std)$coef[2,c(1,2,4)]),
        c(summary(logit_3_std)$coef[2,c(1,2,4)])
      )
      
      results_names <- matrix(c(
        "Logistic", "", "",  NA, "", "~1.5", "Raw", NA, covariates, "listwise", NA, "Sample weights", raw_attn_cutpoints[i],
        "Logistic", "", "",  NA, "", "~3", "Raw", NA, covariates, "listwise", NA, "Sample weights", raw_attn_cutpoints[i],
        "Logistic", "", "",  NA, "", "~1.5", "Within-sex SS", NA, covariates, "listwise", NA, "Sample weights", att_cutpoints[i],
        "Logistic", "", "",  NA, "", "~3", "Within-sex SS", NA, covariates, "listwise", NA, "Sample weights", att_cutpoints[i],
        "Logistic", "", "",  NA, "", "~1.5", "Raw", NA, covariates, "listwise", NA, NA, raw_attn_cutpoints[i],
        "Logistic", "", "",  NA, "", "~3", "Raw", NA, covariates, "listwise", NA, NA, raw_attn_cutpoints[i],
        "Logistic", "", "",  NA, "", "~1.5", "Within-sex SS", NA, covariates, "listwise", NA, NA, att_cutpoints[i],
        "Logistic", "", "",  NA, "", "~3", "Within-sex SS", NA, covariates, "listwise", NA, NA, att_cutpoints[i]),
        nrow=8, byrow=T) %>% data.frame()
      
      results[[i]] <- cbind(results_names, logistic_results)
      
      names(results[[i]]) <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
                               "Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
                               "Attention cutpoint", "Estimate", "StdErr", "p")
      
      # make the stargazer output table
      #  without sample weights
      
      percentile <- length(df.expanded$att_sex_ss[df.expanded$att_sex_ss < att_cutpoints[i]]) / 
        length(df.expanded$att_sex_ss)
      
      percentileF <- format((round(percentile,3)*100), nsmall=1)
      percentile_suffix <- ifelse(substr(percentileF, 4, 4) %in% c(0, 4, 5, 6, 7, 8, 9), "th", 
                                  ifelse(substr(percentileF, 4, 4) == "1", "st", 
                                         ifelse(substr(percentileF, 4, 4) == "2", "nd", "rd")))
      
      if (title==T) {
        stargazer(logit_1_raw, logit_1_raw_wts, 
                  logit_3_raw, logit_3_raw_wts,
                  logit_1_std, logit_1_std_wts, 
                  logit_3_std, logit_3_std_wts,
                  ci=TRUE, type="text", star.cutoffs=c(.05, .01, .001),
                  covariate.labels=cov.labels,
                  multicolumn=T,
                  column.labels=c("Dichotomized raw attention", "Dichotomized within-sex standardized attention"),
                  column.separate=c(4,4),
                  model.names=F,
                  #dep.var.labels=rep("", 8),
                  dep.var.labels.include=F,
                  dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                  notes=c("(1) (2) (5) (6) TV measured at age ~1.5; (3) (4) (7) (8) TV measured at age ~3", 
                          "(1) (3) (5) (7) No sample weights; (2) (4) (6) (8) Sample weights incorporated",
                          paste0("Problematic standardized attention is ", att_cutpoints[i], " and above (", 
                                 percentileF, percentile_suffix, " percentile)"),
                          paste0("Problematic raw attention is ", raw_attn_cutpoints[i], " and below (equivalent percentile)"),
                          "Models estimate the probability of classification into the problematic attention category as defined by the cutpoint."),
                  notes.align="l", align=F,
                  omit.stat=c("f", "ser"),
                  out=here(subdirectory, output_string,
                           paste0("results_", output_string, ".html")),
                  title=paste0("Logistic Regression Results Summary<br>", 
                               title_string))
        
        
      } else {
        stargazer(logit_1_raw, logit_1_raw_wts, 
                  logit_3_raw, logit_3_raw_wts,
                  logit_1_std, logit_1_std_wts, 
                  logit_3_std, logit_3_std_wts,
                  ci=TRUE, type="text", star.cutoffs=c(.05, .01, .001),
                  covariate.labels=cov.labels,
                  multicolumn=T,
                  column.labels=c("Dichotomized raw attention", "Dichotomized within-sex standardized attention"),
                  column.separate=c(4,4),
                  model.names=F,
                  #dep.var.labels=rep("", 8),
                  dep.var.labels.include=F,
                  dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                  notes=c("(1) (2) (5) (6) TV measured at age ~1.5; (3) (4) (7) (8) TV measured at age ~3", 
                          "(1) (3) (5) (7) No sample weights; (2) (4) (6) (8) Sample weights incorportated",
                          paste0("Problematic standardized attention is ", att_cutpoints[i], " and above (", 
                                 percentileF, percentile_suffix, " percentile)"),
                          paste0("Problematic raw attention is ", raw_attn_cutpoints[i], " and below (equivalent percentile)"),
                          "Models estimate the probability of classification into the problematic attention category as defined by the cutpoint."),
                  notes.align="l", align=F,
                  omit.stat=c("f", "ser"),
                  out=here(subdirectory, output_string,
                           paste0("results_", output_string, ".html")))
        
      } # closes else title toggle
      
    } # closes missing=listwise
    
    if (missing=="MI") {

      # fit models without weights
      
      
      logit_1_raw_mi <- summary(pool(with(df.mi, glm(as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV1+"), covs)),
                                                     family=binomial(link="logit")))))
      
      logit_3_raw_mi <- summary(pool(with(df.mi, glm(as.formula(c(paste0("attention_cat_", att_cutpoints[i], "~TV3+"), covs)),
                                                     family=binomial(link="logit")))))
      
      logit_1_std_mi <- summary(pool(with(df.mi, glm(as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV1+"), covs)),
                                                     family=binomial(link="logit")))))
      
      logit_3_std_mi <- summary(pool(with(df.mi, glm(as.formula(c(paste0("att_sex_ss_cat_", att_cutpoints[i], "~TV3+"), covs)),
                                                     family=binomial(link="logit")))))
      
      logistic_results <- rbind(
        unlist(logit_1_raw_mi[2,c(1,2,5)]),
        unlist(logit_3_raw_mi[2,c(1,2,5)]),
        unlist(logit_1_std_mi[2,c(1,2,5)]),
        unlist(logit_3_std_mi[2,c(1,2,5)])
      )
      
      results_names <- matrix(c(
        "Logistic", "", "",  NA, "", "~1.5", "Raw", NA, covariates, "multiple imputation", NA, NA, raw_attn_cutpoints[i],
        "Logistic", "", "",  NA, "", "~3", "Raw", NA, covariates, "multiple imputation", NA, NA, raw_attn_cutpoints[i],
        "Logistic", "", "",  NA, "", "~1.5", "Within-sex SS", NA, covariates, "multiple imputation", NA, NA, att_cutpoints[i],
        "Logistic", "", "",  NA, "", "~3", "Within-sex SS", NA, covariates, "multiple imputation", NA, NA, att_cutpoints[i]),
        nrow=4, byrow=T) %>% data.frame()
      
      results[[i]] <- cbind(results_names, logistic_results)
      
      names(results[[i]]) <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV age", 
                               "Outcome", "Doubly robust", "Covariates", "Missing", "Order", "Sample weights",
                               "Attention cutpoint", "Estimate", "StdErr", "p")
      
      # make the stargazer output tables
      #  without sample weights
      
      percentile <- length(complete(df.mi)$att_sex_ss[complete(df.mi)$att_sex_ss < att_cutpoints[i]]) / 
        length(complete(df.mi)$att_sex_ss)
      
      percentileF <- format((round(percentile,3)*100), nsmall=1)
      percentile_suffix <- ifelse(substr(percentileF, 4, 4) %in% c(0, 4, 5, 6, 7, 8, 9), "th", 
                                  ifelse(substr(percentileF, 4, 4) == "1", "st", 
                                         ifelse(substr(percentileF, 4, 4) == "2", "nd", "rd")))
      
      
      dummymodel1 <- glm(data=complete(df.mi), as.formula(c("cut(attention, breaks=c(-Inf, 100, Inf))~TV1+", covs)), 
                         family=binomial(link="logit"))
      
      dummymodel2 <- glm(data=complete(df.mi), as.formula(c("cut(attention, breaks=c(-Inf, 100, Inf))~TV3+", covs)), 
                         family=binomial(link="logit"))
      
      if (title==T) {
        stargazer(dummymodel1, dummymodel2, dummymodel1, dummymodel2, type="text",
                  coef=list(logit_1_raw_mi$estimate, logit_3_raw_mi$estimate, 
                            logit_1_std_mi$estimate, logit_3_std_mi$estimate),
                  se=list(logit_1_raw_mi$std.error, logit_3_raw_mi$std.error,
                          logit_1_std_mi$std.error, logit_3_std_mi$std.error),
                  #p=list(logit_1_raw_mi$p.value, logit_3_raw_mi$p.value),
                  ci=T,
                  star.cutoffs=c(.05, .01, .001),
                  covariate.labels=cov.labels,
                  multicolumn=T,
                  model.names=F,
                  omit.stat=c("ll", "aic"),
                  dep.var.labels.include=F,
                  column.labels=c("Dichotomized raw attention", "Dichotomized within-sex<br>standardized attention"),
                  column.separate=c(2,2),
                  dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                  notes=c("(1) (3) TV measured at age ~1.5; (2) (4) TV measured at age ~3", 
                          paste0("Problematic standardized attention defined as ", att_cutpoints[i], " and above (", 
                                 percentileF, percentile_suffix, " percentile)"),
                          paste0("Problematic raw attention defined as ", raw_attn_cutpoints[i], " and below (equivalent percentile)"),
                          "Models estimate the probability of classification into the problematic attention category as defined by the cutpoint."),
                  notes.align="l", align=F,
                  out=here(subdirectory, output_string,
                           paste0("results_", output_string, "_MI.html")),
                  title=paste0("Logistic Regression Results Summary<br>", 
                               title_string))
      } else {
        stargazer(dummymodel1, dummymodel2, dummymodel1, dummymodel2, type="text",
                  coef=list(logit_1_raw_mi$estimate, logit_3_raw_mi$estimate, 
                            logit_1_std_mi$estimate, logit_3_std_mi$estimate),
                  se=list(logit_1_raw_mi$std.error, logit_3_raw_mi$std.error,
                          logit_1_std_mi$std.error, logit_3_std_mi$std.error),
                  ci=T,
                  star.cutoffs=c(.05, .01, .001),
                  covariate.labels=cov.labels,
                  multicolumn=T,
                  model.names=F,
                  omit.stat=c("ll", "aic"),
                  dep.var.labels.include=F,
                  column.labels=c("Dichotomized raw attention", "Dichotomized within-sex<br>standardized attention"),
                  column.separate=c(2,2),
                  dep.var.labels = c("Raw attention", "Within-sex standardized attention"),
                  notes=c("(1) (3) TV measured at age ~1.5; (2) (4) TV measured at age ~3", 
                          paste0("Problematic standardized attention defined as ", att_cutpoints[i], " and above (", 
                                 percentileF, percentile_suffix, " percentile)"),
                          paste0("Problematic raw attention defined as ", raw_attn_cutpoints[i], " and below (equivalent percentile)"),
                          "Models estimate the probability of classification into the problematic attention category as defined by the cutpoint."),
                  notes.align="l", align=F,
                  out=here(subdirectory, output_string,
                           paste0("results_", output_string, "_MI.html")))
        
      } # closes if title=T
    } # closes if missing=MI
    
    #######################
    #  descriptives       #
    #######################
    
    # for descriptives purposes, create dataframe "descr_data" which 
    #   either contains the dataframe or the first imputed dataset
    
    if (missing=="listwise") {
      descr_data <- df.expanded
    } else {
      descr_data <- complete(df.mi)
    } # close else missing=listwise
    
    descr_data <- mutate_(descr_data, 
                          att_sex_ss_cat = paste0("attention_cat_", 
                                                  att_cutpoints[i]))
    
    if (covariates=="Original") { 
      # make descriptives table for continuous variables by group 
      dtable <-   
        melt(setDT(
          dplyr::select(filter(descr_data, !is.na(att_sex_ss_cat)), 
                        "TV hours per day, age 1.5" = TV1,
                        "TV hours per day, age 3" = TV3,
                        "Attention (raw)" = attention,
                        "Attention within-sex SS" = att_sex_ss,
                        "Age (yrs) when attention was measured" = age,
                        "Cognitive stimulation of home age 1-3" = cogStim13,
                        "Emotional support of home age 1-3" = emoSupp13,
                        "Mother's years of schooling" = momEdu,
                        "Number of children in household" = kidsInHouse,
                        "Mother's age at birth" = momAge,
                        "Rosenberg self-esteem score (1987)" = Rosen87,
                        "CES-D Depression score (1992)" = CESD92,
                        "Gestational age (in weeks relative to term)" = gestationalAge,
                        "AttentionGroup" = att_sex_ss_cat)),
          id=c("AttentionGroup"))[, .(mean = Mean(value),
                                      sd = Sd(value),
                                      n = Validn(value),
                                      min = Min(value),
                                      max = Max(value)),
                                  .(AttentionGroup, variable)] %>%
        # reorder the variables
        dplyr::select(variable, AttentionGroup, n, mean, sd, min, max) 
      # label the levels of TVgroup
      dtable$AttentionGroup <- factor(dtable$AttentionGroup, labels=c("Normal", "Impaired"))
      # give names
      names(dtable) <- c("Variable", "Attention Group", "Valid n", "Mean", "Std Dev", "Min", "Max")
      # convert Variable to character (somehow it became a factor)
      dtable$Variable <- as.character(dtable$Variable)
     
      # replace the Variable field with blanks for every other row
      dtable$Variable[seq(2, nrow(dtable), by=2)] <- ""
      
      #   make descriptives table for categorical variables
      ctable <- 
        descr_data %>% dplyr::select(att_sex_ss_cat, cohort, race, female, fatherAbsent,
                                     alcohol, smoking, SMSA) %>%
        transmute_all(factor) %>% 
        gather(variable, value, cohort, race, female, fatherAbsent,
               alcohol, smoking, SMSA) %>% 
        group_by(att_sex_ss_cat, variable, value) %>%
        summarise (n = n()) %>%
        mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
      
      # label the levels of the att_sex_sscat variable
      ctable$att_sex_ss_cat <- factor(ctable$att_sex_ss_cat, labels=c("Normal", "Impaired"))
      
      # merge the low and high-TV descriptives horizontally
      ctable2 <- merge(
        filter(ctable, att_sex_ss_cat=="Normal"),
        filter(ctable, att_sex_ss_cat=="Impaired"),
        by=c("variable", "value"))
      
      # sort within groups so NA is always last
      ctable2 <- ctable2 %>% group_by(variable) %>% 
        dplyr::arrange(value, .by_group=T)
      
      # set variable names
      names(ctable2) <- c("Variable", "Value", "Normal attention",  "N", "Percent", "Impaired attention", "N", "Percent")
      
      # get rid of repeated names in the Variable field
      for (i in seq(nrow(ctable2), 2, by=-1)) {
        if (ctable2$Variable[i] == ctable2$Variable[i-1]) {ctable2$Variable[i] <- ""}
      }
      
      # convert factors in the Value variable to character and label
      #  1=Yes, 0=No
      ctable2$Value <- as.character(ctable2$Value)
      ctable2$Value <- ifelse(ctable2$Value=="1", "Impaired", 
                              ifelse(ctable2$Value=="0", "Healthy", ctable2$Value))
      
      # remove all the values in the Low Attention and High Attention columns
      #  (keep these columns in the table header
      ctable2[, c(3,6)] <- ""
      
      # change NAs (which render as blanks) to "(missing)" in the table
      ctable2$Value <- ifelse(is.na(ctable2$Value), "(missing)", 
                              ctable2$Value)
      
      ctable2$Variable <- 
        ifelse(ctable2$Variable=="alcohol", 
               "Maternal alcohol use during pregnancy", 
               ifelse(ctable2$Variable=="cohort",
                      "Cohort", 
                      ifelse(ctable2$Variable=="fatherAbsent", 
                             "Father is absent from household", 
                             ifelse(ctable2$Variable=="female",
                                    "Female", 
                                    ifelse(ctable2$Variable=="lowBirthWt",
                                           "Low Birth Weight", 
                                           ifelse(ctable2$Variable=="race",
                                                  "Race",
                                                  ifelse(ctable2$Variable=="smoking",
                                                         "Maternal smoking during pregnancy",
                                                         ifelse(ctable2$Variable=="SMSA",
                                                                "Standard metropolitan statistical area",
                                                                ctable2$Variable))))))))
      
      # make the table and write it to a file
      if (title==T) {
        stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                  notes=" ", 
                  out=here(subdirectory, output_string,
                           paste0("descriptives_categorical_", output_string, ".html")),
                  title=paste0("Descriptive statistics for categorical variables by attention group<br>",
                               title_string))
      } else {
        stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                  notes=" ", 
                  out=here(subdirectory, output_string,
                           paste0("descriptives_categorical_", output_string, ".html")))
        
      } # close else if title=T
    } # closes if covariates="Original"
    
    
    if (covariates=="Expanded") { 
      # make descriptives table for continuous variables by group 
      dtable <-   
        melt(setDT(
          dplyr::select(filter(descr_data, !is.na(att_sex_ss_cat)), 
                        "TV hours per day age 1.5" = TV1,
                        "TV hours per day age 3" = TV3,
                        "Attention (raw)" = attention,
                        "Attention within-sex SS" = att_sex_ss,
                        "Age (yrs) when attention was measured" = age,
                        "Temperament" = temperament,
                        "Cognitive stimulation of home age 1-3" = cogStim13,
                        "Emotional support of home age 1-3" = emoSupp13,
                        "Mother's years of schooling" = momEdu,
                        "Partner's years of schooling" = partnerEdu,
                        "Number of children in household" = kidsInHouse,
                        "Mother's age at birth" = momAge,
                        "Annual family income (thousands)" = income,
                        "Rosenberg self-esteem score (1987)" = Rosen87,
                        "CES-D Depression score (1992)" = CESD92,
                        "AttentionGroup" = att_sex_ss_cat)),
          id=c("AttentionGroup"))[, .(mean = Mean(value),
                                      sd = Sd(value),
                                      n = Validn(value),
                                      min = Min(value),
                                      max = Max(value)),
                                  .(AttentionGroup, variable)] %>%
        # reorder the variables
        dplyr::select(variable, AttentionGroup, n, mean, sd, min, max) 
      # label the levels of TVgroup
      dtable$AttentionGroup <- factor(dtable$AttentionGroup, labels=c("Normal", "Impaired"))
      # give names
      names(dtable) <- c("Variable", "Attention Group", "Valid n", "Mean", "Std Dev", "Min", "Max")
      # convert Variable to character (somehow it became a factor)
      dtable$Variable <- as.character(dtable$Variable)
      # replace the Variable field with blanks for every other row
      dtable$Variable[seq(2, nrow(dtable), by=2)] <- ""
      
      #   make descriptives table for categorical variables
      ctable <- 
        descr_data %>% dplyr::select(att_sex_ss_cat, cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
                                     alcohol, smoking, preterm, SMSA) %>%
        transmute_all(factor) %>% 
        gather(variable, value, cohort, race, female, poorHealth, lowBirthWt, fatherAbsent,
               alcohol, smoking, preterm, SMSA) %>% 
        group_by(att_sex_ss_cat, variable, value) %>%
        summarise (n = n()) %>%
        mutate(Percent = paste(formatC((n / sum(n))*100, digits=2, format="f"), "%", sep=""))
      
      # label the levels of the att_sex_sscat variable
      ctable$att_sex_ss_cat <- factor(ctable$att_sex_ss_cat, labels=c("Normal", "Impaired"))
      
      # merge the low and high-TV descriptives horizontally
      ctable2 <- merge(
        filter(ctable, att_sex_ss_cat=="Normal"),
        filter(ctable, att_sex_ss_cat=="Impaired"),
        by=c("variable", "value"))
      
      # sort within groups so NA is always last
      ctable2 <- ctable2 %>% group_by(variable) %>% 
        dplyr::arrange(value, .by_group=T)
      
      # set variable names
      names(ctable2) <- c("Variable", "Value", "Normal attention",  "N", "Percent", "Impaired attention", "N", "Percent")
      
      # get rid of repeated names in the Variable field
      for (i in seq(nrow(ctable2), 2, by=-1)) {
        if (ctable2$Variable[i] == ctable2$Variable[i-1]) {ctable2$Variable[i] <- ""}
      }
      
      # convert factors in the Value variable  to character and label
      #  1=Yes, 0=No
      ctable2$Value <- as.character(ctable2$Value)
      ctable2$Value <- ifelse(ctable2$Value=="1", "Impaired", 
                              ifelse(ctable2$Value=="0", "Healthy", ctable2$Value))
      
      # remove all the values in the Low Attention and High Attention columns
      #  (keep these columns in the table header
      ctable2[, c(3,6)] <- ""
      
      # change NAs (which render as blanks) to "(missing)" in the table
      ctable2$Value <- ifelse(is.na(ctable2$Value), "(missing)", 
                              ctable2$Value)
      
      ctable2$Variable <- 
        ifelse(ctable2$Variable=="alcohol", 
               "Maternal alcohol use during pregnancy", 
               ifelse(ctable2$Variable=="cohort",
                      "Cohort", 
                      ifelse(ctable2$Variable=="fatherAbsent", 
                             "Father is absent from household", 
                             ifelse(ctable2$Variable=="female",
                                    "Female", 
                                    ifelse(ctable2$Variable=="lowBirthWt",
                                           "Low Birth Weight", 
                                           ifelse(ctable2$Variable=="poorHealth",
                                                  "Poor health",
                                                  ifelse(ctable2$Variable=="preterm",
                                                         "Preterm birth",
                                                         ifelse(ctable2$Variable=="race",
                                                                "Race",
                                                                 ifelse(ctable2$Variable=="smoking",
                                                                        "Maternal smoking during pregnancy",
                                                                        ifelse(ctable2$Variable=="SMSA",
                                                                               "Standard metropolitan statistical area",
                                                                               ctable2$Variable))))))))))
      
    } # close if covariates=Expanded
    
    # make the table and write it to a file
    if (title==T) {
      stargazer(dtable, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string,
                         paste0("descriptives_continuous_", output_string, ".html")),
                title=paste0("Descriptive statistics for continuous variables by attention group<br>",
                             title_string))
      
      stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string,
                         paste0("descriptives_categorical_", output_string, ".html")),
                title=paste0("Descriptive statistics for categorical variables by attention group<br>",
                             title_string))
    } else {
      stargazer(ctable2, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string,
                         paste0("descriptives_categorical_", output_string, ".html")))
      
      stargazer(dtable, summary=F, rownames=F, header=F, type="text",
                notes=" ", 
                out=here(subdirectory, output_string,
                         paste0("descriptives_continuous_", output_string, ".html")))
      
    } # closes else if title==T
    
  } # closes loop over cutpoints
  
  return(do.call(rbind, lapply(results, as.data.frame)))
  options(warn = 0) 
  
} # closes function definition


# Test the logistic analysis function -------------------------------------

# test it

# logistic(data=analysis, subdirectory="Results", missing="listwise", covariates="Original",
#          att_cutpoints=c(115, 116), title=TRUE, m=2, maxit=3, seed=1)
# 
# logistic(data=analysis, subdirectory="Results", missing="listwise", covariates="Expanded",
#          att_cutpoints=c(115, 116), title=TRUE, m=2, maxit=3, seed=1)
# 
# logistic(data=analysis, subdirectory="Results", missing="MI", covariates="Original",
#          att_cutpoints=c(115), title=TRUE, m=2, maxit=3, seed=1)
# 
# logistic(data=analysis, subdirectory="Results", missing="MI", covariates="Expanded",
#          att_cutpoints=c(115, 116), title=TRUE, m=2, maxit=3, seed=1)


# ** Perform the multiverse analysis ** -------------------

###########################################################
#                                                         #
#   Call the functions over a grid of different options   #
#   ** Let's explore the multiverse! **                   #
#                                                         #
###########################################################


conditions_IPTW <- expand.grid(estimand=c("ATE", "ATT"), 
                               TVage=c("1", "3"),
                               covariates=c("Original", "Expanded"), 
                               TVpercentiles=list(c(.2, .8), c(.3, .7),
                                                  c(.4, .6), .5, .6, .7), 
                               stringsAsFactors=F)

conditions_strat <- expand.grid(estimand=c("ATE"), 
                                TVage=c("1", "3"),
                                covariates=c("Original", "Expanded"), 
                                TVpercentiles=list(c(.2, .8), c(.3, .7),
                                                   c(.4, .6), .5, .6, .7), 
                                strata=c(4,5,6,7,8),
                                stringsAsFactors=F)

conditions_reg <- expand.grid(covariates=c("Original", "Expanded"), 
                              missing=c("listwise", "MI"),
                              order=c(1, 2, 3),
                              stringsAsFactors=F)

conditions_logistic <- expand.grid(covariates=c("Original", "Expanded"), 
                              missing=c("MI", "listwise"),
                              stringsAsFactors=F)


result_IPTW <- list()
for (i in 1:nrow(conditions_IPTW)) {
  print(i)
  result_IPTW[[i]] <- psa(data=analysis, 
                          subdirectory="Results", 
                          iterations=4000, 
                          estimand=conditions_IPTW$estimand[i], 
                          TVage=conditions_IPTW$TVage[i], 
                          covariates=conditions_IPTW$covariates[i], 
                          method="IPTW", 
                          TVpercentiles=conditions_IPTW$TVpercentiles[[i]])
}

result_strat <- list()
for (i in 1:nrow(conditions_strat)) {
  print(i)
  result_strat[[i]] <- psa(data=analysis, 
                           subdirectory="Results", 
                           iterations=4000, 
                           estimand=conditions_strat$estimand[i], 
                           TVage=conditions_strat$TVage[i], 
                           covariates=conditions_strat$covariates[i], 
                           method="stratification", 
                           TVpercentiles=conditions_strat$TVpercentiles[[i]],
                           strata=conditions_strat$strata[[i]])
}

result_reg <- list()
for (i in 1:nrow(conditions_reg)) {
  print(i)
  result_reg[[i]] <- regression(data=analysis, 
                                subdirectory="Results", 
                                maxit=50,
                                m=10,
                                seed=1,
                                missing=conditions_reg$missing[i],
                                covariates=conditions_reg$covariates[i], 
                                order=conditions_reg$order[i])
}


result_logistic <- list()
for (i in 1:nrow(conditions_logistic)) {
  print(i)
  result_logistic[[i]] <- logistic(data=analysis, 
                                   subdirectory="Results",  
                                   maxit=50,
                                   m=10,
                                   seed=1,
                                   missing=conditions_logistic$missing[i],
                                   covariates=conditions_logistic$covariates[i], 
                                   att_cutpoints=seq(110, 130, 1))
}

result1 <- do.call(rbind, lapply(result_strat, as.data.frame, stringsAsFactors=F))
result2 <- do.call(rbind, lapply(result_IPTW, as.data.frame, stringsAsFactors=F))
result3 <- do.call(rbind, lapply(result_reg, as.data.frame, stringsAsFactors=F))
result4 <- do.call(rbind, lapply(result_logistic, as.data.frame.list, stringsAsFactors=F))

# results3 and results4 are data frame lists due to having unequal numbers
# of rows in each list. This needs to be corrected prior to writing the
# results to CSV
result3 <- as.data.frame(lapply(result3, unlist))
result4 <- as.data.frame(lapply(result4, unlist))

# Many of the logistic regression results are redundant because of sparsity
#  on the attention scores. Sometimes raising the classification cutoff does not 
#  result in any difference in the actual classifications. 
# The redundant results are dropped here. 
result4.nodupes <- result4[!duplicated(result4[,1:13]),]
result4.nodupes <- result4.nodupes[!duplicated(result4.nodupes[,14:16]),]

# bind all the results together
# first ensure all the names are the same. sometimes periods get inserted to replace 
#  the spaces (inconsistently it seems), which makes the rbind() fail

correct.names <- c("Analysis", "Method", "Effect", "Strata", "Cutpoint", "TV.age", 
                   "Outcome", "Doubly.robust", "Covariates", "Missing", "Order", 
                   "Sample.weights", "Attention.cutpoint", "Estimate", "StdErr", 
                   "p")

names(result1) <- correct.names
names(result2) <- correct.names
names(result3) <- correct.names
names(result4) <- correct.names

all.results <- data.frame(rbind(result1, result2, result3, result4.nodupes))
all.results$Attention.cutpoint <- as.numeric(as.character(all.results$Attention.cutpoint))

all.results$CI.lower <- all.results$Estimate - (all.results$StdErr * qnorm(.975))
all.results$CI.upper <- all.results$Estimate + (all.results$StdErr * qnorm(.975))


# Write results to raw CSV files ------------------------------------------

# write results to CSV files for re-importation (to avoid the hours of computation
#  needed to re-create them)
write.csv(result1, file=here("Results", "results_stratification.csv"), row.names=FALSE)
write.csv(result2, file=here("Results", "results_IPTW.csv"), row.names=FALSE)
write.csv(result3, file=here("Results", "results_regression.csv"), row.names=FALSE)
write.csv(result4.nodupes, file=here("Results", "results_logistic.csv"), row.names=FALSE)
write.csv(all.results, file=here("Results", "results_all.csv"), row.names=FALSE)

# import the results CSVs. Commented out
#  you can uncomment these to load the analysis results without recalculating
#  them all.
# result1 <- read.csv(file=here("Results", "results_stratification.csv"),
#                     stringsAsFactors=F, header=T)
# result2 <- read.csv(file=here("Results", "results_IPTW.csv"),
#                     stringsAsFactors=F, header=T)
# result3 <- read.csv(file=here("Results", "results_regression.csv"),
#                     stringsAsFactors=F, header=T)
# result4 <- read.csv(file=here("Results", "results_logistic.csv"),
#                     stringsAsFactors=F, header=T)
# all.results <- read.csv(file=here("Results", "results_all.csv"),
#                     stringsAsFactors=F, header=T)


# Define the summary plot function for estimates and CIs ------------------
# Figure: summarizing the results of all the models

plot_estCIs <- function(data, stddev, lower, upper,  ...) {
  
  selection <- enquos(...)
  
  data <- filter(data,  !!!selection) %>% group_by(TV.age) 
  
  data$TV.age <- factor(data$TV.age, labels=c("TV age ~1.5", "TV age ~3"))
  data$Estimate <- ifelse(data$Outcome=="Raw" & data$Analysis != "Logistic", 
                          -1*data$Estimate, data$Estimate)
  data$CI.lower <- ifelse(data$Outcome=="Raw" & data$Analysis != "Logistic", 
                          -1*data$CI.lower, data$CI.lower)
  data$CI.upper <- ifelse(data$Outcome=="Raw" & data$Analysis != "Logistic", 
                          -1*data$CI.upper, data$CI.upper)
  
  data <- mutate(data, rank = row_number((Estimate/StdErr)))
  
  p <- ggplot(data=data,
                aes(x=rank, y=Estimate / stddev))+
      geom_point(alpha=.6, shape=22, size=1.5, aes(fill=factor(ifelse(p>.05, 0, 1))))+
      geom_errorbar(aes(ymin=CI.lower/stddev,
                        ymax=CI.upper/stddev),
                    width=0,#nrow(data)/60,
                    alpha=.6)+
      geom_hline(yintercept=0, linetype="dotted", color="gray20")+
      theme_classic()+
      labs(x="", y="")+
      facet_wrap(~TV.age)+
      scale_fill_manual(values = c("white", "gray20"))+
      coord_cartesian(ylim=c(lower, upper))+
      theme(legend.position="none", 
            axis.text.x = element_blank(),
            axis.ticks.x = element_blank(),
            axis.title.x=element_blank(),
            plot.title= element_text(family="Times New Roman", size=11),
            axis.title.y = element_text(family = "Times New Roman", size=10),
            axis.text.y = element_text(family = "Times New Roman", size=10),
            legend.text = element_text(family = "Times New Roman", size=10),
            legend.title = element_text(family = "Times New Roman", size=10),
            strip.text.x = element_text(family = "Times New Roman", size=10),
            strip.background = element_rect(fill="gray90"))
  
  return(p)
}


plot_estCIs_logistic <- function(data, stddev, lower, upper,  ...) {
  
  selection <- enquos(...)
  
  data <- filter(data,  !!!selection) %>% group_by(TV.age) 
  
  data$TV.age <- factor(data$TV.age, labels=c("TV age ~1.5", "TV age ~3"))
  data$Estimate <- ifelse(data$Outcome=="Raw" & data$Analysis != "Logistic", 
                          -1*data$Estimate, data$Estimate)
  data$CI.lower <- ifelse(data$Outcome=="Raw" & data$Analysis != "Logistic", 
                          -1*data$CI.lower, data$CI.lower)
  data$CI.upper <- ifelse(data$Outcome=="Raw" & data$Analysis != "Logistic", 
                          -1*data$CI.upper, data$CI.upper)
  
  data <- mutate(data, rank = row_number((Estimate/StdErr)))
  
  p <- ggplot(data=data,
              aes(x=rank, y=exp(Estimate)))+
        geom_point(alpha=.6, shape=22, size=1.5, aes(fill=factor(ifelse(p<.05, 0, 1))))+
        geom_errorbar(aes(ymin=exp(CI.lower),
                          ymax=exp(CI.upper)),
                      width=0,
                      alpha=.6)+
        geom_hline(yintercept=1, linetype="dotted", color="gray20")+
        theme_classic()+
        labs(x="", y="")+
        facet_wrap(~TV.age)+
        scale_fill_manual(values = c("gray20", "white"))+
        coord_cartesian(ylim=c(lower, upper))+
        theme(legend.position="none", 
              axis.text.x = element_blank(),
              axis.ticks.x = element_blank(),
              axis.title.x=element_blank(),
              plot.title= element_text(family="Times New Roman", size=11),
              axis.title.y = element_text(family = "Times New Roman", size=10),
              axis.text.y = element_text(family = "Times New Roman", size=10),
              legend.text = element_text(family = "Times New Roman", size=10),
              legend.title = element_text(family = "Times New Roman", size=10),
              strip.text.x = element_text(family = "Times New Roman", size=10),
              strip.background = element_rect(fill="gray90"))  
  
  return(p)
}

# Define the function for plotting the summary of the p values ------------
plot_ps <- function(data, ...) {
  
  selection <- enquos(...)
  
  data <- filter(data,  !!!selection) %>% group_by(TV.age) %>%
    mutate(rank = row_number(desc(p)))

  data$TV.age <- factor(data$TV.age, labels=c("TV age ~1.5", "TV age ~3"))
  
  p <- ggplot(data=data,
              aes(x=rank, y=p))+
    geom_point(alpha=.6, shape=22, size=1.5, aes(fill=factor(ifelse(p<.05, 0, 1))))+
    geom_line(alpha=.2)+
    geom_hline(yintercept=.05, linetype="dotted", color="gray20")+
    theme_classic()+
    labs(x="", y="", fill="")+
    facet_wrap(~TV.age)+
    theme(legend.position="none", 
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank(),
          axis.title.x=element_blank(),
          plot.title= element_text(family="Times New Roman", size=11),
          axis.title.y = element_text(family = "Times New Roman", size=10),
          axis.text.y = element_text(family = "Times New Roman", size=10),
          legend.text = element_text(family = "Times New Roman", size=10),
          legend.title = element_text(family = "Times New Roman", size=10),
          strip.text.x = element_text(family = "Times New Roman", size=10),
          strip.background = element_rect(fill="gray90"))+
    coord_cartesian(ylim=c(0,1))+
    scale_fill_manual(values = c("gray20", "white"))
  return(p)
}

# calculate standard deviations for standardized effect sizes
sd.std <- sd(analysis$att_sex_ss, na.rm=T)
sd.raw <- sd(analysis$attention, na.rm=T)

# Make the regression results summary figure ------------------------------

# make regression results figure
est_std <- plot_estCIs(data=all.results, stddev=1, Analysis=="Regression", Outcome=="Within-sex SS",
                 lower=-.1*sd.std, upper=.1*sd.std)+ggtitle("Within-sex standardized attention: point estimate and 95% CI")+
                 labs(y="TV slope coefficient")

est_raw <- plot_estCIs(data=all.results, stddev=1, Analysis=="Regression", Outcome=="Raw", 
                 lower=-.1*sd.raw, upper=.1*sd.raw)+ggtitle("Raw attention: point estimate and 95% CI")+
                  labs(y="TV slope coefficient")

pvals <- plot_ps(data=all.results, Analysis=="Regression")+ggtitle("Hypothesis test for TV effect")+
  labs(y="p value")

upper_panel <- plot_grid(est_std, est_raw, nrow=2)

ggsave(filename=here("Manuscript", "Figures", "regression_results_summary.png"),
       plot=plot_grid(upper_panel, pvals, nrow=2), width=7, height=6, scale=1.2, dpi=200)


# Make the propensity score (IPTW) results summary figure -----------------

# make IPTW results figure
est_std <- plot_estCIs(data=all.results, stddev=sd.std, Method=="IPTW", Outcome=="Within-sex SS",
                 lower=-.5, upper=.5)+ggtitle("Within-sex standardized attention: point estimate and 95% CI")+
                 labs(y="Cohen's d")

est_raw <- plot_estCIs(data=all.results, stddev=sd.raw, Method=="IPTW", Outcome=="Raw",
                 lower=-.5, upper=.5)+ggtitle("Raw attention: point estimate and 95% CI")+
                  labs(y="Cohen's d")

pvals <- plot_ps(data=all.results, Method=="IPTW")+ggtitle("Hypothesis test for TV effect")+labs(y="p value")

upper_panel <- plot_grid(est_std, est_raw, nrow=2)

ggsave(filename=here("Manuscript", "Figures", "IPTW_results_summary.png"), 
       plot=plot_grid(upper_panel, pvals, nrow=2), width=11, height=5.5, scale=1.2, dpi=200)


# Make the propensity score (stratification) results summary figure -------

# make stratification results figure
est_std <- plot_estCIs(data=all.results, stddev=sd.std, Method=="stratification", Outcome=="Within-sex SS",
                 lower=-.5, upper=.5)+ggtitle("Within-sex standardized attention: point estimate and 95% CI")+
                  labs(y="Cohen's d")

est_raw <- plot_estCIs(data=all.results, stddev=sd.raw, Method=="stratification", Outcome=="Raw",
                 lower=-.5, upper=.5)+ggtitle("Raw attention: point estimate and 95% CI")+
                labs(y="Cohen's d")

pvals <- plot_ps(data=all.results, Method=="stratification")+ggtitle("Hypothesis test for TV effect")+
             labs(y="p value")

upper_panel <- plot_grid(est_std, est_raw, nrow=2)

ggsave(filename=here("Manuscript", "Figures", "stratification_results_summary.png"),
       plot=plot_grid(upper_panel, pvals, nrow=2), width=7, height=6, scale=1.2, dpi=200)


# Make the logistic regression results summary figure ---------------------

# logistic
est_std <- plot_estCIs_logistic(data=all.results, stddev=1, Analysis=="Logistic", Outcome=="Within-sex SS",
                 lower=.8, upper=1.5)+ggtitle("Within-sex standardized attention: point estimate and 95% CI")+
                labs(y="TV slope (OR)")

est_raw <- plot_estCIs_logistic(data=all.results, stddev=1, Analysis=="Logistic", Outcome=="Raw",
                       lower=.8, upper=1.5)+ggtitle("Raw attention: point estimate and 95% CI")+
                       labs(y="TV slope (OR)")

pvals <- plot_ps(data=all.results, Analysis=="Logistic")+ggtitle("Hypothesis test for TV effect")+
      labs(y="p value")

upper_panel <- plot_grid(est_std, est_raw, nrow=2)

ggsave(filename=here("Manuscript", "Figures", "logistic_results_summary.png"),
       plot=plot_grid(upper_panel, pvals, nrow=2), width=8, height=5.5, scale=1.2, dpi=200)

# Summarize and plot overall results --------------------------------------

# sort the results by p-value
all.results <- all.results[order(all.results$p),]
all.results$model <- 1:nrow(all.results)

# create the plot of p values for all models
p_value_summary <- ggplot(data=all.results,
                                      aes(x=as.numeric(model)/nrow(all.results), 
                                          y=p))+
  geom_point(shape=1, size=.1, alpha=.6)+
  scale_x_continuous(breaks=seq(0, 1, length.out=5))+
  scale_fill_grey(start=.2, end=1)+
  scale_color_grey(start=.1, end=.7)+
  geom_hline(yintercept=.05, col="red", linetype="dotted")+
  geom_abline(slope=1, intercept=0, alpha=.3, linetype="dashed")+
  theme_bw()+
  theme(legend.position="bottom", 
        axis.text.x = element_blank(),
        axis.title.x=element_text(family="Times New Roman", size=10),
        plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=10),
        axis.text = element_text(family = "Times New Roman", size=9),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10))+
  labs(y="p value", x="Model")+
  guides(color="none", fill="none")+
  theme(plot.margin = unit(c(1, 1, 0, 1), "cm"))+
  coord_cartesian(ylim=c(0,1))+
  scale_y_continuous(breaks=seq(0,1,.1))

ggsave(filename=here("Manuscript", "Figures", "p_value_summary.png"),
       plot=ggMarginal(p_value_summary, type="histogram", margins="y", alpha=.3, size=7, 
                                binwidth=.025, yparams=list(size=.5)),
         width=10, height=7, scale=1.0, dpi=200)

# Calculate sumary statistics for the models --------

# write the results to an html file
write.table(
  paste0("The total number of models was ",  nrow(all.results), ".<br>",
         "Of these, ", nrow(all.results[all.results$p < .05,]), " were statistically significant (",
         round(100*(nrow(all.results[all.results$p < .05,]) / nrow(all.results)),1), "%).<br><br>",
         "The 2.5th, 50th, and 97.5th percentile effect sizes for each model family are (higher = more impaired):<br><br>",
         
         "Propensity score IPTW: [", case_when(
           result2$Outcome == "Raw" ~ (-1*result2$Estimate / sd.raw),
           result2$Outcome == "Within-sex SS" ~ (result2$Estimate / sd.std)
         ) %>% quantile(probs=c(.025, .5, .975)) %>% round(3) %>% toString()
         , "] (Cohen's d metric).<br><br>",
         
         "Propensity score stratification: [", case_when(
           result1$Outcome == "Raw" ~ (-1*result1$Estimate / sd.raw),
           result1$Outcome == "Within-sex SS" ~ (result1$Estimate / sd.std)
         ) %>% quantile(probs=c(.025, .5, .975)) %>% round(3) %>% toString()
         , "] (Cohen's d metric).<br><br>",
         
         "Linear regression: [", case_when(
           result3$Outcome == "Raw" ~ (-1*result3$Estimate / sd.raw) * 
             mean(c(sd(analysis$TV1, na.rm=T), sd(analysis$TV3, na.rm=T))),
           result3$Outcome == "Within-sex SS" ~ (result3$Estimate / sd.std) *
             mean(c(sd(analysis$TV1, na.rm=T), sd(analysis$TV3, na.rm=T)))
         ) %>% quantile(probs=c(.025, .5, .975)) %>% round(3) %>% toString()
         , "] (beta coefficient metric).<br><br>",
         
         "Logistic regression: [", quantile(exp(result4$Estimate), 
                                            probs=c(.025, .5, .975)) %>% round(3) %>% 
           toString(),
         "] (odds ratio metric)."),
  file=here("Manuscript", "Tables", "model_results_summary.html"), row.names=F, col.names=F)


###############################################################
# investigate linear regression results                       #
###############################################################

# Make tables of significance by missing data mechanism for linear regression  --------

regression_table <- with(filter(result3, TV.age=="~3"), 
                       table(as.character(Missing) , p<.05)) %>% data.frame()
names(regression_table) <- c("Missing", "Sig", "Freq")
regression_table$Sig <- as.numeric(regression_table$Sig) - 1
regression_table <- pivot_wider(data=regression_table, names_from=Sig, 
                              values_from=Freq, names_prefix="Sig=")
regression_table$Proportion <- format(round(regression_table$"Sig=1" / 
                                            (regression_table$"Sig=0" + regression_table$"Sig=1"),3), nsmall=3)

regression_table$Missing <- as.character(regression_table$Missing)

names(regression_table) <- c("Missing data", "Non-sig", "Sig", "Proportion sig")

stargazer(regression_table, summary=F, type="text", rownames=F,
          title="Linear regression models: significance by missing data mechanism",
          notes=c("Table includes only models measuring TV use at age ~3."),
          out=here("Manuscript", "Tables", "linear_regression_results_by_missing.html"))

# understanding logistic regression results -------------------------------

###############################################################
# investigate logistic regression results                     #
###############################################################

# Make tables of significance by attention cutpoint for logistic  --------

logistic_table <- with(dplyr::filter(result4, Outcome=="Within-sex SS"),
     table(as.character(Missing), as.character(Attention.cutpoint), p<.05)) %>% data.frame()
names(logistic_table) <- c("Missing", "Cutpoint", "Sig", "Freq")
logistic_table$Sig <- as.numeric(logistic_table$Sig) - 1
logistic_table <- pivot_wider(data=logistic_table, names_from=Sig, 
                          values_from=Freq, names_prefix="Sig=")
logistic_table$Proportion <- format(round(logistic_table$"Sig=1" / 
                                            (logistic_table$"Sig=0" + logistic_table$"Sig=1"),3), nsmall=3)
logistic_table$Cutpoint <- as.character(logistic_table$Cutpoint)

# make a wide table by merging the listwise and MI results side by side
logistic_table2 <- merge(
  filter(logistic_table, Missing=="listwise"),
  filter(logistic_table, Missing=="multiple imputation"),
by="Cutpoint")

# remove the repeated names in the missing data type columns
#  (those will go in the variable names for these blank columns
logistic_table2[, c(2, 6)] <- ""

# coerce to data frame from tibble to allow repeated column names
logistic_table2 <- data.frame(logistic_table2)

# assign column names
names(logistic_table2) <- c("Attention cutpoint", "Listwise", "Non-sig", "Sig", "Proportion sig",
                            "Multiple imputation", "Non-sig", "Sig", "Proportion sig")
                            
stargazer(logistic_table2, summary=F, type="text", rownames=F, header=F,
          title="Logistic models: significance by attention cutoff and missing data mechanism.",
          notes=c("Table includes only models using the standardized attention outcome."),
          out=here("Manuscript", "Tables", "logistic_results_by_att_cutpoint.html"))


###### Logistic post-mortem plot #1  ###########

# The objective is to make a plot of TV binned into categories vs 
#   dichotomized attention for different cutpoints. This allows the probability
#   of attention=problem (e.g, the high category) to be plotted across levels
#   of binned TV.
# We will fit an analogue of a linear probability model to each dataset, 
#   weighting by the number of cases in each TV bin, and see how the 
#   fitted line (and the p-value of its slope) changes across cutpoints.
# It was possible to control for the covariates in these plots.

# define the function for returning the dataset with both TV and 
#  attention categorized. It also fits a weighted linear regression 
#  to the summary values and returns the p-value for the slope.

TV_att_categorize <- function(cutpoint, xvar, breaks) {
  # dichotomize att_sex_ss at the given cutpoint
  y <- as.numeric(cut(analysis$att_sex_ss, breaks=c(-Inf, cutpoint, Inf)))-1
  # categorize TV into categories defined by the argument "breaks"
  x <- cut(x=dplyr::select(analysis, xvar)[,1], breaks)
  # calculate the number of cases in each TV category
  n <- as.numeric(table(x))
  # calculate the proportion of cases in each TV category with
  #  attention = "problematic"
  p <- as.numeric(table(y, x)[2,] / n)
  # get the p-value for the slope from a weighted regression
  pval <- summary(lm(p~I(1:length(levels(x))), weight=n))$coeff[2,4]
  # bind everything into a dataframe 
  df <- data.frame(cutpoint=cutpoint, TVcat=levels(x), n=n, p=p, pval=pval)
  # label the TV categories
  df$TVcat <- factor(df$TVcat, levels = df$TVcat[1:length(breaks)])
  return(df)
}

# define the cutoffs
cutoffs <- seq(110, 132, 2)
# apply the TV_att_categorize funtion to the cutoffs. The resulting object
#   is a list.
logistic_postmortem_1_list <- lapply(cutoffs, 
                                     TV_att_categorize, 
                                     xvar="TV3", breaks=seq(0, 16, 2))

# unlist these dataframes into one big dataframe by rbind()ing the elements
logistic_postmortem_1 <- do.call(rbind, 
                                 lapply(logistic_postmortem_1_list, 
                                        as.data.frame))

# convert the cutpoint into a factor and provide labels
#  these will form the title of each facet in the plot
logistic_postmortem_1$cutpoint <- factor(logistic_postmortem_1$cutpoint, 
                                         labels=paste("Cutpoint =", 
                                                      seq(110, 132, 2)))

# define a function for printing formatted p-values
formatp <- function(p) {
  ifelse(p < .0001, "<.0001",  
         paste0("=", format(round(p,4), nsmall=4)))
}

# create a dataset of p-value, one per cutpoint. format them.
logistic_postmortem_1_pvals <- logistic_postmortem_1 %>% 
  group_by(cutpoint) %>% 
  summarise(pval=mean(pval))

logistic_postmortem_1_pvals$pval <- apply(logistic_postmortem_1_pvals[,2],
                                          1, formatp)

# make the plot
logistic_postmortem_categorized <- ggplot(data=logistic_postmortem_1, 
                                          aes(x=TVcat, y=p, size=n))+
  geom_point(alpha=.7, shape=22, fill="red")+
  geom_line(aes(x=as.numeric(logistic_postmortem_1$TVcat, y=p)), 
            size=.3, alpha=.6, linetype="dashed")+
  geom_smooth(aes(x=as.numeric(logistic_postmortem_1$TVcat),
                  y=p, weight=n), method="lm")+
  theme_bw()+facet_wrap(~cutpoint)+
  geom_text(data=logistic_postmortem_1_pvals, x=3, y=.45,
            label=paste0("p", logistic_postmortem_1_pvals$pval), 
            family="Times New Roman", size=4, alpha=.85)+
  theme(legend.position="bottom", 
        axis.text.x = element_text(angle = 90, hjust=1),
        plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=10),
        axis.text = element_text(family = "Times New Roman", size=10),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10),
        strip.text = element_text(family = "Times New Roman", size = 11))+
  labs(color="Density by attention category", 
       x="TV consumption at age ~3 category (hours per day)", 
       y="Probability of \"problematic\" attention")+
  scale_size_continuous(guide = FALSE)+
  coord_cartesian(ylim=c(0, .5))

ggsave(filename=here("Manuscript", "Figures", "logistic_postmortem_categorized.png"),
       plot=logistic_postmortem_categorized, width=8, height=6, scale=1.0, dpi=200)


###### Logistic post-mortem plot #2  ###########
# The objective is to make a plot of TV (age 3) vs dichotomized attention at 
#   age 7, after controlling for covariates, for different cutpoints. 
#   We will fit a linear probability model to each dataset and see how the 
#   fitted line (and the p-value of its slope) changes across cutpoints.

# remove any cases with missing values. this is needed because lm() doesn't 
#  produce NA as the residual for a missing case. With missing data, the residual
#  would not properly match up with the TV3 vector as they would have different
#  length

data.complete <- dplyr::select(analysis, att_sex_ss, factor(cohort), age, cogStim13, emoSupp13, 
                        momEdu, kidsInHouse ,momAge, income, Rosen87, CESD92, alcohol, 
                        fatherAbsent, female, gestationalAge, race, smoking, rural, TV3)

data.complete <- data.complete[complete.cases(data.complete),]

# fit the regression model and save the residuals. append them to the
#  data.complete data frame

reg <- lm(att_sex_ss~factor(cohort)+age+cogStim13+emoSupp13+
            momEdu+kidsInHouse+momAge+income+Rosen87+CESD92+alcohol+fatherAbsent+female+gestationalAge+
            race+smoking+rural, data=data.complete)
data.complete$resid <- reg$residuals

# function that, for a given cutpoint, does two things
#  (1) returns the p-value of the slope coefficient for a linear 
#    probability model where x=TV3 and y = dichotomoized within-sex 
#    standardized attention residual for that cutpoint, and
#  (2) returns a data frame with TV3, the dichotomized attention residual,
#    the p-value described above.

resid.dichotomoize <- function(cutpoint) {
   TV3 <- data.complete$TV3
   # cut the residualized attention variable at the specified cutpoint
   #  convert to numeric and subtract one (making it a 0/1 variable)
   residAttCut <- as.numeric(cut(data.complete$resid, c(-Inf, cutpoint, Inf)))-1
   resid <- data.complete$resid
   # extract the p value of the slope from the linear probability model
   p <- summary(lm(residAttCut~TV3, data=data.complete))$coeff[2,4]
   # bind into dataframe to return
   df <- data.frame(cutpoint=cutpoint, TV3=TV3, 
                    residAttCut=residAttCut, resid=resid, p=p)
   return(df)
}
  
# the logistic regression used cutpoints 110, 112, 114, ..., 130
#  we want to use equivalent cutpoints for cutting these residuals to define
#  "normal" and "problematic" attention groups after conditioning on the 
#  covariates
# the scale of the residuals differs in two ways: the mean residual is 0 
#  instead of 100, and the variance of the residuals is smaller.

# to create equivalent cutpoints, subtract the mean of att_sex_ss (100) and 
#  rescale the cutpoints by the ratio of the residual variance to the 
#  total variance

var.ratio <- var(data.complete$resid) / var(data.complete$att_sex_ss)
# make the vector of cutoffs
cutoffs <- seq(10*var.ratio, 32*var.ratio, length.out=12)

# now apply the resid.dichotmize function to all of the cutoffs
#  the resulting object is a list, where each list element is a dataframe
#  from one cutoff
logistic_postmortem_2_list <- lapply(cutoffs, resid.dichotomoize)

# unlist these dataframes into one big dataframe by rbind()ing the elements
logistic_postmortem_2 <- do.call(rbind, 
                                 lapply(logistic_postmortem_2_list, 
                                        as.data.frame))

# jitter the points in a specific way to meet two requirements
#  (1) that the jittered points maintain a constant position across facets
#   in the upcoming ggplot. this way points can be consistently identified
#  (2) that, within groupings, the vertical offset of the point is proportional
#    to its actual value of the residualized att_sex_ss

logistic_postmortem_2$residAttCut_jitter <- logistic_postmortem_2$residAttCut + 
  .005*logistic_postmortem_2$resid

# convert the cutpoint into a factor and provide labels
#  these will form the title of each facet in the plot
logistic_postmortem_2$cutpoint <- factor(logistic_postmortem_2$cutpoint, 
                      labels=paste("Adjusted cutpoint =",  seq(110, 132, 2)))

# create a dataset of p-value, one per cutpoint. format them.
logistic_postmortem_2_pvals <- logistic_postmortem_2 %>% 
  group_by(cutpoint) %>% summarise(p=mean(p))

logistic_postmortem_2_pvals$p <- apply(logistic_postmortem_2_pvals[,2], 
                                       1, formatp)

# make the plot

logistic_postmortem_residualized <- 
  ggplot(data=logistic_postmortem_2)+
  geom_point(aes(x=TV3, y=residAttCut_jitter), alpha=.15, size=.8)+
  geom_smooth(method="lm", aes(x=TV3, y=residAttCut))+
  facet_wrap(~cutpoint)+
  geom_line(stat="density", 
            aes(x=TV3, y=2*..density.., col=factor(residAttCut)), 
               position=position_nudge(y=.4))+
  scale_color_brewer(palette="Set1")+
  geom_text(data=logistic_postmortem_2_pvals, x=12.5, y=.7, 
            label=paste0("p", logistic_postmortem_2_pvals$p), 
            family="Times New Roman", size=4, alpha=.85)+
  theme_bw()+
  theme(plot.title= element_text(family="Times New Roman", size=11),
        axis.title = element_text(family = "Times New Roman", size=9),
        axis.text = element_text(family = "Times New Roman", size=9),
        legend.text = element_text(family = "Times New Roman", size=9),
        legend.title = element_text(family = "Times New Roman", size=10),
        strip.text = element_text(family = "Times New Roman", size = 11),
        legend.position="bottom")+
  scale_y_continuous(breaks=c(0,1))+
  labs(color="Density by attention category", 
       x="TV consumption at age ~3 (hours per day)", 
       y="Attention category (0 = \"normal\", 1=\"problematic\")")

ggsave(filename=here("Manuscript", "Figures", "logistic_postmortem_residualized.png"),
       plot=logistic_postmortem_residualized, width=8, height=6, scale=1.0, dpi=200)


###############################################################
# investigate IPTW propensity score model results             #
###############################################################
# Make tables of significance by TV cutpoints for IPTW  --------

IPTW_table <- with(filter(result2, TV.age=="~3", Outcome=="Within-sex SS"), 
                   table(Cutpoint, p<.05)) %>% data.frame()
names(IPTW_table) <- c("Cutpoint", "Sig", "Freq")
IPTW_table$Sig <- as.numeric(IPTW_table$Sig) - 1

IPTW_table <- pivot_wider(data=IPTW_table, names_from=Sig, 
                          values_from=Freq, names_prefix="Sig=")
IPTW_table$Proportion <- format(round(IPTW_table$"Sig=1" /
                                        (IPTW_table$"Sig=0" + IPTW_table$"Sig=1"),3), nsmall=3)
IPTW_table$Cutpoint <- as.character(IPTW_table$Cutpoint)

names(IPTW_table) <- c("TV cutpoint percentiles", "Non-sig", "Sig", "Proportion sig")

stargazer(IPTW_table, summary=F, type="text", rownames=F,
          title="IPTW propensity score models: significance by TV category cutoffs",
          notes=c("Table includes only models measuring TV use at age ~3", 
          "and using the standardized attention outcome."),
          out=here("Manuscript", "Tables", "IPTW_results_by_TVcutpoint.html"))


# Make IPTW postmortem figure  --------
IPTW_postmortem <- function(data, outcome, TVpercentiles, ...) {
  
  # find the values of TV3 corresponding with the requested percentiles
  TVquantiles <- quantile(data$TV3, TVpercentiles, na.rm=T)
  if (length(TVquantiles) == 1) {TVquantiles <- rep(TVquantiles, 2)}
  
  # categorize TV. Category 2 is 'missing' and will be dropped 
  #  set to 2 instead of NA because of R's weirdness around matching NAs
  data$TVcat <- ifelse(data$TV3<=TVquantiles[1], 0, 
                       ifelse(data$TV3>=TVquantiles[2], 1, 2))
  
  # calculate the means, SDs, and n by TV category
  resid.means <- data %>% group_by(TVcat) %>% filter(TVcat != 2) %>%
         summarise(mean = mean(.data[[outcome]], na.rm=TRUE) ,
                   sd = sd(.data[[outcome]], na.rm=TRUE),
                   n = length(.data[[outcome]]))
  
  # create a dataset to plot defining the horizontal lines in each level
  #  of TVcat; these are the means of the attention residuals within each
  #  category
  
  # define the x values. it takes 2 points to define a line.
  x <- c(0, TVquantiles[1], TVquantiles[2], max(analysis$TV3, na.rm=T))
  
  # the y values are the means, they are repeated twice.
  y <- unlist(c(rep(resid.means[1,2], 2), rep(resid.means[2,2], 2)))
  
  # calculate the 95% CI boundaries around the means using the normal appoximation
  lower <- rep((resid.means$mean - (resid.means$sd/sqrt(resid.means$n))*qnorm(.975)), each=2)
  upper <- rep((resid.means$mean + (resid.means$sd/sqrt(resid.means$n))*qnorm(.975)), each=2)
  
  # bind those together into the generically-named dataframe for plotting the means
  df <- data.frame(x, y, lower, upper)
  df$group <- c(0,0,1,1)
  
  # make the plot
  p <-  ggplot()+
    # vertical reference line(s) for cutpoints
    geom_vline(xintercept=TVquantiles, cex=.8, alpha=.8)+
    # add points
    geom_point(data=filter(data, TVcat != 2), 
                aes_string(x="TV3", y=outcome), shape=21, cex=.5, alpha=.35, 
                fill="gray80", color="gray20")+
    # plot the means in each level of TVcat as horizontal lines
    #  and their CIs
    geom_line(data=df, aes(x=x, y=y, group=group), 
              col="red", cex=1.2, alpha=.8)+
    geom_ribbon(data=df, aes(x=x, ymin=lower, ymax=upper, group=group),
                alpha=.25, fill="red") +
    # add the loess smoothed fit and its CI
    geom_line(data=data, 
              aes_string(x="TV3", y=outcome), stat="smooth", method="loess", 
              color="blue") +
    geom_ribbon(data=data, 
                aes_string(x="TV3", y=outcome),stat = "smooth", method="loess", 
                alpha=.1, se=T, level=.95, fill="gray20")+
    # zoom in the plot
    coord_cartesian(ylim=c(-5, 5))+
    labs(...)+
    theme_classic()+
    theme(axis.title = element_text(family = "Times New Roman", size=9),
          axis.text = element_text(family = "Times New Roman", size=9))

    return(p)
}

# could lapply() here, but I need to be able to alter the axis text per panel
p20_80 <- IPTW_postmortem(data=analysis.imputed, outcome="resid.ss", TVpercentiles=c(.2, .8),
                          x="", y="Covariate-adjusted Attention at Age 7", text_x=T)

p30_70 <- IPTW_postmortem(data=analysis.imputed, outcome="resid.ss", TVpercentiles=c(.3, .7),
                          x="", y="")

p40_60 <- IPTW_postmortem(data=analysis.imputed, outcome="resid.ss", TVpercentiles=c(.4, .6),
                         x="", y="")

p50 <- IPTW_postmortem(data=analysis.imputed, outcome="resid.ss", TVpercentiles=.5,
                       x="TV consumption at Age ~3 (hours per day)", 
                       y="Covariate-adjusted Attention at Age 7")

p60 <- IPTW_postmortem(data=analysis.imputed, outcome="resid.ss", TVpercentiles=.6,
                       x="TV consumption at Age ~3 (hours per day)", y="")

p70 <- IPTW_postmortem(data=analysis.imputed, outcome="resid.ss", TVpercentiles=.7,
                       x="TV consumption at Age ~3 (hours per day)", y="")

IPTW_plots <- plot_grid(p20_80, p30_70, p40_60, p50, p60, p70, nrow=2, 
          labels=c("A: 20/80", "B: 30/70", "C: 40/60", "D: 50", "E: 60", "F: 70"),
          label_x=c(.48, .48, .48, .63, .63, .63), label_y=.97)

ggsave(filename=here("Manuscript", "Figures", "IPTW_postmortem.png"), 
       plot=IPTW_plots, width=7, height=4, scale=1.2, dpi=200)

  