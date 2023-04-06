#!/bin/bash

show_help=0

# Input catalog file names
CATALOG1="/home/jorge/merged_negative.vot.gz"
CATALOG2="/home/jorge/merged_positive.vot.gz"  # vvvx_bsouth_positive_region-result.vot.gz


# Output merged and Cross-matched catalogs file names
MERGED_CATALOG="/home/jorge/merged.vot"

# Function to display help message
display_help() {
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  -f1 FILE   Specify table 1 filename"
  echo "  -f2 FILE   Specify table 2 filename"
  echo "  -m  FILE   Specify filename of the output merged catalog"
  echo "  -h         Display this help message"
}

# Process flags using getopts
while getopts "i1:i2:d:h" opt; do
  case $opt in
    f1)
      CATALOG1="$OPTARG"
      ;;
    f2)
      CATALOG2="$OPTARG"
      ;;
    m)
      MERGED_CATALOG="$OPTARG"
      ;;
    h)
      show_help=1
      ;;
    *)
      display_help
      exit 1
      ;;
  esac
done

# Display help message if -h flag was provided
if [ "$show_help" -eq 1 ]; then
  display_help
  exit 0
fi

# Check if input files exist
if [ ! -f "$CATALOG1" ] || [ ! -f "$CATALOG2" ]; then
    echo "Error: One or both input catalog files do not exist."
    echo "  Catalog 1: $CATALOG1"
    echo "  Catalog 2: $CATALOG2"
    exit 1
fi

# Merge the catalogs using STILTS tcat command
date
stilts tcat in="$CATALOG1" in="$CATALOG2" out="$MERGED_CATALOG" ofmt=votable
echo "Merged catalogs saved as $MERGED_CATALOG"
date

# Compress the output catalog
pigz -k $MERGED_CATALOG
echo "Compressed $MERGED_CATALOG.gz"
date
