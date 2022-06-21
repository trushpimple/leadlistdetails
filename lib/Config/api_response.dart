class APISuccess {
  int statusCode;
  Object reponse;
  APISuccess({
    this.reponse,
    statusCode,
  });
}

class APIFailed {
  int statusCode;
  Object reponse;
  APIFailed({
    this.reponse,
    statusCode,
  });
}
