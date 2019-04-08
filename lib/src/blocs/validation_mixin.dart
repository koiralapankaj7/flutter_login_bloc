import 'dart:async';

class ValidationMixin {
  // Stream transforemer can be used multiple time as much as we want. If we create a function for
  // stream transofrmer we will ending up by building brand new stream transformer for
  // each function call. So we will create variable insted for stream transformer

  // We can also specify the data type that stream transformer going ro receive and return by adding
  // <ReceivedDataType, ReturnDataType> after StreamTransformer
  final StreamTransformer validateEmail =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, EventSink<String> sink) {
      if (email.contains('@')) {
        sink.add(email);
      } else {
        sink.addError("Please enter valid email");
      }
    },
  );

  final StreamTransformer validatePassword =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String password, EventSink<String> sink) {
      if (password.length > 3) {
        sink.add(password);
      } else {
        sink.addError("Your password must be at least 4 character");
      }
    },
  );
}
