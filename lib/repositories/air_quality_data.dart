class AirQualityData {
  final int aqi;

  AirQualityData({
    required this.aqi,
  });

  factory AirQualityData.empty() {
    return AirQualityData(aqi: 0);
  }
}