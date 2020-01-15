import UIKit

public class HAStringPickerView: UIPickerView {

    private(set) var items: [String]
    private var itemSelected: ((String) -> Void)
    private var textField: UITextField?

    init(frame: CGRect? = nil,
         items: [String],
         selectedItemIndex: Int = 0,
         textField: UITextField? = nil,
         itemSelected: @escaping (String) -> Void) {
        self.items = items
        self.itemSelected = itemSelected
        self.textField = textField
        super.init(frame: frame ?? .zero)
        self.delegate = self
        self.dataSource = self
        self.textField?.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectRow(selectedItemIndex, inComponent: 0, animated: false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HAStringPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
}

extension HAStringPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = items[row]
        textField?.text = item
        itemSelected(item)
    }
}

extension HAStringPickerView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let selectedRow = self.selectedRow(inComponent: 0)
        let item = self.items[selectedRow]
        textField.text = item
        self.itemSelected(item)
    }
}
