import 'package:firebase_auth/firebase_auth.dart';

String handleFirebaseStorageError(FirebaseException e, {String process = 'process'}) {
  String message = e.message ?? '';
  print('----- e code: ${e.code}');

  if (e.code == 'storage/object-not-found') {
    return 'The file does not exist.';
  }
  //
  else if (e.code == 'storage/object-not-found') {
    return 'You canceled the operation.';
  }
  //
  else if (message.contains('A network error') || message.contains('auth/network-request-failed')) {
    return 'Network error. Please check your internet connection.';
  }
  //
  else if (message.contains('An internal error has occurred')) {
    return 'Network error. Please check your internet connection.';
  }
  //
  else {
    return 'Failed to $process. Please try again.';
  }
}
