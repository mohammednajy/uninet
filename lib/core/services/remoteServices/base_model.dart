class FirebaseResponse<T> {
  Status status;
  T? data;
  String? message;
  
  FirebaseResponse.loading(this.message) : status = Status.LOADING;
  FirebaseResponse.init() : status = Status.INIT;
  FirebaseResponse.completed(this.data) : status = Status.COMPLETED;
  FirebaseResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR ,INIT}
