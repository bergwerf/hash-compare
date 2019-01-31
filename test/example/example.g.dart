// GENERATED CODE - DO NOT MODIFY BY HAND

part of hash_compare.test.example;

// **************************************************************************
// HashCompareGenerator
// **************************************************************************

int _hashPerson(Person input) {
  var hash = 0;
  hash = hashAdd(hash, input.name.hashCode);
  hash = hashAdd(hash, input.age.hashCode);
  return hashFinish(hash);
}

bool _comparePerson(Person a, Person b) {
  return identical(a, b) || (a.name == b.name && a.age == b.age);
}

int _hashEmployer(Employer input) {
  var hash = 0;
  hash = hashAdd(hash, input.name.hashCode);
  hash = hashAdd(hash, input.age.hashCode);
  hash = hashAdd(hash, hashSet(input.empjoyees));
  hash = hashAdd(hash, hashList(input.clients));
  hash = hashAdd(hash, hashMap(input.network));
  hash = hashAdd(hash, input._iq.hashCode);
  return hashFinish(hash);
}

bool _compareEmployer(Employer a, Employer b) {
  return identical(a, b) ||
      (a.name == b.name &&
          a.age == b.age &&
          compareSet(a.empjoyees, b.empjoyees) &&
          compareList(a.clients, b.clients) &&
          compareMap(a.network, b.network) &&
          a._iq == b._iq);
}
