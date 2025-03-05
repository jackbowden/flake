import 'package:flutter/material.dart';
import 'login_page.dart';
import 'sms_login_page.dart';

class LoginCarouselPage extends StatefulWidget {
  const LoginCarouselPage({Key? key}) : super(key: key);

  @override
  _LoginCarouselPageState createState() => _LoginCarouselPageState();
}

class _LoginCarouselPageState extends State<LoginCarouselPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          LoginPage(),
          SmsLoginPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Email/Password',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'SMS',
          ),
        ],
        currentIndex: _pageController.hasClients ? _pageController.page!.round() : 0,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}
