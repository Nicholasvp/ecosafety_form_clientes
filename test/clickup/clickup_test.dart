import 'package:ecosafety_form_clientes/controllers/clickup_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ClickupController clickupController;

  setUpAll(() async {
    await dotenv.load(fileName: ".env");
  });

  setUp(() {
    clickupController = ClickupController();
  });

  test('should create a new task', () async {
    final result = await clickupController.createTask(name: 'Test Task');
    expect(result, isNotNull);
    expect(result.data['name'], equals('Test Task'));
  });

  test('should fetch tasks list', () async {
    final tasks = await clickupController.getTasks();
    expect(tasks, isA<List>());
  });

  test('should fetch custom fields', () async {
    final taskId = '123';
    final customFields = await clickupController.getCustomFields();
    expect(customFields, isA<List>());
  });
}
