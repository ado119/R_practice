# install.packages("rJava")
# install.packages("memoise")
# install.packages("KoNLP")
# install.packages("dplyr")
# install.packages("stringr")
# install.packages("reshape")
# install.packages("wordcloud")

library(RColorBrewer)
library(wordcloud)
library(reshape)
library(stringr)
library(KoNLP)
library(dplyr)

getwd()
txt_f <-readLines("test_f.txt", encoding="utf-8")
txt_f

str(txt_f)

useNIADic()

nouns <- extractNoun(txt_f)

str(nouns)

wordcount <- table(unlist(nouns))
str(wordcount)
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word
df_word <- rename(df_word, word = Var1, freq = Frea)


head(df_word)

df_word <- filter(df_word, nchar(Var1) >= 2)
top_word <- df_word %>% arrange(desc(Freq)) %>% head(20)
top_word

pal <- brewer.pal(8, "Dark2")

wordcloud(words = df_word$Var1, freq=df_word$Freq,
          min.freq = 5, max.words = 200, random.order = F,
          rot.per = .1, scale = c(4, 0.3), colors=pal)