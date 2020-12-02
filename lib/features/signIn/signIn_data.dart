class SignInData {
  User user;
  int notificationsCount;

  SignInData({this.user, this.notificationsCount});

  SignInData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    notificationsCount = json['notifications_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['notifications_count'] = this.notificationsCount;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String phone;
  String gender;
  String birthDate;
  int countryId;
  int invoicesCount;
  String invoicesAmount;
  String image;
  String authorization;
  int notifications;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.gender,
      this.birthDate,
      this.countryId,
      this.invoicesCount,
      this.invoicesAmount,
      this.image,
      this.authorization,
      this.notifications});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    countryId = json['country_id'];
    invoicesCount = json['invoices_count'];
    invoicesAmount = json['invoices_amount'];
    image = json['image'];
    authorization = json['authorization'];
    notifications = json['notifications'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['country_id'] = this.countryId;
    data['invoices_count'] = this.invoicesCount;
    data['invoices_amount'] = this.invoicesAmount;
    data['image'] = this.image;
    data['authorization'] = this.authorization;
    data['notifications'] = this.notifications;
    return data;
  }
}

// class User {
//   int id;
//   String name;
//   String email;
//   String phone;
//   String gender;
//   String birthDate;
//   int countryId;
//   int invoicesCount;
//   String invoicesAmount;
//   String image;
//   String authorization;

//   User(
//       {this.id,
//       this.name,
//       this.email,
//       this.phone,
//       this.gender,
//       this.birthDate,
//       this.countryId,
//       this.invoicesCount,
//       this.invoicesAmount,
//       this.image,
//       this.authorization});

//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     gender = json['gender'];
//     birthDate = json['birth_date'];
//     countryId = json['country_id'];
//     invoicesCount = json['invoices_count'];
//     invoicesAmount = json['invoices_amount'];
//     image = json['image'];
//     authorization = json['authorization'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['gender'] = this.gender;
//     data['birth_date'] = this.birthDate;
//     data['country_id'] = this.countryId;
//     data['invoices_count'] = this.invoicesCount;
//     data['invoices_amount'] = this.invoicesAmount;
//     data['image'] = this.image;
//     data['authorization'] = this.authorization;
//     return data;
//   }
// }
