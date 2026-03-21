class AirQualityData {
  final int currentAqi;
  final List<int>? forecast;

  final double? pm25;
  final double? pm10;
  final double? so2;
  final double? no2;
  final double? o3;
  final double? co;

  AirQualityData({
    required this.currentAqi,
    this.forecast,
    this.pm25,
    this.pm10,
    this.so2,
    this.no2,
    this.o3,
    this.co,
  });

  factory AirQualityData.empty() {
    return AirQualityData(
      currentAqi: 0,
      forecast: [],
      pm25: null,
      pm10: null,
      so2: null,
      no2: null,
      o3: null,
      co: null,
    );
  }
}
