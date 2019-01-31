// Copyright (c) 2019, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library hash_compare.builder;

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:hash_compare/hash_compare.dart';
import 'package:analyzer/dart/element/element.dart';

/// Generate hash and compare function for class [c].
String generateHashCompare(ClassElement c) {
  const input = 'input';
  final className = c.name;
  final hashParts = <String>[];
  final compareParts = <String>[];

  // Collect all fields.
  final allFields = <FieldElement>[];
  allFields.addAll(c.allSupertypes.expand((s) => s.element.fields));
  allFields.addAll(c.fields);

  // Convert all class fields into a hash and compare operations.
  for (final field in allFields) {
    // Skip static, const and getter fields.
    final f = field.name;
    if (field.isStatic || field.isConst || field.isSynthetic) {
      continue;
    }

    // Determine hash and compare operation.
    final typeName = field.type.name;
    switch (typeName) {
      case 'List':
      case 'Set':
      case 'Map':
        hashParts.add('hash$typeName($input.$f)');
        compareParts.add('compare$typeName(a.$f, b.$f)');
        break;
      default:
        hashParts.add('$input.$f.hashCode');
        compareParts.add('a.$f == b.$f');
        break;
    }
  }

  return '''
int _hash$className($className input) {
  var hash = 0;
  ${hashParts.map((p) => 'hash = hashAdd(hash, $p);').join()}
  return hashFinish(hash);
}

bool _compare$className($className a, $className b) {
  return identical(a, b) || (${compareParts.join("&&")}); 
}
  ''';
}

class HashCompareGenerator extends GeneratorForAnnotation<HashCompare> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      return generateHashCompare(element);
    } else {
      return '';
    }
  }
}

Builder buildHashCompare(BuilderOptions options) {
  return new SharedPartBuilder([new HashCompareGenerator()], 'hash_compare');
}
