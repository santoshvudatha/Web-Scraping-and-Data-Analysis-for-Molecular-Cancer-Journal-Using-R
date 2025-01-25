# Installing required packages for this project
install.packages("rvest")
install.packages("dplyr")
install.packages("httr")
install.packages("tidyverse")
install.packages("writexl")

# Load necessary packages
library(rvest)
library(dplyr)
library(httr)
library(tidyverse)
library("writexl")

# Function to extract Abstract of an article
get_abstract <- function(title_link){
  title_page <- read_html(title_link)
  article_abstract <- title_page %>% html_nodes("#Abs1-content p") %>% html_text() %>% 
    paste(collapse = ",")
  return(article_abstract)
}

# Function to extract Correspondence Author names of an article
get_corresauthor <- function(title_link){
  title_page <- read_html(title_link)
  corres_author <- title_page %>% html_nodes("#corresponding-author-list a") %>% html_text() %>% 
    paste(collapse = ",")
  return(corres_author)
}

# Function to extract Published dates of an article
get_publisheddate <- function(title_link){
  title_page <- read_html(title_link)
  publish_date <- title_page %>%
    html_nodes(".c-article-identifiers__item time") %>% 
    html_text() %>% paste(collapse = ",")
  return(publish_date)
}

# Function to extract Keywords of an article
get_keywords <- function(title_link) {
  title_page <- read_html(title_link)
  keywords <- title_page %>% html_nodes(".c-article-subject-list__subject a") %>%
    html_text() %>% paste(collapse = ",")
  return(keywords)
}

# Creating an empty data frame 
molecular_cancer_data <- data.frame()

# Loop to traverse through all pages
for(page_result in seq(from = 1, to = 65)){
  
  # Constructing the URL to access a specific page of articles
  link <- paste0("https://molecular-cancer.biomedcentral.com/articles?searchType=journalSearch&sort=PubDate&page=", page_result, "&ref_=adv_nxt")
  
  # Fetching the HTML content of the specified page
  page <- read_html(link)
  
  # Extracting article titles from the HTML using a specific CSS selector
  Title <- page %>% html_nodes(".c-listing__title a") %>% html_text()
  
  # Extracting authors' information from the HTML
  Authors <- page %>% html_nodes(".c-listing__authors-list") %>% html_text()
  
  # Building complete links for each article based on the extracted relative links
  Title_links <- page %>% html_nodes(".c-listing__title a") %>% html_attr("href") %>%
    paste("https://molecular-cancer.biomedcentral.com", ., sep = "")
  
  # Retrieving abstracts for each article using a custom function
  Abstract <- sapply(Title_links, FUN = get_abstract, USE.NAMES = FALSE)
  
  # Extracting the correspondence author information
  correspondence_author <- sapply(Title_links, FUN = get_corresauthor, USE.NAMES = FALSE)
  
  # Retrieving the publication date for each article
  PublishedDate <- sapply(Title_links, FUN = get_publisheddate, USE.NAMES = FALSE)
  
  # Extracting keywords for each article
  Keywords <- sapply(Title_links, FUN = get_keywords, USE.NAMES = FALSE)
  
  # Creating a data frame with the extracted information
  molecular_cancer_data <- rbind(molecular_cancer_data, data.frame(Title, Authors, Abstract, correspondence_author, PublishedDate, Keywords, stringsAsFactors = FALSE))
  
  # Printing the page number to track progress
  print(paste("Page:", page_result))
}

# Remove duplicates
molecular_cancer_data <- molecular_cancer_data %>% distinct()

# Handling missing values
molecular_cancer_data[is.na(molecular_cancer_data)] <- ""

# Convert Publish Date to Date format
molecular_cancer_data$PublishedDate <- as.Date(molecular_cancer_data$PublishedDate, format = "%B %d, %Y")

# Define the file path where you want to save the CSV file
csv_file <- "molecular_cancer_data.csv"

# Write the data frame to a CSV file
write.csv(molecular_cancer_data, file = csv_file, row.names = FALSE)

# Print a message indicating successful CSV creation
cat("CSV file created successfully:", csv_file)
