function(params) {
  # Individual check for each parameter
  if (is.null(params$number)) {
    return(handle_error(NULL, message = 'Missing `number` parameter'))
  }
  if (!is.numeric(params$number)) {
    return(handle_error(NULL, message = 'Parameter `number` is not numeric'))
  }
  if (length(params$number) != 1) {
    return(handle_error(NULL, message = 'Only pass a single value for `number'))
  }
}