// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_course_preview/data/api/auth_api.dart';
import 'package:riverpod_course_preview/data/repositories/auth_repository.dart';

final repositoryProvider = Provider<RepositoryService>((ref) {
  final authRepository = AuthRepository(AuthApi());
  return RepositoryService(authRepository: authRepository);
});

class RepositoryService {
  final AuthRepository authRepository;
  
  RepositoryService({
    required this.authRepository,
  });
  
}
