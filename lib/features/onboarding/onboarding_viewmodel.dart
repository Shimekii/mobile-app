import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController controller = PageController();

  int currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Контроль качества воздуха рядом с вами",
      "image": "assets/images/onboarding_1.png",
      "description": "Приложение показывает актуальное качество воздуха в вашем районе и помогает вовремя узнавать о загрязнении."
    },
    {
      "title": "Данные по вашему местоположению",
      "image": "assets/images/onboarding_2.png",
      "description": "Мы используем GPS, чтобы показывать точные показатели воздуха именно там, где вы находитесь."
    },
    {
      "title": "Показатели и прогноз",
      "image": "assets/images/onboarding_3.png",
      "description": "Следите за AQI, PM2.5, PM10 и другими параметрами, а также смотрите прогноз загрязнения на несколько дней вперёд."
    },
    {
      "title": "Уведомления о рисках",
      "image": "assets/images/onboarding_4.png",
      "description": "Получайте уведомления при повышенном уровне загрязнения, чтобы заранее принять меры."
    },
  ];
  void setPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  bool get isLastPage => currentPage == pages.length - 1;

  void nextPage() {
    controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }
}
