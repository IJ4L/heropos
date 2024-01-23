class Profile {
  int? id;
  String name;
  String alamat;
  String email;
  String phone;
  String img;

  Profile({
    this.id,
    required this.name,
    required this.alamat,
    required this.email,
    required this.phone,
    required this.img,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alamat': alamat,
      'email': email,
      'phone': phone,
      'img': img,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      name: map['name'],
      alamat: map['alamat'],
      email: map['email'],
      phone: map['phone'],
      img: map['img'],
    );
  }
}
