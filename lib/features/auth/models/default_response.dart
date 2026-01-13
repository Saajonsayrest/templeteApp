class DefaultResponse {
  dynamic result;
  bool? response;
  String? msg;

  DefaultResponse({
    this.result,
    this.response,
    this.msg,
  });

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        result: json["result"],
        response: json["response"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "response": response,
        "msg": msg,
      };
}
