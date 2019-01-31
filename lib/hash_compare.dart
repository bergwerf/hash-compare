// Copyright (c) 2019, Herman Bergwerf. All rights reserved.
// Use of this source code is governed by a MIT-style license
// that can be found in the LICENSE file.

library hash_compare;

class HashCompare {
  const HashCompare();
}

/// Annotate classes with this class to generate hash and compare functions.
const hashCompare = const HashCompare();

/// Compute hash code for [input] list.
int hashList(List input) {
  if (input == null) {
    return null.hashCode;
  } else {
    final hashes = input.map((v) => v.hashCode).toList();
    return _hashList(hashes);
  }
}

/// Compute hash code for [input] set.
int hashSet(Set input) {
  if (input == null) {
    return null.hashCode;
  } else {
    final hashes = input.map((v) => v.hashCode).toList();
    hashes.sort();
    return _hashList(hashes);
  }
}

/// Compute hash code for [input] map.
int hashMap(Map input) {
  if (input == null) {
    return null.hashCode;
  } else {
    final hashes = input.entries.map((e) => _hash2(e.key, e.value)).toList();
    hashes.sort();
    return _hashList(hashes);
  }
}

/// Compare list [a] and [b].
bool compareList(List a, List b) {
  if (identical(a, b)) {
    return true;
  } else if (a == null || b == null || a.length != b.length) {
    return false;
  }

  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}

/// Compare set [a] and [b].
bool compareSet(Set a, Set b) {
  if (identical(a, b)) {
    return true;
  } else if (a == null || b == null || a.length != b.length) {
    return false;
  }

  return a.containsAll(b);
}

/// Compare map [a] and [b].
bool compareMap<K, V>(Map<K, V> a, Map<K, V> b) {
  if (identical(a, b)) {
    return true;
  } else if (a == null || b == null || a.length != b.length) {
    return false;
  }

  for (final e in a.entries) {
    if (!b.containsKey(e.key) || b[e.key] != e.value) {
      return false;
    }
  }
  return true;
}

/// Add new [value] to [hash] code.
int hashAdd(int hash, int value) {
  // ignore: parameter_assignments
  hash = 0x1fffffff & (hash + value);
  // ignore: parameter_assignments
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

/// Finish [hash].
int hashFinish(int hash) {
  // ignore: parameter_assignments
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  // ignore: parameter_assignments
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

/// Hash objects [a] and [b].
int _hash2(Object a, Object b) {
  var hash = 0;
  hash = hashAdd(hash, a.hashCode);
  hash = hashAdd(hash, b.hashCode);
  return hashFinish(hash);
}

/// Combine [values] into one hash code.
int _hashList(List<int> values) {
  var hash = 0;
  for (var i = 0; i < values.length; i++) {
    hash = hashAdd(hash, values[i]);
  }
  return hashFinish(hash);
}
