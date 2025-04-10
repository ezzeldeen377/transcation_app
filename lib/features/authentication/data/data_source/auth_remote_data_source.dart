import 'package:injectable/injectable.dart';
import 'package:transcation_app/core/networking/api_constant.dart';
import 'package:transcation_app/core/networking/http_services.dart';
import 'package:transcation_app/core/utils/try_and_catch.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> register(
      {required String email,
      required String password,
      required String name,
      required String phone});
  Future<Map<String, dynamic>> login(
      {required String email, required String password});
  Future<Map<String, dynamic>> getUserData({required String token});
  Future<String> logout(String token);
  Future<Map<String, dynamic>> verifyCode(String email, String code);
  Future<String> resendVerifyCode(String email);
    Future<Map<String, dynamic>> refreshToken({required String token});


}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    return executeTryAndCatchForDataLayer(() async {
      final response= await HttpServices.instance.post(ApiConstant.registerEndPoint,
          body: {
            "email": email,
            "password": password,
            "name": name,
            "phone": phone
          });
          return response['message'];
    });
  }

  @override
  Future<Map<String, dynamic>> login(
      {required String email, required String password}) {
    return executeTryAndCatchForDataLayer(() async {
      return await HttpServices.instance.post(ApiConstant.loginEndPoint, body: {
        "email": email,
        "password": password,
      });
    });
  }

  @override
  Future<Map<String, dynamic>> getUserData({required String token}) {
    return executeTryAndCatchForDataLayer(() async {
      return await HttpServices.instance.post(ApiConstant.meEndPoint, body: {
        "token": token,
      });
    });
  }

  @override
  Future<String> logout(String token) {
    return executeTryAndCatchForDataLayer(() async {
      final response =
          await HttpServices.instance.post(ApiConstant.logoutEndPoint, body: {
        "token": token,
      });
      return response['message'];
    });
  }

  @override
  Future<Map<String, dynamic>> verifyCode(String email, String code) {
    return executeTryAndCatchForDataLayer(() async {
      return await HttpServices.instance
          .post(ApiConstant.verifyCodeEndPoint, body: {
        "email": email,
        "code": code,
      });
    });
  }

  @override
  Future<String> resendVerifyCode(String email) {
    return executeTryAndCatchForDataLayer(() async {
      final response = await HttpServices.instance
          .post(ApiConstant.resendVerificationCodeEndPoint, body: {
        "email": email,
      });
      return response['message'];
    });
  }
  
  @override
  Future<Map<String, dynamic>> refreshToken({required String token}) {
    return executeTryAndCatchForDataLayer(() async {
      return await HttpServices.instance
         .post(ApiConstant.refreshTokenEndPoint, body: {
        "token": token,
      });
    });
  }
}
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   CollectionReference get _userCollection => firestore.collection(FirebaseCollections.usersCollection);
  
//   @override
//   Stream<User?> get authStateChanges => _auth.authStateChanges();
//   @override
//   Future<UserCredential> signUp(
//       {required String email,
//       required String password,
//       required String name}) async {
//     return await executeTryAndCatchForDataLayer(() async {
//       // Create the user account
//       final userCredential = await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .timeout(const Duration(seconds: 60));

//       if (userCredential.user == null) {
//         throw FirebaseAuthException(
//             message: "User creation failed", code: 'user-not-found');
//       }
// print("User logged in: ${userCredential.user?.emailVerified}");

//       // Update display name
//       await userCredential.user!.updateDisplayName(name);
      
//       // Skip email verification
//       return userCredential;
//     });
//   }

  // @override
  // Future<void> sendVerificationEmail() async {
  //   return await executeTryAndCatchForDataLayer(() async {
  //     await _auth.currentUser?.sendEmailVerification();
  //     await _auth.signOut();
      
  //   });
  // }

//   @override
//   Future<void> setUser({required UserModel userModel}) async {
//     return await executeTryAndCatchForDataLayer(() async {
//       await _userCollection.doc(userModel.uid).set(userModel.toMap());
//     });
//   }

//   @override
//   Future<void> deleteUser({required String uid}) async {
//     return await executeTryAndCatchForDataLayer(() async {
//       await _auth.currentUser?.delete();
//       await _userCollection.doc(uid).delete();
//     });
//   }

  // @override
  // Future<UserCredential> signIn(
  //     {required String email, required String password}) async {
  //   return await executeTryAndCatchForDataLayer(() async {
  //     final userCredential = await _auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .timeout(const Duration(seconds: 45));

  //     // Email verification check removed to allow immediate access

  //     return userCredential;
  //   });
  // }

//   @override
//   Future<Map<String, dynamic>?> getUserData({required String uid}) async {
//     return await executeTryAndCatchForDataLayer(() async {
//       final doc = await _userCollection.doc(uid).get();
//       if (doc.exists) {
//         return doc.data() as Map<String, dynamic>;
//       } else {
//         return null;
//       }
//     });
//   }

//   @override
//   Future<void> signOut() async {
//     return await executeTryAndCatchForDataLayer(() async {
//       User? user = _auth.currentUser;
//       if (user != null) {
//         String? providerId;
//         if (user.providerData.isNotEmpty) {
//           providerId =
//               user.providerData.first.providerId; // Get the first provider
//           if (providerId == 'google.com') {
//             // Sign out only from Google
//             await GoogleSignIn().signOut();
//             print('Signed out from Google');
//           } else {
//             // Sign out for other providers (e.g., email/password)
//             await FirebaseAuth.instance.signOut();
//             print('Signed out from Firebase');
//           }

//           _auth.signOut();
//         }
//       }
//     });
//   }

//   @override
//   Future<UserCredential> googleAuth() async {
//     return await executeTryAndCatchForDataLayer(() async {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       final userCredential = await _auth.signInWithCredential(credential);

//       return userCredential;
//     });
//   }

//   @override
//   Future<bool> checkUesrSignin() async {
//     return await executeTryAndCatchForDataLayer(() async {
//       return _auth.currentUser != null;
//     });
//   }

//   @override
//   Future<void> updateUser(String uid, Map<String, dynamic> data) async {
//     return await executeTryAndCatchForDataLayer(() async {
//       await _userCollection.doc(uid).update(data);
//     });
//   }
// }
