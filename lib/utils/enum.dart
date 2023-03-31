String enumToString<T extends Enum>(T enumValue) {
  return enumValue.toString().split('.')[1];
}

T? enumFromString<T extends Enum>(String? string, List<T> enumValues) {
  for (T value in enumValues) {
    if (enumToString(value) == string) {
      return value;
    }
  }
  return null;
}
