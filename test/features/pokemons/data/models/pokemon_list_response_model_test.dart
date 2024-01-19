import 'package:flutter_test/flutter_test.dart';

import '../../../../test_utils/entity_factory.dart';
import '../../../../test_utils/model_factory.dart';

void main() {
  test('pokemon result model should map correctly', () {
    final model = createPokemonResultModel();
    final expected = createPokemonResult();

    expect(model.toPokemonResult(), expected);
  });
}
