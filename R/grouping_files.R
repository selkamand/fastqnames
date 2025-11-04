#' Extract read direction and lane information from FASTQ filenames
#'
#' Parses paired-end FASTQ filenames to extract sequencing lane and read direction
#' identifiers (e.g., `R1` / `R2` and `L001`, `L002`), returning them in a tidy data frame.
#'
#' @param names Character vector of FASTQ filenames or paths.
#'
#' @return A data frame with columns:
#' \describe{
#'   \item{lane}{Sequencing lane ID (e.g., `"L001"`).}
#'   \item{read_direction}{Read direction (either `"R1"` or `"R2"`).}
#'   \item{name}{The base filename (without directory path).}
#' }
#'
#' @examples
#' example_names() |> get_read_info_from_name()
#'
#' @export
get_read_info_from_name <- function(names){
  base = basename(names)
  read_direction = stringr::str_extract(string = base, "[_\\.](R[12])[$\\._]", group = 1)
  lane = stringr::str_extract(string = base, "[_\\.](L[0-9][0-9][0-9])[$\\._]", group = 1)
  data.frame(lane = lane, read_direction = read_direction, name = base)
}

#' Group paired-end FASTQ files by lane and read direction
#'
#' Sorts a set of FASTQ filenames into R1/R2 pairs within each sequencing lane.
#' This helps organize inputs for alignment or merging steps.
#'
#' @param names Character vector of FASTQ filenames or paths.
#'
#' @return A named list where each element corresponds to one sequencing lane,
#'   containing a two-element character vector of file names ordered as `c("R1", "R2")`.
#'
#' @examples
#' example_names() |> sort_reads_into_pairs()
#'
#' @export
sort_reads_into_pairs <- function(names){
  base = basename(names)
  read_direction = stringr::str_extract(string = base, "[_\\.](R[12])[$\\._]", group = 1)
  lane = stringr::str_extract(string = base, "[_\\.](L[0-9][0-9][0-9])[$\\._]", group = 1)
  lane[is.na(lane)] <- "lane_not_found"
  names(base) <- read_direction
  ls_pairs_by_lane <- split(base, f = lane)
  ls_pairs_by_lane <- lapply(ls_pairs_by_lane, \(vec){vec[c("R1", "R2")]})
  return(ls_pairs_by_lane)
}

#' Example FASTQ filenames for testing
#'
#' Provides a small vector of realistic paired-end FASTQ filenames across multiple lanes.
#' Useful for demonstrating or testing filename parsing functions.
#'
#' @return A character vector of six example FASTQ file names.
#'
#' @examples
#' example_names()
#'
#' @export
example_names <- function(){
  c(
    "SampleA_S1_L001_R1_001.fastq.gz",
    "SampleA_S1_L001_R2_001.fastq.gz",
    "SampleA_S1_L002_R1_001.fastq.gz",
    "SampleA_S1_L002_R2_001.fastq.gz",
    "SampleA_S1_L003_R1_001.fastq.gz",
    "SampleA_S1_L003_R2_001.fastq.gz"
  )
}
