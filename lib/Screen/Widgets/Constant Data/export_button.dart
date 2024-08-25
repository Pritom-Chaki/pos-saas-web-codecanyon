import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'constant.dart';

class ExportButton extends StatelessWidget {
  const ExportButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          MdiIcons.contentCopy,
          color: kGreyTextColor,
        ),
        const SizedBox(width: 5.0),
        Icon(MdiIcons.microsoftExcel, color: kGreyTextColor),
        const SizedBox(width: 5.0),
        Icon(MdiIcons.fileDelimited, color: kGreyTextColor),
        const SizedBox(width: 5.0),
        Icon(MdiIcons.filePdfBox, color: kGreyTextColor),
        const SizedBox(width: 5.0),
        const Icon(FeatherIcons.printer, color: kGreyTextColor),
      ],
    );
  }
}

class ExportButton2 extends StatelessWidget {
  const ExportButton2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          MdiIcons.contentCopy,
          color: kTitleColor,
        ),
        const SizedBox(width: 5.0),
        Icon(MdiIcons.microsoftExcel, color: kTitleColor),
        const SizedBox(width: 5.0),
        Icon(MdiIcons.fileDelimited, color: kTitleColor),
        const SizedBox(width: 5.0),
        Icon(MdiIcons.filePdfBox, color: kTitleColor),
        const SizedBox(width: 5.0),
        const Icon(FeatherIcons.printer, color: kTitleColor),
      ],
    );
  }
}
