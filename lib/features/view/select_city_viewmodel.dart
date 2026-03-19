import 'package:flutter/material.dart';

class SelectCityView extends StatefulWidget {
  final bool isSelectingForTracking; // флаг дял переключения выбора городов между 'основным' и 'добавлением дополнительного для отслеживания'

  const SelectCityView({
    super.key,
    this.isSelectingForTracking = false,
  });

  @override
  State<SelectCityView> createState() => _SelectCityViewState();
}

class _SelectCityViewState extends State<SelectCityView> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/onboarding_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 70),

              // поиск
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  // onChanged: search,
                  decoration: InputDecoration(
                    hintText: "Введите название города",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),

              SizedBox(height: 40),

              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 80),
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.23),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}