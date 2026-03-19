import 'package:air_check/app/app_viewmodel.dart';
import 'package:air_check/features/onboarding/onboarding_page.dart';
import 'package:air_check/features/onboarding/onboarding_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: _OnboardingBody(),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OnboardingViewModel>();
    final appVm = context.read<AppViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // фон
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // страницы
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: PageView.builder(
              controller: vm.controller,
              itemCount: vm.pages.length,
              onPageChanged: vm.setPage,
              itemBuilder: (context, index) {
                final page = vm.pages[index];

                return OnboardingPage(
                  title: page["title"]!,
                  imagePath: page["image"]!,
                  description: page["description"]!,
                );
              },
            ),
          ),

          // кнопка
          Positioned(
            bottom: 96,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(144, 56),
                ),
                onPressed: () async {
                  if (vm.isLastPage) {
                    appVm.completeOnboarding();
                  } else {
                    vm.nextPage();
                  }
                },
                child: Text(
                  vm.isLastPage ? "Начать" : "Понятно",
                  style: TextStyle(fontSize: 22),
                ),
              ),
            ),
          ),

          // индикаторы
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                vm.pages.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: vm.currentPage == index
                        ? Color(0xFFFF8888)
                        : Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
