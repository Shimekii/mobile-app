class AirQualityData {
  final int currentAqi;
  final List<int>? forecast;

  AirQualityData({
    required this.currentAqi,
    this.forecast,
  });

  factory AirQualityData.empty() {
    return AirQualityData(currentAqi: 0);
  }
}