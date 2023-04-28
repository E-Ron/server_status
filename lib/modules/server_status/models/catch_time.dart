class CatchTime {
  const CatchTime({
    required this.retrievedAt,
    required this.expiresAt,
  });

  const CatchTime.initial()
      : this(
          expiresAt: 0,
          retrievedAt: 0,
        );

  final int retrievedAt;
  final int expiresAt;
}
