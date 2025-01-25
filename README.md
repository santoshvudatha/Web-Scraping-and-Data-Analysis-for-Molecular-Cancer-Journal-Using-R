# Molecular Cancer Journal Data Scraper

This project automates the extraction of research article metadata from the *Molecular Cancer* journal website using R. It collects titles, authors, abstracts, correspondence authors, keywords, and publication dates, storing the data in a CSV file for analysis.

## Features
- Scrapes data from multiple pages of the journal.
- Extracts key article details (titles, abstracts, keywords, etc.).
- Cleans and deduplicates data for accuracy.
- Exports results to a structured CSV file.

## Requirements
- R (Version 4.0 or higher)
- Required Packages:
  - `rvest`
  - `dplyr`
  - `httr`
  - `tidyverse`
  - `writexl`

## Setup
1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>
   ```
2. Open the script in RStudio.
3. Install the required packages:
   ```R
   install.packages(c("rvest", "dplyr", "httr", "tidyverse", "writexl"))
   ```

## Usage
1. Run the script to scrape data:
   - It will fetch article details from all available pages.
   - Extracted data will be saved as `molecular_cancer_data.csv` in the project folder.
2. Analyze the data using your preferred tools.

## Output
- `molecular_cancer_data.csv`: Contains article metadata, including:
  - Title
  - Authors
  - Abstract
  - Keywords
  - Correspondence Author
  - Published Date

## Applications
- Trend analysis in cancer research.
- Metadata collection for academic studies.
- Author and keyword frequency analysis.

## License
This project is open-source and available under the [MIT License](LICENSE).

## Contributions
Feel free to submit issues or pull requests for enhancements or fixes.
