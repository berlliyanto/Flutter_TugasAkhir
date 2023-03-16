// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class loginRequestModel{
  late String? username, password;

  loginRequestModel({this.username, this.password});

  loginRequestModel.fromJSON(Map<String, dynamic> json){
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
		data['username'] = username;
		data['password'] = password;
		return data;
  }
}

