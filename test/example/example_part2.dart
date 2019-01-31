// Copyright (c) 2019, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

part of hash_compare.test.example;

@hashCompare
class Employer extends Person {
  final Set<Person> empjoyees;
  final List<Employer> clients;
  final Map<Person, Employer> network;
  num _iq = 0;

  Employer(this.empjoyees, this.clients, this.network, String name, int age)
      : super(name, age);

  num get iq => _iq * 2;
  set iq(num v) => _iq = v / 2;

  String shout() => Person.message.toUpperCase();

  @override
  int get hashCode => _hashEmployer(this);

  @override
  bool operator ==(other) => other is Employer && _compareEmployer(this, other);
}
