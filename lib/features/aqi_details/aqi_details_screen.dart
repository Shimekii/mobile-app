import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:air_check/app/app_viewmodel.dart';

class AqiDetailsScreen extends StatelessWidget {
  const AqiDetailsScreen({super.key});

  Color getAqiColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    return Colors.purple;
  }

  String getAqiLabel(int aqi) {
    if (aqi <= 50) return "Хорошо";
    if (aqi <= 100) return "Умеренно";
    if (aqi <= 150) return "Вредно";
    if (aqi <= 200) return "Нездорово";
    return "Опасно";
  }

  String getRecommendation(int aqi) {
    if (aqi <= 50) return "Хорошее качество воздуха. Идеальный день для прогулки!";
    if (aqi <= 100) return "Допустимо. Чувствительным людям стоит быть осторожнее.";
    if (aqi <= 150) return "Сократите длительные прогулки.";
    if (aqi <= 200) return "Лучше ограничить пребывание на улице.";
    return "Опасно! Избегайте выхода на улицу.";
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AppViewModel>(context);
    final city = vm.mainCity;

    if (city == null) {
      return Scaffold(body: Center(child: Text("Нет данных")));
    }

    final aqi = city.aqd.currentAqi;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // кнопка назад
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),

            // заголовок
            Text(
              "Индекс качества воздуха",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            // ПЛАШКА
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // AQI + текст
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$aqi",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: getAqiColor(aqi),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        getAqiLabel(aqi),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 8),

                  Text(
                    getRecommendation(aqi),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 16),

                  // показатели (мок)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _pollutant("20.1", "PM2.5"),
                      _pollutant("11.1", "PM10"),
                      _pollutant("0.1", "SO2"),
                      _pollutant("16.6", "NO2"),
                      _pollutant("8.5", "O3"),
                      _pollutant("0.8", "CO"),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            // текст (скролл)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Сведения о качестве воздуха",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),

                    SizedBox(height: 12),

                    Text(
                      """AQI (Air Quality Index) — это интегральный показатель, который отражает общее состояние атмосферного воздуха.

0–50 — Хороший  
51–100 — Умеренный  
101–150 — Нездоровый для чувствительных групп  
151–200 — Нездоровый  
201+ — Опасный  

PM2.5 — мелкие частицы  
PM10 — пыль  
SO₂ — диоксид серы  
NO₂ — диоксид азота  
O₃ — озон  
CO — угарный газ""",
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _pollutant(String value, String name) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: Colors.white)),
        Text(name, style: TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}
