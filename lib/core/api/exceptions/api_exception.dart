import 'package:easy_localization/easy_localization.dart';
import 'contracts/failure.dart';

class ValidationFailure implements Failure {
  late String message;
  ValidationFailure(this.message);

  @override
  String failureMessage() {
    return message;
  }
}

class CancelFailure implements Failure {
  @override
  String failureMessage() {
    return "request_to_server_was_cancelled".tr();
  }
}

class ServerFailure implements Failure {
  final String? message;

  ServerFailure({this.message});

  @override
  String failureMessage() {
    return message ?? "something_went_wrong_and_your_request_could_not_be_completed".tr();
  }
}

class InternetFailure implements Failure {
  @override
  String failureMessage() {
    return "no_internet_connection".tr();
  }
}

class BadResponseFailure implements Failure {
  final String? message;

  BadResponseFailure({this.message});

  @override
  String failureMessage() {
    return message ?? "bad_response_from_the_server".tr();
  }
}

class ConnectionTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "connection_timeout_with_server".tr();
  }
}

class ReceivedTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "";
  }
}

class SendTimeOutFailure implements Failure {
  @override
  String failureMessage() {
    return "send_timeout_in_connection_with_server".tr();
  }
}

class ConnectionFailure implements Failure {
  final String? message;

  ConnectionFailure({this.message});

  @override
  String failureMessage() {
    return message ?? "connection_to_server_failed_due_to_internet_connection".tr();
  }
}

class BadCertificateFailure implements Failure {
  @override
  String failureMessage() {
    return "bad_certificate".tr();
  }
}

class BadRequestFailure implements Failure {
  @override
  String failureMessage() {
    return "bad_request_failure".tr();
  }
}

class UnknownFailure implements Failure {
  final String? message;

  UnknownFailure({this.message});

  @override
  String failureMessage() {
    return message ?? "unknown_error".tr();
  }
}
