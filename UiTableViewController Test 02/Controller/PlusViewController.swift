//
//  PlusViewController.swift
//  UiTableViewController Test 02
//
//  Created by D7702_10 on 2018. 6. 25..
//  Copyright © 2018년 lse. All rights reserved.
//

import UIKit

enum Operation: String {
    case Equal = "="
    case Add = "+"
    case Substract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Nil = "Nil"
}
// ViewController 파일에 연산자를 구분할 열거형 Operation 작성한다.

class PlusViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    var runningNumber = "0"
    var leftValue: Double = 0
    var rightValue: Double = 0
    var result: Double = 0
    var currentOperation: Operation = .Nil
    
    //레이블에 숫자를 표시할 runningNumber 변수, 연산 전, 연산 후, 결과 값을 저장할 leftValue, rightValue, result 변수, 현재 연산을 구분하기 위한 Operation 타입의 currentOperation 변수를 정의한다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
     outputLabel.text = runningNumber
       //레이블에 숫자 출력
    }

    func setOutputLabelSize(string: String) {
        let str = string
        if str.count == 7 {
            outputLabel.font = UIFont.systemFont(ofSize: 80)
        } else if str.count == 8 {
            outputLabel.font = UIFont.systemFont(ofSize: 70)
        } else if str.count == 9 {
            outputLabel.font = UIFont.systemFont(ofSize: 60)
        }
    }
    
    func operation(operation: Operation) {
        if currentOperation == .Nil {
            leftValue = Double(runningNumber)!
            runningNumber = "0"
            currentOperation = operation
        } else {
            if runningNumber != "0" {
                rightValue = Double(runningNumber)!
                runningNumber = "0"
                
                if currentOperation == .Add {
                    result = leftValue + rightValue
                } else if currentOperation == .Substract {
                    result = leftValue - rightValue
                } else if currentOperation == .Multiply {
                    result = leftValue * rightValue
                } else if currentOperation == .Divide {
                    result = leftValue / rightValue
                }
                
                let formatted = String(format:"%.2f", result)
                leftValue = Double(formatted)!
                
                setOutputLabelSize(string: formatted)
                outputLabel.text = formatted
            }
            currentOperation = operation
        }
    }
    
    // 다음 연산을 위해 결과 값을 leftValue에 대입한다. 
    
    @IBAction func numberClick(_ sender: UIButton) {
        // 먼저 출력 가능한 숫자의 개수를 8자릿값까지로 제한
        if runningNumber.count <= 8 {
            if (sender.tag == 10) {
                if runningNumber.contains(".") == false {
                    runningNumber += "."
                    
                    //'.' 버튼 터치하였을 경우 소수점(.)이 포함되어 있는지를 runningNumber.contains(".")으로 확인한 후 없을 경우에만 현재 숫자 뒤에 '.'을 추가한다.
                    
                }
            } else {
                if runningNumber == "0" {
                    runningNumber = String(sender.tag)
                } else {
                    runningNumber += String(sender.tag)
                }
            }
            //현재 입력된 값이 없거나 "0" 일 때 '09', '042' 와 같이 출력되는 것을 방지하기 위해서 입력된 값을 runningNumber에 저장하고, 입력된 값이 있을 때는 현재 값 뒤에 이어서 추가한다.
            
            //setOutputLabelSize(string: runningNumber)
            outputLabel.text = runningNumber
        }
    }
    // '0 ~ 9'의 Tag: '0 ~ 9'
    
    @IBAction func operatorClick(_ sender: UIButton) {
        if sender.tag == 11 { // '='
            operation(operation: currentOperation)
        } else if sender.tag == 12 { // '+'
            operation(operation: .Add)
        } else if sender.tag == 13 { // '-'
            operation(operation: .Substract)
        } else if sender.tag == 14 { // '×'
            operation(operation: .Multiply)
        } else if sender.tag == 15 { // '÷'
            operation(operation: .Divide)
        } else if sender.tag == 16 { // 'c'
            runningNumber = "0"
            outputLabel.text = runningNumber
            leftValue = 0
            rightValue = 0
            result = 0
            currentOperation = .Nil
            outputLabel.font = UIFont.systemFont(ofSize: 90)
            
            // 'c' 버튼 클릭시에는 출력값을 초기화하기 위해 변수들을 초기값으로 변경한다.
            
        }
    }
}
