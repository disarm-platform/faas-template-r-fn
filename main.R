library(jsonlite)

check_params = dget('function/check_params.R')
run_function = dget('function/function.R')

main = function () {
  # reads STDIN as JSON, return error if any problems
  params = get_params()
  
  # checks for existence of required parameters, return error if any problems
  # checks types/structure of all parameters, return error if any problems
  check_params(params)

  # if any parameters refer to remote files, try to download and replace parameter with local/temp file reference, return error if any problems
  retrieve_remote_files(params)
  
  # `tryCatch` to run the function with parameters, return error if any problems, return success if succeeds      
  run_function(params)
}

get_params = function() {
  tryCatch({
    fromJSON(readLines(file("stdin")))
  }, error = function(e) {
    handle_error(e, message = 'Problem parsing STDIN as JSON')
  })
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

handle_success = function(content, message = '') {
  type = 'success'
  response = toJSON(list(type = unbox(type), message = unbox(message), content = content))
  write(response, stdout())
  stop()
}

main()
