FROM inwt/r-shiny:4.4.1

ADD . .

RUN installPackage

CMD ["Rscript", "-e", "library(deBInferS);startApplication(3838)"]
