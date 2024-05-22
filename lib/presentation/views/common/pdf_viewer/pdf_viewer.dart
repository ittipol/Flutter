import 'package:alh_pdf_view/alh_pdf_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/presentation/views/common/blank_page_widget.dart';
import 'package:flutter_demo/utils/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfViewer extends ConsumerStatefulWidget {

  final String pdfUrl;
  
  const PdfViewer({
    required this.pdfUrl,
    super.key
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PdfViewer();
}

class _PdfViewer  extends ConsumerState<PdfViewer> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {                
      final file = await compute((message) async {
        return await Utils.getFileFromUrl(widget.pdfUrl);
      },widget.pdfUrl);
    });

  }

  @override
  Widget build(BuildContext context) {    

    return const BlankPageWidget(
      body: AlhPdfView(
        filePath: "",
      ),
    );

  }

}