class ProfileModel {
  String? name, phone, email, uid;

  ProfileModel({this.name, this.phone, this.email, this.uid});

  factory ProfileModel.mapToModel(Map m1) {
    return ProfileModel(
      email: m1['email'],
      name: m1['name'],
      phone: m1['phone'],
      uid: m1['uid'],
    );
  }
  Map<String, dynamic> modelToMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
