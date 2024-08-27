import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../login/login.dart';
import '../values/my_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      image: 'assets/ob_icon_1.png',
      title: 'Quality',
      description: 'Sell your farm fresh products directly to \nconsumers, cutting out the middleman and \nreducing emissions of the global supply chain.',
      backgroundColor: MyColors.customGreen, // Set the background color
    ),
    OnboardingPage(
      image: 'assets/ob_icon_2.png',
      title: 'Convenient',
      description: 'Our team of delivery drivers will make sure \nyour orders are picked up on time and \npromptly delivered to your customers.',
      backgroundColor: MyColors.customRed, // Set the background color
    ),
    OnboardingPage(
      image: 'assets/ob_icon_3.png',
      title: 'Local',
      description: 'We love the Earth and know you do too! Join us \nin reducing our local carbon footprint one order \nat a time.',
      backgroundColor: MyColors.customOrange, // Set the background color
    ),
  ];
  void _onHorizontalDrag(DragUpdateDetails details) {
    if (details.primaryDelta! > 0) {
      // Swiping right
      if (_currentPage > 0) {
        _pageController.previousPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    } else if (details.primaryDelta! < 0) {
      // Swiping left
      if (_currentPage < onboardingPages.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: onboardingPages[_currentPage].backgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onHorizontalDragUpdate: _onHorizontalDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    return _buildOnboardingPageUp(onboardingPages[index]);
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                ),
              ),
              _buildOnboardingPageDown(onboardingPages[_currentPage]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPageDown(OnboardingPage page) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50.0), // Adjust as needed
        topRight: Radius.circular(50.0), // Adjust as needed
      ),
      child: Container(
        color: Colors.white, // Apply the background color here
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24,),
              Text(
                page.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 34,),
              Text(
                page.description,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16,),
              DotsIndicator(
                dotsCount: onboardingPages.length,
                position: _currentPage,
                decorator: DotsDecorator(
                  color: Colors.black,
                  activeColor: Colors.black,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
              const SizedBox(height: 24,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 80.0),
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: page.backgroundColor, // Set the background color
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Join the movement!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
             // const SizedBox(height: 6,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline, // Adds underline
                    ),
                  )),
            /*  Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    color: Colors.transparent, // Ensures the container is tappable
                    child: RichText(
                      text: TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.black, // Adjust color as needed
                          fontSize: 14, // Adjust font size as needed
                          decoration: TextDecoration.underline, // Adds underline
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/

              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildOnboardingPageUp(OnboardingPage page) {
    return Container(
      color: page.backgroundColor, // Apply the background color here
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(page.image, fit: BoxFit.cover,height: 380,),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;
  final Color backgroundColor; // Add this line

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.backgroundColor, // Add this line
  });
}



