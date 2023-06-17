import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetailsPage extends StatefulWidget {
  final int userId;

  const UserDetailsPage({super.key, required this.userId});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  Map<String, dynamic>? userDetails;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users/${widget.userId}'));
    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        userDetails = jsonData;
      });
    }
  }

  final Uri url = Uri.parse('https://reqres.in/#support-heading');

  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Center(
        child: userDetails == null
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 300,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(userDetails!['data']['avatar']),
                          radius: 50,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${userDetails!['data']['first_name']} ${userDetails!['data']['last_name']}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Email: ${userDetails!['data']['email']}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text.rich(
                          TextSpan(
                              text: 'Support: ',
                              style: const TextStyle(fontSize: 14.0),
                              children: [
                                TextSpan(
                                  text: '${userDetails!['support']['url']}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _launchUrl,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
