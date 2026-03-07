import 'package:air_check/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  // Список картинок и текстов для страниц
  final List<Map<String, String>> pages = [
    {"title": "Контроль качества воздуха рядом с вами", "image": "assets/images/onboarding_1.png", "description": "Приложение показывает актуальное качество воздуха в вашем районе и помогает вовремя узнавать о загрязнении."},
    {"title": "Данные по вашему местоположению", "image": "assets/images/onboarding_2.png", "description": "Мы используем GPS, чтобы показывать точные показатели воздуха именно там, где вы находитесь."},
    {"title": "Показатели и прогноз", "image": "assets/images/onboarding_3.png", "description": "Следите за AQI, PM2.5, PM10 и другими параметрами, а также смотрите прогноз загрязнения на несколько дней вперёд."},
    {"title": "Уведомления о рисках", "image": "assets/images/onboarding_4.png", "description": "Получайте уведомления при повышенном уровне загрязнения, чтобы заранее принять меры."},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(  
      body: Stack(
        children: [
          // Фоновая картинка на весь экран
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.044),
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => currentPage = index);  
              },
              // Onboarding Pages
              itemBuilder: (context, index) {
                return OnboardingPage(
                  title: pages[index]["title"]!,
                  imagePath: pages[index]["image"]!,
                  description: pages[index]["description"]!,
                );
              },
            ),
          ),
          // Кнопка "Next / Start" внизу
          Positioned(
            bottom: height * 0.12,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(width * 0.4, height * 0.07)
                ),
                onPressed: () {
                  if (currentPage == pages.length - 1) {
                    // Последняя страница → HomeScreen
                    Navigator.pushReplacementNamed(context, "/welcome");
                  } else {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Text(
                  currentPage == pages.length - 1 ? "Начать" : "Понятно",
                  style: TextStyle(
                    fontSize: 22
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.06,
            left: 0,
            right: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (index) => AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                  width: width * 0.035,  
                  height: height * 0.035,
                  decoration: BoxDecoration(
                    color: currentPage == index ? Color(0xFFFF8888): Colors.white,
                    shape: BoxShape.circle,
                  ),
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}