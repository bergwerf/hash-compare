// Copyright (c) 2019, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:hash_compare/hash_compare.dart';
import 'package:english_words/english_words.dart';
import 'example/example.dart';

// Note: For some reason we cannot use `expectBuildClean` as test here.
void main() {
  test('Employer', () {
    // Generate some persons.
    Person createPerson(int i) => new Person(nouns[i], 20 + i);
    final persons1 = new List.generate(500, createPerson);
    final persons2 = new List.generate(500, createPerson);

    // Generate some employers without clients.
    final employers1 = new List.generate(100, (i) {
      final employees = persons1.sublist(i * 5, (i + 1) * 5).toSet();
      expect(identical(employees, employees.toSet()), isFalse);
      expect(compareSet(employees, employees.toSet()), isTrue);
      return Employer(employees, [], {}, persons1[i].name, persons1[i].age);
    });

    // Generate some employers with clients and a network.
    final employers2 = new List.generate(10, (i) {
      final persons = employers1[i].empjoyees.toList();
      final clients = employers1.sublist(i * 10, (i + 1) * 10);
      final network = new Map.fromEntries(List.generate(
          clients.length, (i) => new MapEntry(persons[i ~/ 2], clients[i])));

      expect(compareMap(network, new Map.of(network)), isTrue);
      return Employer(employers1[i].empjoyees, clients, network,
          persons1[i].name, persons1[i].age);
    });

    // Test comparison and hash functions. We expect that all hash codes are
    // unique (this should be reasonable for the fairly small input).
    final employers = [employers1, employers2].expand((l) => l).toList();
    final allHashCodes = new Set<int>();

    for (var i = 0; i < persons1.length; i++) {
      expect(allHashCodes.add(persons1[i].hashCode), isTrue);
      expect(persons1[i] == persons2[i], isTrue);
      expect(persons1.where((p) => p != persons1[i]).length,
          equals(persons1.length - 1));
    }

    for (var i = 0; i < employers.length; i++) {
      expect(allHashCodes.add(employers[i].hashCode), isTrue);
      expect(employers.where((e) => e != employers[i]).length,
          equals(employers.length - 1));
    }
  });
}
