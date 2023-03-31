import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/server_status_bloc.dart';

class FetchWrapper extends StatelessWidget {
  const FetchWrapper({
    super.key,
    required this.text,
    required this.color,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<ServerStatusBloc, ServerStatusState>(
          builder: (context, state) {
            return InkWell(
              onTap: state.fetchStatus != ServerFetchStatus.loading
                  ? () {
                      context
                          .read<ServerStatusBloc>()
                          .add(ServerStatusFetched());
                    }
                  : null,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  text,
                  style: TextStyle(color: color),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 5)
      ],
    );
  }
}
