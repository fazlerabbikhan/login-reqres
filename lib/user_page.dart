import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_model.dart';
import 'user_details_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http
        .get(Uri.parse('https://reqres.in/api/users?page=$currentPage'));
    final jsonData = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        final List<User> fetchedUsers = (jsonData['data'] as List)
            .map((user) => User.fromJson(user))
            .toList();
        users = fetchedUsers;
      });
    }
  }

  void nextPage() {
    setState(() {
      currentPage++;
    });
    fetchUsers();
  }

  void previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
      fetchUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: users.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UserDetailsPage(userId: users[index].id),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(users[index].avatar),
                          radius: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${users[index].firstName} ${users[index].lastName}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          users[index].email,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: previousPage,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.blue,
                ),
              ),
              Text(
                'Page $currentPage',
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              IconButton(
                onPressed: nextPage,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
