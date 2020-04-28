FROM rocker/rstudio:3.6.3
MAINTAINER Matt McBee (mmcbee@gmail.com)

# grant read/write permissions for the project directories
ADD --chown=rstudio /Code/analysis.r /home/rstudio/Code/analysis.r
ADD  --chown=rstudio /Code/NLSY_CYA_rawdata_import.r /home/rstudio/Code/NLSY_CYA_rawdata_import.r
ADD  --chown=rstudio /Code/NLSY_rawdata_import.r /home/rstudio/Code/NLSY_rawdata_import.r

ADD  --chown=rstudio /Data/NLSY_CYA_raw.dat /home/rstudio/Data/NLSY_CYA_raw.dat
ADD  --chown=rstudio /Data/NLSY_raw.dat /home/rstudio/Data/NLSY_raw.dat

# install build dependencies for data.table
RUN apt-get update && apt-get install zlib1g-dev

# install build dependency for twang
RUN apt-get -y install libjpeg-dev
RUN apt-get -y install libpng-dev

# move readme files to these directories. This is a workaround to give rstudio write permission
#  to these locations. dir.create followed by Sys.chmod did not accomplish this
ADD --chown=rstudio /Manuscript/Figures/readme.txt  /home/rstudio/Manuscript/Figures/readme.txt
ADD --chown=rstudio /Manuscript/Tables/readme.txt  /home/rstudio/Manuscript/Tables/readme.txt
ADD --chown=rstudio /Results/readme.txt  /home/rstudio/Results/readme.txt

# install the necessary packages
RUN R -e "install.packages('broom', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('dplyr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('mice', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('twang', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('PSAgraphics', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('here', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('tidyr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('survey', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('stargazer', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('reshape2', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('data.table', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('stringr', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('cowplot', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('psych', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('multcomp', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('tibble', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('extrafont', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('ggExtra', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('gridGraphics', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('GPArotation', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('gridExtra', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('mitml', repos = 'http://cran.us.r-project.org')"