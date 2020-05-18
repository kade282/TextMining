#³adowanie bibliotek
library(tm)
#library(hunspell)
#library(stringr)


#zmiana katalogu roboczego
workDir <- "C:\\Users\\kdylewska\\studia\\TextMining12S"
setwd(workDir)

#definicja katalogów projektu
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptsDir <- ".\\scripts"
workspaceDir <- ".\\workspaces"

#dir.create(outputDir, showWarnings = FALSE)

#utworzenie katalogu wyjœciowego
dir.create(outputDir, showWarnings = FALSE)
dir.create(workspaceDir, showWarnings = FALSE)

#utworzenie korpusu dokumentów
corpusDir <- paste(
  inputDir,
  "\\",
  "Literatura - streszczenia - orygina³",
  sep = ""
)
corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern = "*.txt",
    encoding = "UTF-8"
  ),
  readerControl = list(
    language = "pl_PL"
  )
)