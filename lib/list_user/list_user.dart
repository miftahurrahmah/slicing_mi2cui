import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_member.dart';
import 'dart:convert';

class PageListMember extends StatefulWidget {
  const PageListMember({Key? key}) : super(key: key);

  @override
  State<PageListMember> createState() => _PageListMemberState();
}

class _PageListMemberState extends State<PageListMember> {
  late Future<ModelList> futureModelList;

  @override
  void initState() {
    super.initState();
    futureModelList = fetchMembers();
  }

  Future<ModelList> fetchMembers() async {
    final response = await http.get(Uri.parse('http://192.168.1.27/list_member/list_member.php'));

    if (response.statusCode == 200) {
      return ModelList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load members');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member List'),
      ),
      body: FutureBuilder<ModelList>(
        future: futureModelList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load members'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                final member = snapshot.data!.data[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(member.avatar),
                    ),
                    title: Text('${member.firstName} ${member.lastName}'),
                    subtitle: Text(member.email),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberDetailPage(
                              firstName: member.firstName,
                              lastName: member.lastName,
                              email: member.email,
                              avatar: member.avatar,
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No members found'));
          }
        },
      ),
    );
  }
}

class ModelList {
  final bool isSuccess;
  final String message;
  final List<Datum> data;

  ModelList({
    required this.isSuccess,
    required this.message,
    required this.data,
  });

  factory ModelList.fromJson(Map<String, dynamic> json) {
    return ModelList(
      isSuccess: json['isSuccess'],
      message: json['message'],
      data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
