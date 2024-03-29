### Today we are going to practice working with words ####
### Created by: Avetis Mishegyan #############
### Created on: 2023-04-18 ####################


#### Load Libraries ######
library(here)
library(tidyverse)
library(tidytext) # text mining and making text tidy
library(wordcloud2) # for making word clouds
library(janeaustenr) # data for Jane Austen's books


### Load Data ######
# None


### Data Analysis ######
# Intro to {stringr} - pg 5
words <- "This is a string"
words

words_vector <- c("Apples", "Bananas","Oranges") # several strings in a vector
words_vector

# Manipulation - pg 7
paste("High temp", "Low pH") # paste words together
paste("High temp", "Low pH", sep = "-") # adds a dash in between the words
paste0("High temp", "Low pH") # removes the space in between the words

# Manipulation - pg 8
shapes <- c("Square", "Circle", "Triangle")
paste("My favorite shape is a", shapes) # adds each string to the paste string
two_cities <- c("best", "worst")
paste("It was the", two_cities, "of times.")

# Manipulation: individual characters - pg 9
shapes # vector of shapes
str_length(shapes) # how many letters are in each word?
seq_data <- c("ATCCCGTC")
str_sub(seq_data, start = 2, end = 4) # extract the 2nd to 4th AA

# Manipulation - pg 10
str_sub(seq_data, start = 3, end = 3) <- "A" # substitutes an A in the 3rd position
seq_data
str_dup(seq_data, times = c(2, 3)) # times is the number of times to duplicate each string

# White space - pg 11
badtreatments<-c("High", " High", "High ", "Low", "Low")
badtreatments
str_trim(badtreatments) # removes both white space left and right of a string
str_trim(badtreatments, side = "left") # removes left white space

# White space - pg 12
str_pad(badtreatments, 5, side = "right") # adds a white space to the right side after the 5th character
str_pad(badtreatments, 5, side = "right", pad = "1") # adds a 1 to the right side after the 5th character

# Locale sensitive - pg 13
x <- "I love R!"
str_to_upper(x) # capitalizes every character in a string
str_to_lower(x) # un-capitalizes every character in a string
str_to_title(x) # capitalizes the first character in each word of a string

# Pattern matching - pg 14
data <- c("AAA", "TATA", "CTAG", "GCTT")
str_view(data, pattern = "A") # finds all the strings with an A

# Pattern matching - pg 15
str_detect(data, pattern = "A") # detects a specific pattern
str_detect(data, pattern = "AT")
str_locate(data, pattern = "AT") # locates a pattern

# Metacharacters - pg 18
vals <- c("a.b", "b.c","c.d")
str_replace(vals, "\\.", " ") # string, pattern, replace all the "." with a space

# Aside about the functions - pg 19
vals<-c("a.b.c", "b.c.d","c.d.e")
str_replace(vals, "\\.", " ") # string, pattern, replace only at the first instance of a period
str_replace_all(vals, "\\.", " ") # string, pattern, replace only at all instances of a period

# Sequences - pg 20
val2 <- c("test 123", "test 456", "test")
str_subset(val2, "\\d") # only keeps strings with digits

# Character class - pg 21
str_count(val2, "[aeiou]") # counts the number of lowercase vowels in each string
str_count(val2, "[0-9]") # counts the number of digit between 0 to 9

# Example: find the phone numbers - pg 23
strings <- c("550-153-7578",
             "banana",
             "435.114.7586",
             "home: 672-442-6739")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
# 1st, () = [look for numbers from 2-9][look for numbers from 0-9]{repeat before twice}
# 2nd, [] = [identities separators including "-" or "."]
# 3rd, () = [look for numbers from 0-9]{repeat before trice}
# 4th, [] = [identities separators including "-" or "."]
# 5th, () = [look for numbers from 0-9]{repeat before 4x}
str_detect(strings, phone) # which strings contain phone numbers?

# Example: find the phone numbers - pg 24 & 25
test <- str_subset(strings, phone) # subset only the strings with phone numbers
test

test %>%
  str_replace_all("\\D", " ") %>%
  str_trim() %>%
  str_replace_all(" ", "-")
test_fix

# or.....

test %>%
  str_replace_all(pattern = "\\.", replacement = "-") %>% # replace periods with -
  str_replace_all(pattern = "[a-zA-Z]|\\:", replacement = "") %>% # remove all the things we don't want
  str_trim() # trim the white space

# tidytext - pg 26, 27, 28, 29, 30, and 31
head(austen_books())# explore books by Jane Austen
tail(austen_books())

original_books <- austen_books() %>% # gets all of Jane Austen's books
  group_by(book) %>%
  mutate(line = row_number(), # finds every line
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", # counts the chapters (starts with the word chapter followed by a digit or roman numeral)
                                                 ignore_case = TRUE)))) %>% # ignore lower or uppercase
  ungroup() # ungroup it so we have a dataframe again
# don't try to view the entire thing... its >73000 lines...
head(original_books)
head(original_books)

tidy_books <- original_books %>%
  unnest_tokens(output = word, input = text) # adds a column named word, with the input as the text column
head(tidy_books) # there are now >725,000 rows. Don't view the entire thing!

# see an example of all the stopwords
head(get_stopwords())

cleaned_books <- tidy_books %>%
  anti_join(get_stopwords()) # dataframe without the stopwords
head(cleaned_books)

cleaned_books %>%
  count(word, sort = TRUE)

# sentiment analysis - pg 32
sent_word_counts <- tidy_books %>%
  inner_join(get_sentiments()) %>% # only keeps positive or negative words
  count(word, sentiment, sort = TRUE) # counts them

# Let's plot it - pg 33
sent_word_counts %>%
  filter(n > 150) %>% # take only if there are over 150 instances of it
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>% # add a column where if the word is negative make the count negative
  mutate(word = reorder(word, n)) %>% # sort it so it gows from largest to smallest
  ggplot(aes(word, n, fill = sentiment)) +
  geom_col() +
  coord_flip() +
  labs(y = "Contribution to sentiment")

# Make a wordcloud - pg 35
words <- cleaned_books %>%
  count(word) %>% # counts all the words
  arrange(desc(n)) %>% # sorts the words
  slice(1:100) #take the top 100
wordcloud2(words, shape = 'triangle', size = 0.3) # makes a wordcloud out of the top 100 words