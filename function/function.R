function(params) {
  # run function and catch result
  result = tryCatch({
    params$number + 1
  }, error = function(e) {handle_error(e, message = 'Problem running function')})
  
  # wrap up result to match output structure from docs
  response = list(result = unbox(result))
  
  handle_success(response)
}
