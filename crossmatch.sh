#!/bin/bash

show_help=0

# Input catalog file names
CATALOG1="/home/jorge/Documents/data/jhk_bsouth.fits"
CATALOG2="/home/jorge/Documents/data/vvvx_bsouth_negative_region-result.vot.gz"

# Output merged and Cross-matched catalogs file names
CROSS_MATCHED_CATALOG="/home/jorge/merged_negative.vot"

# Function to display help message
display_help() {
  echo "Usage: $0 [options]"
  echo
  echo "Options:"
  echo "  -f1 FILE   Specify table 1 filename"
  echo "  -f2 FILE   Specify table 2 filename"
  echo "  -x  FILE   Specify filename of the output cross-matched catalog"
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
    x)
      CROSS_MATCHED_CATALOG="$OPTARG"
      ;;
    h)
      show_help=1
      ;;
c
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

date
# Cross-match the catalogs using STILTS tmatch2 command
stilts tmatch2 \
       in1=$CATALOG1 \
       in2=$CATALOG2 \
       matcher=sky \
       params=0.34 \
       join=1and2 \
       values1='ra dec' \
       values2='ra dec' \
       out=$CROSS_MATCHED_CATALOG \
       ofmt=votable    
echo "Merged catalogs saved as $MERGED_CATALOG"
date

# Compress the output catalog
pigz $CROSS_MATCHED_CATALOG
echo "Compressed $MERGED_CATALOG .gz"
date