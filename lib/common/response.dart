import 'package:equatable/equatable.dart';

class GeneralResponse extends Equatable {
  bool isError = false;
  String message = "";

  GeneralResponse(this.isError, this.message);

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    isError = json['error'];
    message = json['message'] ?? "";
  }

  @override
  List<Object?> get props => [
    isError,
    message,
  ];
}