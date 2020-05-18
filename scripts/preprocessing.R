#³adowanie bibliotek
library(tm)
library(hunspell)
library(stringr)


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
#dir.create(outputDir, showWarnings = FALSE)
#dir.create(workspaceDir, showWarnings = FALSE)

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

#usuniêcie z tekstów podzia³u na akapity
pasteParagraphs <- content_transformer(function(text, char) paste(text, collapse = char))
corpus <- tm_map(corpus, " ")

#wstêpne przetwarzanie
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower)) #tylko zawartoœæ dokumentów tekstowych

stoplistFile <- paste(
  inputDir,
  "\\",
  "stopwords_pl.txt",
  sep = ""
)
stoplist <- readLines(
  stoplistFile,
  encoding = "UTF-8"
)
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)

removeChar <- content_transformer(
  function(x, pattern, replacement) 
    gsub(pattern, replacement, x)
)

#writeLines(as.character(corpus[[1]]))


#usuniêcie "em dash" i 3/4 z tekstów
corpus <- tm_map(corpus, removeChar, intToUtf8(8722), "")
corpus <- tm_map(corpus, removeChar, intToUtf8(190), "")


#usuniêcie rozszerzeñ z nazw dokumentów
cutExtensions <- function(document) {
  meta(document, "id") <- gsub(pattern = "\\.txt$", "", meta(document, "id"))
  return(document)
}

corpus <- tm_map(corpus, cutExtensions)

#corpus[["Harry Potter i Czara Ognia"]][["content"]]

