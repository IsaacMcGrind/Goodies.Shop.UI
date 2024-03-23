import 'package:flutter/material.dart';
import 'package:unamed_yet/models/user_account.dart';
import 'User/admin_page.dart';
import 'services/user_register_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 80.0),
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80.0),
              _buildTextField(
                hintText: 'Username',
                icon: Icons.person,
                obscureText: false,
              ),
              SizedBox(height: 20.0),
              _buildTextField(
                hintText: 'Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              SizedBox(height: 40.0),
              _buildRoundedButton(
                context: context,
                text: 'Login',
                backgroundColor: Colors.blue,
                onPressed: () {
                },
              ),
              SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdminPage()),
                    );
                  },
                  child: Text(
                    'admin?',
                    style: TextStyle(
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              _buildRoundedButton(
                context: context,
                text: 'Register',
                backgroundColor: Colors.grey[300]!,
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required bool obscureText,
  }) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        prefixIcon: Icon(icon),
        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
    );
  }

  Widget _buildRoundedButton({
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 18.0),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        SizedBox(height: 30.0),
        Align(
        alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Login',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        SizedBox(height: 50.0),
        Text(
        'Register',
        style: TextStyle(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
        ),
        SizedBox(height: 80.0),
        _buildTextField(
          controllers: _usernameController,
          hintText: 'Username',
          icon: Icons.person,
          obscureText: false,
        ),
        SizedBox(height: 20.0),
        _buildTextField(
          controllers: _passwordController,
          hintText: 'Password',
          icon: Icons.lock_outline,
          obscureText: true,
        ),
        SizedBox(height: 20.0),
        _buildTextField(
          controllers: _emailController,
          hintText: 'Email Address',
          icon: Icons.email_outlined,
          obscureText: false,
        ),
        SizedBox(height: 40.0),
        _buildRoundedButton(
          context: context,
          text: 'Register',
          backgroundColor: Colors.orangeAccent,
          onPressed: register,
        ),
      ],
    ),
        ),
        ),
    );
  }

  register() async {
    late UserAccount userAccountResponse;
    var userAccount = UserAccount(id: 0, name: _usernameController.text, email: "gmail.com", password: _passwordController.text);
    userAccountResponse = await UserRemoteService().userRegister(userAccount);
    print(userAccountResponse.name);
  }

// The _buildTextField and _buildRoundedButton methods
  Widget _buildTextField({
    required TextEditingController controllers,
    required String hintText,
    required IconData icon,
    required bool obscureText,
  }) {
    return TextField(
      controller: controllers,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        prefixIcon: Icon(icon),
        contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
    );
  }

  Widget _buildRoundedButton({
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    Color textColor = Colors.white,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 18.0),
      ),
    );
  }
}

