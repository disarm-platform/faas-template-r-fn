library(jsonlite)

source('function.R')

main = function () {
  # reads STDIN, return error if any problems
  stdin = get_stdin()
  
  # parses STDIN as JSON, return error if any problems
  params = get_params(stdin)
  
  # checks for existence of required parameters, return error if any problems
  check_params_exist(params)
  
  # checks types/structure of all parameters, return error if any problems
  check_params_structure(params)
  
  # if any parameters refer to remote files, try to download and replace parameter with local/temp file reference, return error if any problems
  retrieve_remote_files(params)
  
  # `tryCatch` to run the function with parameters, return error if any problems, return success if succeeds      
  run_function(params)
}

get_stdin = function() {
  tryCatch({
    readLines(file("stdin"))
  }, error = function(e) {
    handle_error(e, message = 'Problem getting STDIN')
  })
}

get_params = function(stdin) {
  tryCatch({
    fromJSON(stdin)
  }, error = function(e) {
    handle_error(e, message = 'Problem parsing parameters')
  })
}

check_params_exist = function(params) {
  # Individual check for each parameter
  if (is.null(params$number)) {
    handle_error(NULL, message = 'Missing `number` parameter')
  }
}

check_params_structure = function(params) {
  if (!is.numeric(params$number)) {
    handle_error(NULL, message = 'Parameter `number` is not numeric')
  }
  if (length(params$number) != 1) {
    handle_error(NULL, message = 'Only pass a single value for `number')
  }
}

retrieve_remote_files = function(params) {
  # check if any params are strings that start with 'http' (any case)
  # tryCatch retrieve that file, 
  #   handle_error if problems, 
  #   otherwise, write to temp disk, replace parameter with temp filename
}

handle_error = function(error, message = '') {
  type = 'error'
  response = toJSON(list(type = unbox(type), message = unbox(message), content = as.character(error)))
  write(response, stdout())
  stop()
}

handle_success = function(content) {
  type = 'success'
  response = toJSON(list(type = unbox(type), content = content))
  write(response, stdout())
  stop()
}

main()
