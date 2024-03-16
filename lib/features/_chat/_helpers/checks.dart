import '../../../_variables/global_variables.dart';

bool isBeingSent(String id) {
  try {
    return sendingChatsList.contains(id);
  } catch (e) {
    return false;
  }
}
