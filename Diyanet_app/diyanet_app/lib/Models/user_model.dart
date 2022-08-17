final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    userId, userName, userLastName, userEmail, userPassword,
  ];

  static final String userId = "_id";
  static final String userName = "userName";
  static final String userLastName = "userLastName";
  static final String userEmail = "userEmail";
  static final String userPassword = "userPassword";
  
}

class User {
  int? userId;
  String? userName;
  String? userLastName;
  String? userEmail;
  String? userPassword;
  

  User({
    this.userId,
    required this.userName,
    required this.userLastName,
    required this.userEmail,
    required this.userPassword,
    
  });

  User copy({
    int? userId,
    String? userName,
    String? userLastName,
    String? userEmail,
    String? userPassword,
    
  }) =>
      User(
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userLastName: userLastName ?? this.userLastName,
        userEmail: userEmail ?? this.userEmail,
        userPassword: userPassword ?? this.userPassword,
        
      );

  Map<String, Object?> toJson() => {
        UserFields.userId: userId,
        UserFields.userName: userName,
        UserFields.userLastName: userLastName,
        UserFields.userEmail: userEmail,
        UserFields.userPassword: userPassword,
        
      };

  static User fromJson(Map<String, Object?> json) => User(
        userId: json[UserFields.userId] as int?,
        userName: json[UserFields.userName] as String,
        userLastName: json[UserFields.userLastName] as String,
        userEmail: json[UserFields.userEmail] as String,
        userPassword: json[UserFields.userPassword] as String,
        
      );
}
