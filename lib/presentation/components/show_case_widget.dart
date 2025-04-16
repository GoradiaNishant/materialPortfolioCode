import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_portfolio/base/constants.dart';
import 'package:material_portfolio/generated/assets.dart';
import 'package:material_portfolio/utils/text_utils/body_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowCaseWidget extends StatelessWidget {
  final ProjectData data;
  final ColorScheme colorScheme;

  const ShowCaseWidget({
    super.key,
    required this.data,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        );
      },
    );
  }

  Widget _buildTags(List<String> tags) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children:
          tags.map((tag) {
            return Chip(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6),
              backgroundColor: colorScheme.onPrimaryContainer,
              label: bodyText(
                tag,
                color: colorScheme.primaryContainer,
                fontSize: 16,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildMobileLayout() {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.technology != null) _buildTags(data.technology!),
          const SizedBox(height: 12),
          if (data.title != null)
            Text(
              data.title!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 8),
          if (data.description != null) Text(data.description!),
          const SizedBox(height: 8),
          if (data.role != null || data.teamSize != null)
            Text(
              "Role: ${data.role ?? "N/A"} | Team Size: ${data.teamSize ?? "N/A"}",
            ),
          const SizedBox(height: 8),
          if (data.tools != null)
            Text("Tools: ${data.tools?.join(", ") ?? "N/A"}"),
          const SizedBox(height: 8),
          getStoreButtons(data.appStoreLinks),
          const SizedBox(height: 16),
          if (data.assetsList != null) _buildImageCarousel(data.assetsList!),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        // Left: Text Content
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (data.technology != null) _buildTags(data.technology!),
              const SizedBox(height: 12),
              if (data.title != null)
                Text(
                  data.title!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 8),
              if (data.description != null) Text(data.description!),
              const SizedBox(height: 8),
              if (data.role != null || data.teamSize != null)
                Text(
                  "Role: ${data.role ?? "N/A"} | Team Size: ${data.teamSize ?? "N/A"}",
                ),
              const SizedBox(height: 8),
              if (data.tools != null)
                Text("Tools: ${data.tools?.join(", ") ?? "N/A"}"),
              const SizedBox(height: 8),
              getStoreButtons(data.appStoreLinks),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Right: Carousel
        if (data.assetsList != null && data.assetsList?.isNotEmpty == true)
          Expanded(flex: 2, child: _buildImageCarousel(data.assetsList!)),
      ],
    );
  }

  Widget _buildImageCarousel(List<String> images) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            images.map((img) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    img,
                    height: 160,
                  ), // You can also use Image.network if needed
                ),
              );
            }).toList(),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  Widget getStoreButtons(String? links) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        if (data.appStoreLinks != null)
          InkWell(
            onTap: () {
              _launchUrl(data.appStoreLinks ?? "");
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(Assets.imagesGetAppStore),
              ),
            ),
          ),

        SizedBox(width: 8),

        if (data.playStoreLinks != null)
          InkWell(
            onTap: () {
              _launchUrl(data.playStoreLinks ?? "");
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(Assets.imagesPlaystoreBtn),
              ),
            ),
          ),
      ],
    );
  }
}
