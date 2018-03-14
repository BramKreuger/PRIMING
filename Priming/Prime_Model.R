# Priming model voor Experimentele methode en statistiek
# Door: Nikki Evers, Daniël Bezema, Floris van Voorst tot Voorst, Bram Kreuger
# Universiteit Utrecht 2018

# Loading in data
setwd("D:/nikki/Documents/Experimentele Methoden & Statistiek/Eigen Onderzoek - Priming")
load("allData2018.Rdata")


# Cleaning up data
allDataCleaned <- allData[allData$LocalTime < 150 & allData$LocalTime > 0, ]


# Hier pakken we alle data waar een correct nieuw woord word gemaakt
# Let op dat we én data van practiceScrabble en data van dualTask scrabble pakken omdat we anders
# Te weinig data hebben.

AllWordsData <-  allDataCleaned[allDataCleaned$partOfExperiment == "dualTask" &
                                 allDataCleaned$Eventmessage2 == "correctNewWord", ]

# Wat we nu willen doen is de data ophakken, door elk aaneengesloten stuk scrabble een getal te geven.
# Voor Dual Task: Vanaf een wissel (of het begin), tot een wissel (of het einde v/d tijd).
# We vermoeden dat het wisselen binnen een dual task het primen opheft (dus wissen naar letterTypingTask). We zien het wisselen tussen 
# Taken dus als een nieuw begin.

AllWordsData$scrabbleStukje <- NA

i <- 1
stukje <- 1
x <- AllWordsData[i, "letterWindowVisitCounter"]
while (i <= nrow(AllWordsData))
  {
  if(x != AllWordsData[i, "letterWindowVisitCounter"])
  {
    x <- AllWordsData[i, "letterWindowVisitCounter"]
    stukje <- stukje + 1
  }
  
  AllWordsData[i, "scrabbleStukje"] <- stukje
  i <- i + 1
}

AllWordsData[,c("currentScrabbleLettersTyped", "scrabbleStukje")]



