
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String usuario;
    String password;

    UserModel({
        this.usuario,
        this.password,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        usuario: json["usuario"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "password": password,
    };
}
