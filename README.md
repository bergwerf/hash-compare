# Hash and compare function generator
This Dart source generator automatically generates hash and compare functions
that you can use in your classes. The generated functions internally use quiver
for hashing and can automatically deal with lists, sets and maps. The naming
convention for the generated functions is `_hashMyClass` and `_compareMyClass`.
Annotate classes with `@hashCompare` to generate these functions.

## Usage
To use this generator, add the following to your `pubspec.yaml`:

```
dev_dependencies:
  hash_compare: any
  build_runner: any
  build_verify: any
```

And add this to `build.yaml`:

```
targets:
  $default:
    builders:
      hash_compare:
        generate_for:
        - lib/**.dart
```

To build use `pub run build_runner build` or similar commands. To make sure the
build is updated when testing, add an `expectBuildClean` assertion to your test
code. When publishing to Pub you need to include generated files. You can ignore
them in your Git repository.
