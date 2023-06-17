import 'package:flutter/material.dart';
import 'user_page.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';
  bool loginFailed = false;
  String usernameError = '';
  String passwordError = '';
  String loginError = '';

  // Hardcoded username and password
  final String hardcodedUsername = 'admin';
  final String hardcodedPassword = 'password';

  void _login() {
    setState(() {
      usernameError = username.isEmpty ? 'Please enter username.' : '';
      passwordError = password.isEmpty ? 'Please enter password.' : '';
      loginError = '';

      if (username.isNotEmpty && password.isNotEmpty) {
        if (username == hardcodedUsername && password == hardcodedPassword) {
          // Successful login, navigate to the next page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserPage()),
          );
        } else {
          // Failed login
          setState(() {
            loginFailed = true;
            loginError = 'Please enter correct credentials.';
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment(0.0, 1.5)),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image field
                Image.asset(
                  loginFailed
                      ? 'assets/failed_image.png'
                      : 'assets/success_image.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 8),
                // Username field
                SizedBox(
                  width: 250,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      errorText:
                          usernameError.isNotEmpty ? usernameError : null,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Password field
                SizedBox(
                  width: 250,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      errorText:
                          passwordError.isNotEmpty ? passwordError : null,
                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  loginError,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Perform action when "Forgot password?" is tapped
                      print('Forgot password tapped');
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 50),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Login button
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/orsignup_left.png', width: 100),
                    const Text(' Or sign up with '),
                    Image.asset('assets/orsignup_right.png', width: 100),
                  ],
                ),
                // "Or sign up with" and icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        print('Google tapped');
                      },
                      icon: Image.asset(
                        'assets/google.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('Facebook tapped');
                      },
                      icon: Image.asset(
                        'assets/facebook.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        print('Apple tapped');
                      },
                      icon: Image.asset(
                        'assets/apple.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
