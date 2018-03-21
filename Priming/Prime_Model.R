# Priming model voor Experimentele methode en statistiek
# Door: Nikki Evers, Daniël Bezema, Floris van Voorst tot Voorst, Bram Kreuger
# Universiteit Utrecht 2018

# Loading in data
setwd("D:/nikki/Documents/Experimentele Methoden & Statistiek/Eigen Onderzoek - Priming")
load("allData2018.Rdata")
woordenboek1 <- read.csv(file = "D:/nikki/Documents/Experimentele Methoden & Statistiek/Eigen Onderzoek - Priming/easy1.csv")
woordenboek2 <- read.csv(file = "D:/nikki/Documents/Experimentele Methoden & Statistiek/Eigen Onderzoek - Priming/easy2.csv")
woordenboek3 <- read.csv(file = "D:/nikki/Documents/Experimentele Methoden & Statistiek/Eigen Onderzoek - Priming/hard1.csv")
woordenboek4 <- read.csv(file = "D:/nikki/Documents/Experimentele Methoden & Statistiek/Eigen Onderzoek - Priming/hard2.csv")

# Cleaning up data
allDataCleaned <- allData[allData$LocalTime < 150 & allData$LocalTime > 0, ]


# Hier pakken we alle data uit de dualTask waar een correct nieuw woord word gemaakt

AllWordsData <-  allDataCleaned[allDataCleaned$partOfExperiment == "dualTask" &
                                 allDataCleaned$Eventmessage2 == "correctNewWord", ]

# Data Ophakken: Elk aaneengesloten stuk scrabble krijgt zijn eigen nummer.
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


##
## ONS EIGEN MODEL
##(In woorden wat er volgensmij (nikki) ongeveer moet gebeuren)
##
## Voor elk scrabbleStukje:
## Voor elk woord:
## input_string = woord
## calculate min_edit_dist (top 5)
## choose word based upon strategy (bijv. kies altijd nummer 1, of kies altijd random)
## check whether it's the same as human chose
## give score based upon previous
##
## Things to think about:
## We kunnen ook al die woorden in tabbelen gaan bewaren met scores, maar we hebben 121 scrabbleStukjes, wat betekend dat we 121 tabbelen krijgen
## Wat hebben we daar daadwerkelijk aan? Is het niet makkelijker om gewoon een score bij te houden en dan als output die score te krijgen?
## Het is handig om onze modellen zo te maken dat we priming gebaseerd op inputstring (die random letters) mee en niet mee kunnen laten tellen
## Omdat het mogelijk is dat de gekozen strategie daar de rest van de resultaten (de scores dus) te veel verandert




deletion <- function(input_str)
{
  i <- 0
  
  for(i in 0:nchar(input_str))
  {
    nieuw_woord <- gsub(paste("^(.{", i, "}).", sep=""), "\\1", input_str)
    
    print(nieuw_woord)
    
    ## ipv print moet zoiets komen:
    ## if(nieuw_woord niet gelijk is aan input_string & niet in nieuwe data.frame (generated_words) voorkomt & wel in woordenboek 1, 2, 3 of 4)
    ## {sla woord op in data.frame generated_words in de kolom die hoort bij distance}
    
    i <- i + 1
  }
}

insertion <- function()
{
  
}

substitution <- function()
{
  
}

generate_distance_words <- function()
{
  ## Pas één voor één deletion, insertion en substitution toe op input woord. Dus hier creeren we alleen woorden met distance 1
  ## Als we nu nog niet genoeg worden hebben gegenereerd, gaan we op alle in deze ronde opgeslagen woorden weer één voor één deletion, insertion en substitution toepassen
  ## Op dezelfde manier.
  ## Hierdoor onstaan woorden met distance 2. (die komen dus ook in een nieuwe kolom, de kolom voor distance 2)
  ## blijf dit herhalen tot we genoeg woorden hebben.
  
  
}