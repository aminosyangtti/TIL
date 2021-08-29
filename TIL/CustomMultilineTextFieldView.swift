//
//  CustomMultilineTextFieldView.swift
//  CustomMultilineTextFieldView
//
//  Created by Vincio on 8/22/21.
//

import SwiftUI




struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?
    @State private var viewHeight: CGFloat = 40 //start with one line
    @State private var shouldShowPlaceholder = false
    @Binding private var text: String
    @Binding var nextResponder : Bool?
    @Binding var isResponder : Bool?
    var isSecured : Bool = false
    var keyboard : UIKeyboardType
    
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.shouldShowPlaceholder = $0.isEmpty
        }
    }

    var body: some View {
        UITextViewWrapper(nextResponder: $nextResponder, isResponder: $isResponder, text: self.internalText, calculatedHeight: $viewHeight, isSecured: isSecured, keyboard: keyboard, onDone: onCommit)
            .frame(minHeight: viewHeight, maxHeight: viewHeight)
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if shouldShowPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }

    init (shouldShowPlaceholder: State<Bool> ,_ placeholder: String = "", nextResponder: Binding<Bool?>, isResponder: Binding<Bool?>, keyboard: UIKeyboardType, text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._shouldShowPlaceholder = shouldShowPlaceholder
        self.keyboard = keyboard
        self._isResponder = isResponder
        self._nextResponder = nextResponder
    }

}


private struct UITextViewWrapper: UIViewRepresentable {

    typealias UIViewType = UITextView

    @Binding var nextResponder : Bool?
    @Binding var isResponder : Bool?
    @Binding var text: String
    @Binding var calculatedHeight: CGFloat

    var isSecured : Bool = false
    var keyboard : UIKeyboardType

    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator
        textField.isSecureTextEntry = isSecured
        textField.autocorrectionType = .no
        textField.keyboardType = keyboard

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder && isResponder ?? false  {
            uiView.becomeFirstResponder()
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    private static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // call in next render cycle.
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, nextResponder: $nextResponder, isResponder: $isResponder, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        @Binding var nextResponder : Bool?
        @Binding var isResponder : Bool?

        init(text: Binding<String>, height: Binding<CGFloat>, nextResponder : Binding<Bool?> , isResponder : Binding<Bool?>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
            _isResponder = isResponder
            _nextResponder = nextResponder
        }

        func textViewDidChangeSelection(_ textView: UITextView) {
            text.wrappedValue = textView.text ?? ""
          }
        func textViewDidBeginEditing(_ textView: UITextView) {
         DispatchQueue.main.async {
             self.isResponder = true
         }
      }
        func textViewDidEndEditing(_ textView: UITextView) {
         DispatchQueue.main.async {
             self.isResponder = false
             if self.nextResponder != nil {
                 self.nextResponder = true
             }
         }
      }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }

}
