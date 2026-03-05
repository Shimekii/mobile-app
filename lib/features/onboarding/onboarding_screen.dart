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
            margin: const EdgeInsets.all(16.0),
          // PageView с фоновыми картинками
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => currentPage = index);
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 100), // отступ сверху
                    // Картинка с реальными размерами
                    Image.asset(
                      pages[index]["image"]!,
                      width: 158,   // ставишь нужную ширину
                      height: 158,  // ставишь нужную высоту
                      fit: BoxFit.contain, // сохраняет пропорции
                    ),
                    SizedBox(height: 20),
                    // Заголовок
                    Text(
                      pages[index]["title"]!,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 32),
                    Text(
                      pages[index]["description"]!,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                );
              },
            ),
          ),
          // Кнопка "Next / Start" внизу
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage == pages.length - 1) {
                    // Последняя страница → HomeScreen
                    Navigator.pushReplacementNamed(context, "/home");
                  } else {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Text(currentPage == pages.length - 1 ? "Начать" : "Понятно"),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (index) => AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  width: 15,  
                  height: 15,
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