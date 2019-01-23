function(params) {
  # run function and catch result
  result = tryCatch({
    params[['number']] + 1
  }, error = function(e) {
    return(handle_error(e, message = 'Problem running function'))
  })
  
  # return(handle_error(NULL, message = 'Something broke'))
  
  # wrap up result to match output structure from docs
  response = list(result = unbox(result))

  return(handle_success(response))
}
