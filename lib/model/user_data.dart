class UserData {
  int id;
  String username;
  String email;


  UserData(
      {this.id,
        this.username
      });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username']??"";
    email = check(json['email']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }

  String check(String data){
    if(data == ""|| data == null){
      return "Not Available";
    }
    return data;
  }
}