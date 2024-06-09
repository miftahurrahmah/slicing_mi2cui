import 'package:flutter/material.dart';

class MemberDetailPage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;

  MemberDetailPage({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(avatar),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              '$firstName $lastName',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
