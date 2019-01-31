// Copyright (c) 2019, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of hash_compare.test.example;

@hashCompare
class Person {
  static const message = 'Hello, World!';

  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  int get hashCode => _hashPerson(this);

  @override
  bool operator ==(other) => other is Person && _comparePerson(other, this);
}
