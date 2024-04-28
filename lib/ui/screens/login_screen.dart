import 'package:flutter/material.dart';
import 'package:redmine_tasker/ui/screens/task_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF363636),
          title: const Row(
            children: [
              Icon(Icons.done_all, color: Colors.white,),
              SizedBox(width: 6),
              Text('Redmine', style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'https://',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Login',
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 23),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFFF99A29)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListScreen()),
                  );
                },
                child: const SizedBox(
                  width: 84,
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}