import 'package:flutter/material.dart';

import '../../section.dart';


class SeparateSection extends HomeSection {
	const SeparateSection();

	@override
	final String name = "separate";
	@override
	final IconData icon = Icons.bubble_chart;
	@override
	final IconData inactiveIcon = Icons.bubble_chart_outlined;
}