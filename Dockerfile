FROM inwt/r-shiny:4.2.3

ADD . .

RUN installPackage

CMD ["Rscript", "-e", "library(AppAroundPackage);startApplication(3838)"]
