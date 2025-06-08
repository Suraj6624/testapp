// lib/api_service.dart
import 'package:dio/dio.dart';

//book appointment start
class ApiService {
  final Dio _dio = Dio();

  Future<void> submitAppointment(Map<String, dynamic> formData) async {
    const String apiUrl =
        'https://your-api-url.com/appointments'; // Replace with your API endpoint

    try {
      Response response = await _dio.post(apiUrl, data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success - you can handle the response if needed
        print('Appointment submitted: ${response.data}');
      } else {
        throw Exception(
          'Failed to submit appointment. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // You can inspect error further if needed
      print('Dio error: ${e.message}');
      throw Exception('Dio error occurred');
    } catch (e) {
      print('Unexpected error: $e');
      throw Exception('Unexpected error occurred');
    }
  }
}

//book appointment end
