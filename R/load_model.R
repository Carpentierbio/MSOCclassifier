#' load model
#' This function loads model for subtype prediction.
#'
#' @return A model.
#' @export
#' @import caret


load_model <- function() {
  model_path <- system.file("MSOC_classifier.rds", package = "MSOCclassifier")
  readRDS(model_path)
}
