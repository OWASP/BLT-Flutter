import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blt/src/models/user_model.dart';

// Define your providers here
final usernameProvider = StateProvider<String?>((ref) => null);
final selectedUserProvider = StateProvider<User?>((ref) => null);
