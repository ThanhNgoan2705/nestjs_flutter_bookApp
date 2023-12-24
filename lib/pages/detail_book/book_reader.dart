import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:thu_vien_sach/models/book.model.dart';
import 'package:thu_vien_sach/models/reading.model.dart';
import 'package:thu_vien_sach/pages/library/library_provider.dart';
import 'package:thu_vien_sach/utils/constant.dart';

class BookReaderScreen extends StatefulWidget {
  final Book book;

  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    final reading = context.read<LibraryProvider>().readingBooks.firstWhere(
          (element) => element.bookId == widget.book.id,
          orElse: () => Reading(
            id: '',
            bookId: widget.book.id!,
            userId: '',
            page: 1,
            book: widget.book,
            dateAdded: DateTime.now(),
          ),
        );
    _pdfViewerController.zoomLevel = 1.0;
    _pdfViewerController.jumpToPage(reading.page);
  }

  @override
  Widget build(BuildContext context) {
    final url = Constant.api + widget.book.file!;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title ?? ''),
        actions: [
          IconButton(
            onPressed: () {
              _pdfViewerController.zoomLevel = 1.0;
              _pdfViewerController.jumpToPage(1);
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              _pdfViewerController.zoomLevel = 1.0;
              _pdfViewerController
                  .jumpToPage(_pdfViewerController.pageNumber - 1);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () {
              _pdfViewerController.zoomLevel = 1.0;
              _pdfViewerController
                  .jumpToPage(_pdfViewerController.pageNumber + 1);
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        canShowPaginationDialog: true,
        onPageChanged: (details) {
          context
              .read<LibraryProvider>()
              .updateReading(widget.book, details.newPageNumber);
        },
      ),
    );
  }
}
