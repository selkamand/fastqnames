
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fastqnames

<!-- badges: start -->

<!-- badges: end -->

Take a set of names of fasta/fastq files from a single sample and
extract lane & read direction information

## Installation

You can install the development version of fastqnames like so:

``` r
if (!require("remotes"))
    install.packages("remotes")

remotes::install_github("selkamand/fastqnames")
```

## Quick Start

``` r
library(fastqnames)

# Example filenames from a sequencer
fnames <- example_names()

# Extract lane and read info
get_read_info_from_name(fnames)
#>   lane read_direction                            name
#> 1 L001             R1 SampleA_S1_L001_R1_001.fastq.gz
#> 2 L001             R2 SampleA_S1_L001_R2_001.fastq.gz
#> 3 L002             R1 SampleA_S1_L002_R1_001.fastq.gz
#> 4 L002             R2 SampleA_S1_L002_R2_001.fastq.gz
#> 5 L003             R1 SampleA_S1_L003_R1_001.fastq.gz
#> 6 L003             R2 SampleA_S1_L003_R2_001.fastq.gz

# Sort FASTQs into R1/R2 pairs by lane
sort_reads_into_pairs(fnames)
#> $L001
#>                                R1                                R2 
#> "SampleA_S1_L001_R1_001.fastq.gz" "SampleA_S1_L001_R2_001.fastq.gz" 
#> 
#> $L002
#>                                R1                                R2 
#> "SampleA_S1_L002_R1_001.fastq.gz" "SampleA_S1_L002_R2_001.fastq.gz" 
#> 
#> $L003
#>                                R1                                R2 
#> "SampleA_S1_L003_R1_001.fastq.gz" "SampleA_S1_L003_R2_001.fastq.gz"
```
