import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginResponse {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final User? user;
  final String? message;
  final String? error;

  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.user,
    this.message,
    this.error,
  });



  LoginResponse copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
    User? user,
    String? message,
    String? error,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      user: user ?? this.user,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user': user?.toMap(),
      'message': message,
      'error': error,
    };
  }

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    return LoginResponse(
      accessToken: map['access_token'] != null ? map['access_token'] as String : null,
      tokenType: map['token_type'] != null ? map['token_type'] as String : null,
      expiresIn: map['expires_in'] != null ? map['expires_in'] as int : null,
      user: map['user'] != null ? User.fromMap(map['user'] as Map<String,dynamic>) : null,
      message: map['message'] != null ? map['message'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }


  @override
  String toString() {
    return 'LoginResponse(accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, user: $user, message: $message, error: $error)';
  }

  @override
  bool operator ==(covariant LoginResponse other) {
    if (identical(this, other)) return true;
  
    return 
      other.accessToken == accessToken &&
      other.tokenType == tokenType &&
      other.expiresIn == expiresIn &&
      other.user == user &&
      other.message == message &&
      other.error == error;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
      tokenType.hashCode ^
      expiresIn.hashCode ^
      user.hashCode ^
      message.hashCode ^
      error.hashCode;
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? password;
  final String? phone;
  final int? balance;
  final int? profit;
  final String? verificationCode;
  final bool? isVerified;
  final String? rememberToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userIdentifier;  // Added new field

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.phone,
    this.balance,
    this.profit,
    this.verificationCode,
    this.isVerified,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.userIdentifier,  // Added to constructor
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? emailVerifiedAt,
    String? password,
    String? phone,
    int? balance,
    int? profit,
    String? verificationCode,
    bool? isVerified,
    String? rememberToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userIdentifier,  // Added to copyWith
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      balance: balance ?? this.balance,
      profit: profit ?? this.profit,
      verificationCode: verificationCode ?? this.verificationCode,
      isVerified: isVerified ?? this.isVerified,
      rememberToken: rememberToken ?? this.rememberToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userIdentifier: userIdentifier ?? this.userIdentifier,  // Added to copyWith return
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'password': password,
      'phone': phone,
      'balance': balance,
      'profit': profit,
      'verification_code': verificationCode,
      'is_verified': isVerified,
      'remember_token': rememberToken,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'user_identifier': userIdentifier,  // Added to toMap
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      emailVerifiedAt: map['email_verified_at'] as String?,
      password: map['password'] != null ? map['password'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      balance: map['balance'] != null ? map['balance'] as int : null,
      profit: map['profit'] != null ? map['profit'] as int : null,
      verificationCode: map['verification_code'] as String?,
      isVerified: map['is_verified'] != null ? (map['is_verified'] == 1) : null,
      rememberToken: map['remember_token'] as String?,
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      userIdentifier: map['user_identifier'] != null ? map['user_identifier'] as String : null,  // Added to fromMap
    );
  }



  // @override
  // String toString() {
  //   return 'User(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, password: $password, phone: $phone, balance: $balance, verificationCode: $verificationCode, isVerified: $isVerified, rememberToken: $rememberToken, createdAt: $createdAt, updatedAt: $updatedAt)';
  // }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.emailVerifiedAt == emailVerifiedAt &&
      other.password == password &&
      other.phone == phone &&
      other.balance == balance &&
      other.profit == profit &&
      other.verificationCode == verificationCode &&
      other.isVerified == isVerified &&
      other.rememberToken == rememberToken &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
      other.userIdentifier == userIdentifier;  // Added to equality operator
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      emailVerifiedAt.hashCode ^
      password.hashCode ^
      phone.hashCode ^
      balance.hashCode ^
      profit.hashCode ^
      verificationCode.hashCode ^
      isVerified.hashCode ^
      rememberToken.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);
}
