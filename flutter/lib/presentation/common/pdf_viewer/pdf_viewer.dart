import 'package:alh_pdf_view/alh_pdf_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/isolate/isolate_builder.dart';
import 'package:flutter_demo/helper/helper.dart';
import 'package:flutter_demo/presentation/common/blank_page/blank_page_widget/blank_page_widget.dart';
import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer_provider.dart';
import 'package:flutter_demo/presentation/common/pdf_viewer/pdf_viewer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfViewer extends ConsumerStatefulWidget {

  final String pdfUrl;
  final bool renderAsChild;
  
  const PdfViewer({
    required this.pdfUrl,
    this.renderAsChild = false,
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

      final isolate = IsolateBuilder();       
      final byteArray = await isolate.compute((message) async {
        return await Helper.getByteArrayFromUrl(message);
      }, widget.pdfUrl);

      // final file = await Helper.getFileFromUrl(widget.pdfUrl);

      ref.read(pdfViewerProvider.notifier).update(
        status: PdfViewerStateStatus.success,
        byteArray: byteArray,
        // filePath: file.path
      );
    });

  }

  @override
  Widget build(BuildContext context) {       

    final state = ref.watch(pdfViewerProvider); 

    return _build(state, context, widget.renderAsChild);

  }

  Widget _build(PdfViewerState state, BuildContext context, bool renderAsChild) {

    Widget widget = Container();

    if(state.status == PdfViewerStateStatus.success) {
      widget = AlhPdfView(          
        // filePath: state.filePath,
        bytes: state.byteArray,
        spacing: 100,
        autoSpacing: true,
        enableDefaultScrollHandle: true,
        enableSwipe: true,
        nightMode: false,
        fitEachPage: false,
        showScrollbar: true,
        swipeHorizontal: false,
        pageFling: false,
        defaultZoomFactor: 1.0,          
        fitPolicy: FitPolicy.width,
        backgroundColor: Theme.of(context).colorScheme.onBackground
      );
    }

    if(renderAsChild) {
      return widget;
    }else {
      return BlankPageWidget(body: widget);
    }
  }

}