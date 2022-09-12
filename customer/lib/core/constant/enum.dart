enum HttpMethod {
  POST,
  GET,
  PUT,
  DELETE,
  POST_WITH_AUTH,
  GET_WITH_AUTH,
  PUT_WITH_AUTH,
  DELETE_WITH_AUTH
}

enum CustomState {
  LOADING,
  DONE,
  ERROR,
}

enum SettingsResponse {
  dataDeleted,
  failedDeleteData,
}