import UIKit
import PlaygroundSupport
import KeyboardHandler_Sources

// MARK: View
class MyViewController: UIViewController {
    override func loadView() {
        /// alleen voor playground
        let view = UIView()
        
        // MARK: logo
        let KeyboardHandlerLOGO = UILabel.init(frame: CGRect.init(x: 20, y: 150, width: 500, height: 300))
        KeyboardHandlerLOGO.text = "KeyboardHandler.init(\n    forViewController: self\n)"
        KeyboardHandlerLOGO.font = UIFont.boldSystemFont(ofSize: 20)
        KeyboardHandlerLOGO.numberOfLines = 3
        view.addSubview(KeyboardHandlerLOGO)
        
        // MARK: Background color
        view.backgroundColor = UIColor(
            red: 0,
            green: 212/255,
            blue: 255/255,
            alpha: 1.0
        )

        // MARK: Label
        let instruct = UILabel.init()
        instruct.frame = CGRect(x: 20, y: 380, width: 100, height: 30)
        instruct.text = "Interact -> "
        view.addSubview(instruct)
        
        // MARK: UITextView
        let textView = UITextView.init()
        textView.frame = CGRect(x: 130, y: 380, width: 200, height: 30)
        view.addSubview(textView)
        
        let endTypingBTN = UIButton.init()
        endTypingBTN.frame = CGRect(x: 130, y: 420, width: 200, height: 30)
        endTypingBTN.addTarget(textView, action: #selector(UIResponder.resignFirstResponder), for: .touchDown)
        endTypingBTN.setTitle("Close keyboard", for: .normal)
        view.addSubview(endTypingBTN)
        
        // Keyboard handler
        KeyboardHandler.init(forViewController: self)

        let lbl = UILabel.init()
        lbl.frame = CGRect(x: 1, y: 450, width: 300, height: 60)
        lbl.text = "* it looks buggy due to the playground. on a real device it works as expected."
        lbl.numberOfLines = 2
        view.addSubview(lbl)
        
        // voor de playground
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
PlaygroundPage.current.needsIndefiniteExecution = true
