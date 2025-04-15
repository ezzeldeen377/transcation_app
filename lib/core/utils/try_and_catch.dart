import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:transcation_app/core/error/failure.dart';
import 'package:transcation_app/core/error/netowrk_exception.dart';


Future<Either<Failure, T>> executeTryAndCatchForRepository<T>(
    Future<T> Function() action) async {
  try {
    final result = await action();
    return right(result);
  } on NoInternetException {
    return left(Failure("Network connection error"));
  } on TimeoutException {
    return left(Failure("Request timed out. Please try again"));
  } on SocketException {
    return left(Failure("Network connection error"));
  } on FormatException {
    return left(Failure("An unexpected error occurred"));
  } catch (e) {
    if (e.toString().contains('network error') ||
        e.toString().contains('timeout') ||
        e.toString().contains('RecaptchaCallWrapper')) {
      return left(Failure("Network connection error"));
    }
    
    final errorMessage = e.toString()
        .replaceAll('Exception:', '')
        .replaceAll('Failed to perform POST request:', '')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .trim();
    
    return left(Failure(errorMessage));
  }
}

Future<T> executeTryAndCatchForDataLayer<T>(Future<T> Function() action) async {
  try {
    var check = await Connectivity().checkConnectivity();

    if (check.contains(ConnectivityResult.mobile) ||
        check.contains(ConnectivityResult.wifi)) {
      return await action();
    } else {
      throw NoInternetException(
          "Network connection error");
    }
  }  on TimeoutException {
    rethrow;
  } on SocketException {
    rethrow;
  } on FormatException {
    rethrow;
  } catch (e) {
   rethrow;
  }
}



// for debug








// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fpdart/fpdart.dart';
// import '../erorr/faliure.dart';
// import '../erorr/netowrk_exception.dart';

// // Define a utility function to handle exceptions and return an Either type
// Future<Either<Faliure, T>> executeTryAndCatchForRepository<T>(
//     Future<T> Function() action) async {
//   try {
//     final result = await action();
//     return right(result);
//   } on FormatException catch (e) {
//     return left(Faliure('Error parsing data: ${e.message}'));
//   } on NoInternetException catch (e) {
//     return left(Faliure(e.message));
//   } on TypeError catch (e) {
//     return left(Faliure(
//         'Type error: ${e.toString()}. This might be due to incorrect data structure.'));
//   } on NoSuchMethodError catch (e) {
//     return left(Faliure(
//         'Method not found: ${e.toString()}. This might be due to missing fields in the data.'));
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'invalid-email') {
//       return left(Faliure("The email address is not valid."));
//     } else if (e.code == 'user-disabled') {
//       return left(Faliure("This user account has been disabled."));
//     } else if (e.code == 'user-not-found') {
//       return left(Faliure("No user found with this email."));
//     } else if (e.code == 'wrong-password') {
//       return left(Faliure("The password is incorrect."));
//     } else if (e.code == 'email-already-in-use') {
//       return left(Faliure("The email is already in use by another account."));
//     } else if (e.code == 'weak-password') {
//       return left(Faliure("The password is too weak."));
//     } else if (e.code == 'invalid-credential') {
//       return left(Faliure("Invalid email or password."));
//     } else {
//       return left(Faliure(
//           //e.message ??
//           'unExpected error occurred'));
//     }
//   } catch (e) {
//     print('Caught exception: ${e.hashCode} - ${e.toString()}');
//     if (e is FirebaseException) {
//       return left(Faliure(
//           'Firebase error: ${e.code} - ${e.message ?? 'An unknown Firebase error occurred'}'));
//     } else if (e is TimeoutException) {
//       return left(Faliure('Operation timed out: ${e.message}'));
//     } else if (e is SocketException) {
//       return left(Faliure('Network error: ${e.message}'));
//     } else {
//       return left(Faliure('an unexpected error occurred: ${e.toString()}'));
//     }
//   }
// }

// Future<T> executeTryAndCatchForDataLayer<T>(Future<T> Function() action) async {
//   try {
//     var check = await Connectivity().checkConnectivity();

//     if (check.contains(ConnectivityResult.mobile) ||
//         check.contains(ConnectivityResult.wifi)) {
//       return await action();
//     } else {
//       throw NoInternetException();
//     }
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'invalid-credential') {
//       throw FirebaseAuthException(
//           message: "Invalid email or password.", code: e.code);
//     } else if (e.code == 'weak-password') {
//       throw FirebaseAuthException(
//           message: "The password is too weak.", code: e.code);
//     } else if (e.code == 'email-already-in-use') {
//       throw FirebaseAuthException(
//           message: "The email is already in use by another account.",
//           code: e.code);
//     } else if (e.code == 'wrong-password') {
//       throw FirebaseAuthException(
//           message: "The password is incorrect.", code: e.code);
//     } else if (e.code == 'user-not-found') {
//       throw FirebaseAuthException(
//           message: "No user found with this email.", code: e.code);
//     } else if (e.code == 'user-disabled') {
//       throw FirebaseAuthException(
//           message: "This user account has been disabled.", code: e.code);
//     } else if (e.code == 'invalid-email') {
//       throw FirebaseAuthException(
//           message: "The email address is not valid.", code: e.code);
//     }
//     throw FirebaseAuthException(
//         message: e.message ?? 'An unknown Firebase error occurred',
//         code: e.code);
//   } on FirebaseException catch (e) {
//     throw FirebaseException(
//         message:
//             'Firebase error: ${e.code} - ${e.message ?? 'An unknown Firebase error occurred'}',
//         code: e.code,
//         plugin: e.plugin);
//   } on TimeoutException catch (e) {
//     throw Exception('Operation timed out: ${e.message}');
//   } on SocketException catch (e) {
//     throw Exception('Network error: ${e.message}');
//   } on FormatException catch (e) {
//     throw FormatException('Error parsing data: ${e.message}');
//   } catch (e) {
//     print('#########################${e.toString()}');
//     throw Exception('An unexpected error occurred: ${e.toString()}');
//   }
// }
