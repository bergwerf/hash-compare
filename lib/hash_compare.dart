// Copyright (c) 2019, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library hash_compare;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';

/// Returns all [TopLevelVariableElement] members in [reader]'s library that
/// have a type of [num].
Iterable<TopLevelVariableElement> topLevelNumVariables(LibraryReader reader) =>
    reader.allElements.whereType<TopLevelVariableElement>().where((element) =>
        element.type
            .isAssignableTo(reader.element.context.typeProvider.numType));

class HashCompareGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final topLevelVarCount = topLevelNumVariables(library).length;

    return '''
// Source library: ${library.element.source.uri}
const topLevelNumVarCount = $topLevelVarCount;
''';
  }
}

Builder buildHashCompare(BuilderOptions options) {
  return new SharedPartBuilder([HashCompareGenerator()], 'hash_compare');
}
