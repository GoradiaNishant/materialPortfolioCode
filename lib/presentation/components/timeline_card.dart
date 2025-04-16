import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_portfolio/generated/assets.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import 'package:timelines_plus/timelines_plus.dart';

class ExperienceTimeline extends StatelessWidget {
  final List<ExperienceData> experiences = [
    ExperienceData(
      title: 'Software Engineer',
      company: 'Theta Technolabs Pvt. Ltd.',
      duration: 'May 2024 - Present',
      technologies: [
        'Flutter',
        'Compose',
        'Kotlin Multi Platform',
        'Swift UI',
        'Android (Kotlin)',
        'Android (Java)',
        'React Native',
        'Spring Boot',
      ],
    ),
    ExperienceData(
      title: 'Associate Software Engineer',
      company: 'Drc Systems Pvt. Ltd.',
      duration: 'Jul 2022 - May 2024',
      technologies: [
        'Flutter',
        'Android (Kotlin)',
        'Android (Java)',
        'React Native',
      ],
    ),
    ExperienceData(
      title: 'Software Engineer Intern',
      company: 'Drc Systems Pvt. Ltd.',
      duration: 'Jan 2022 - Jun 2022',
      technologies: [
        'Flutter',
        'Android (Kotlin)',
        'Android (Java)',
        'React Native',
      ],
    ),
    // Add more here
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: experiences.length,
      itemBuilder: (context, index) {
        final exp = experiences[index];
        return TimelineTile(
          nodeAlign: TimelineNodeAlign.start,
          contents: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _ExperienceCard(exp),
          ),
          node: TimelineNode(
            indicator: SvgPicture.asset(
              width: 28,
              height: 28,
              Assets.iconsIcBriefcase,
              colorFilter: ColorFilter.mode(
                colorScheme.inverseSurface,
                BlendMode.srcIn,
              ),
            ),
            startConnector: index != 0 ? SolidLineConnector(color: colorScheme.primary,) : null,
            endConnector:
                index != experiences.length - 1 ? SolidLineConnector(color: colorScheme.primary,) : null,
          ),
        );
      },
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final ExperienceData exp;

  const _ExperienceCard(this.exp);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        bodyTextBold(text:exp.duration,fontSize: 16,color: colorScheme.secondary),
        SizedBox(height: 4),
        bodyTextMedium(text:exp.title,fontSize: 20,color: colorScheme.onSecondaryContainer),
        bodyText(exp.company,color: colorScheme.secondary,fontSize: 18),
        SizedBox(height: 8),
        Expanded(
          child: Wrap(
            spacing: 6,
            runSpacing: 6,
            children:
                exp.technologies
                    .map(
                      (tech) => Chip(
                        padding: EdgeInsets.all(12.w),
                        backgroundColor: colorScheme.inverseSurface,
                        label: bodyText(
                          tech,
                          color: colorScheme.onInverseSurface,
                          fontSize: 16,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}

class ExperienceData {
  final String title;
  final String company;
  final String duration;
  final List<String> technologies;

  ExperienceData({
    required this.title,
    required this.company,
    required this.duration,
    required this.technologies,
  });
}
