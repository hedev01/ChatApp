import 'package:chat_app/features/group/domain/repositories/group_repository.dart';

class GroupDeletedUseCase {
   final GroupRepository repository;

   GroupDeletedUseCase(this.repository);

   Stream<String> call() {
     return repository.groupDeleted;
   }
 }