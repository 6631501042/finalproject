class Vehicle {
  Vehicle({
    required this.id,
    required this.model,
    required this.licensePlate,
    this.frontImage,
    this.backImage,
    this.leftImage,
    this.rightImage,
    this.licenceplateImage,
  });

  final String id;

  String model;
  String licensePlate;

  String? frontImage;
  String? backImage;
  String? leftImage;
  String? rightImage;
  String? licenceplateImage;
  bool get isComplete =>
      model.isNotEmpty &&
      licensePlate.isNotEmpty &&
      frontImage != null &&
      backImage != null &&
      leftImage != null &&
      rightImage != null;
}