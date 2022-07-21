import 'package:flutter/material.dart';

import 'package:podiinyk/core/presentation/open_page.dart';

import '../../domain/entities/entity.dart';


class EntitiesList<E extends Entity> extends StatelessWidget {
	const EntitiesList(
		this.entities, {
			required this.tile,
			this.formBuilder
		});

	final Iterable<E>? entities;
	final Widget Function(E) tile;
	final Widget Function(BuildContext)? formBuilder;

	@override
	Widget build(BuildContext context) {
		if (entities == null) return const Center(child: Icon(Icons.access_time));

		return Scaffold(
			body: ListView(
				padding: EdgeInsets.zero,
				children: [
					for (final entity in entities!) tile(entity)
				]
			),
			floatingActionButton: formBuilder != null ?
				FloatingActionButton(
					onPressed: () => openPage(
						context: context,
						builder: (context) => formBuilder!(context)
					),
					child: const Icon(Icons.add)
				) :
				null
		);
	}
}
