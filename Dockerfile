FROM inwt/r-shiny:4.2.3

ADD . .

RUN installPackage

CMD ["Rscript", "-e", "library(deBInferS);startApplication(3838)"]
