# CsvTool


## Setup
1. Clone this repo
2. Run `bundle install` inside it

## Usage
In this repo:

`bundle exec ./bin/csv_tool help`


## Useful commands
`fix_mac_line_endings` -- Replaces Mac line endings "\r" with unix line
endings "\n". After exporting a file to csv from Mac excel, run it
through this to make it parsable.

```
Commands:
  csv_tool check_parse FILE                           # Parses the csv to and returns basic facts
  csv_tool fix_mac_line_endings INFILE OUTFILE        # Re-encodes the strings in the file to from windows to unicode
  csv_tool help [COMMAND]                             # Describe available commands or one specific command
  csv_tool make_detroit_square INFILE OUTFILE         # Tries to normalize detroit's unescaped transactions
  csv_tool merge_csv_files INFILES --outfile=OUTFILE  # Merges multiple CSV files into one large CSV file
  csv_tool split_csv_file INFILE OUTFILE              # splits a large csv file with headers across multiple files. The outfile argument is used as a base name for the output files
```
