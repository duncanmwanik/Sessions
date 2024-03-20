import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';

final doc = MutableDocument(
  nodes: [
    ParagraphNode(
      id: DocumentEditor.createNodeId(),
      text: AttributedText(text: 'This is a header'),
      metadata: {
        'blockType': header3Attribution,
      },
    ),
    ParagraphNode(
      id: DocumentEditor.createNodeId(),
      text: AttributedText(text: 'This is the first paragraph'),
    ),
  ],
);

class NoteSuperEditor extends StatefulWidget {
  const NoteSuperEditor({super.key});

  @override
  State<NoteSuperEditor> createState() => _NoteSuperEditorState();
}

class _NoteSuperEditorState extends State<NoteSuperEditor> {
// With a MutableDocument, create a DocumentEditor, which knows how
// to apply changes to the MutableDocument.
  final docEditor = DocumentEditor(document: doc);

  @override
  Widget build(BuildContext context) {
    return SuperEditor(editor: docEditor);
  }
}
