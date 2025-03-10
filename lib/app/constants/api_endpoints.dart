class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  // static const String baseUrl = "http://10.0.2.2:5000/api/";
  static const String baseUrl = "http://192.168.100.94:5000/api/";

  // ====================== Auth Routes =========================
  static const String login = "user/sign-in";
  static const String register = "user/sign-up";
  static const String getAllUsers = "user/get-all-users";
  static const String uploadImage = "user/uploadImage";
  static const String userProfile = "user/profile";
  static const String updateProfile = "user/profile";

  // ====================== Pet Routes =========================
  static const String getAllPets = "pets";
  static const String getPetsByType = "pets/type";
  static const String getPetById = "pets";

  // ====================== Image URLs =========================
  static const String imageBaseUrl = "http://10.0.2.2:5000/api";

  // ====================== Pet Routes =========================
  static const String createBooking = "bookings";
  static const String getUserBookings = "bookings/user";
  static const String getAllBookings = "bookings";
  static const String updateBookingStatus = "bookings/status";
}
