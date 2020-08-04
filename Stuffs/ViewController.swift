//
//  ViewController.swift
//  Stuffs
//
//  Created by Cameron Krischel on 2/29/20.
//  Copyright © 2020 Cameron Krischel. All rights reserved.
//

import UIKit
var screenSize = UIScreen.main.bounds
var screenWidth = CGFloat(0)
var screenHeight = CGFloat(0)
var edgeWidth = CGFloat(0)
var height = CGFloat(0)
var topBarHeight = CGFloat(0)
var botBarHeight = CGFloat(0)
var imagePadding = CGFloat(0)

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var mainMenuButtonNames = ["Inbox", "Today", "Next", "Scheduled", "Someday", "Projects", "Areas", "Areas", "Areas", "Logbook"]
    var mainMenuButtonIcons = ["Inbox", "Today", "Next", "Scheduled", "Someday", "Projects", "Areas", "Areas", "Areas", "Logbook"]
    var mainMenuChunks = [1, 4, 1, 3, 1]
    var mainMenuFunctions = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    var mainMenuButtons = [UIButton()]

    var todayTodos = ["First thing", "second ting", "wawaaawa"]
    var todayTodoButtons = [UIButton]()
    var todayTodosChecked = [0, 0, 0]
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            todayTodos.remove(at: indexPath.row)
            todayTodosChecked.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        let totalRows = tableView.numberOfRows(inSection: 0)
        for row in 0..<totalRows
        {
            if(todayTodosChecked[row] == 1)
            {
                tableView.deselectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false)
                tableView.selectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            }
        }
        
    }
//    func tableView(_ tableView: UITableView,
//                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    {
//        let modifyAction = UIContextualAction(style: .normal, title:  "Update", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
//            print("Update action ...")
//            success(true)
//        })
//        modifyAction.image = UIImage(named: "hammer")
//        modifyAction.backgroundColor = .blue
////        let totalRows = tableView.numberOfRows(inSection: 0)
////        for row in 0..<totalRows
////        {
////            if(todayTodosChecked[row] == 1)
////            {
////                tableView.selectRow(at: NSIndexPath(row: row, section: 0) as IndexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
////            }
////        }
//
//        return UISwipeActionsConfiguration(actions: [modifyAction])
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todayTodos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = self.todayTodos[indexPath.row]
        var tempView = UIImageView()
        let cellHeight = cell.frame.height
        var height = cellHeight*0.4
        tempView.frame = CGRect(x:  cell.frame.height / 2 - height / 2, y:  cell.frame.height / 2 - height / 2, width: height, height:  height)
        tempView.image = UIImage(named: "yellowCheckBox")
        if(todayTodosChecked[indexPath.row] == 0)
        {
            print("yellow")
            tempView.image = UIImage(named: "yellowCheckBox")
        }
        else
        {
            print("gray")
            tempView.image = UIImage(named: "grayCheckBox")
            cell.isSelected = true
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
//            self.tableView(tableView, didSelectRowAt: indexPath)
        }
        cell.addSubview(tempView)
        cell.separatorInset = UIEdgeInsets.zero
        cell.indentationLevel = 4//Int(cellHeight)
        let bgColorView = UIView()
        bgColorView.backgroundColor = myCheckGray
        cell.selectedBackgroundView = bgColorView

        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("User selected table row \(indexPath.row) and item \(todayTodos[indexPath.row])")
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            for view in cell.imageView!.subviews
            {
                view.removeFromSuperview()
            }
            let tempView = UIImageView()
            let cellHeight = cell.frame.height
            var height = cellHeight*0.4
            tempView.frame = CGRect(x:  cell.frame.height / 2 - height / 2, y:  cell.frame.height / 2 - height / 2, width: height, height:  height)
            tempView.image = UIImage(named: "yellowCheckBox")
            cell.addSubview(tempView)
            todayTodosChecked[indexPath.row] = 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath)
        {
            for view in cell.imageView!.subviews
            {
                view.removeFromSuperview()
            }
            
            let tempView = UIImageView()
            tempView.frame = CGRect(x:  cell.frame.height / 4, y:  cell.frame.height / 4, width: cell.frame.height / 2, height:  cell.frame.height / 2)
            tempView.image = UIImage(named: "grayCheckBox")
            cell.addSubview(tempView)
            todayTodosChecked[indexPath.row] = 1
            
            UIView.animate(withDuration: 0.1, animations:
            {
                tempView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }) { (finished) in
                UIView.animate(withDuration: 0.1, animations:
                {
                    tempView.transform = CGAffineTransform.identity
                })
            }
            tempView.frame = CGRect(x:  cell.frame.height / 4, y:  cell.frame.height / 4, width: cell.frame.height / 2, height:  cell.frame.height / 2)
        }
    }
    
    var mainView = UIView()
        var scrollViewButtons = UIScrollView()
    
    var rightView = UIView()
        var scrollViewToday = UITableView()
        var backToLists = UIButton()
        var editToday = UIButton()
    
    var underView = UIView()
        var underTitle = UIButton()
        var underNotes = UIButton()
        var underTags = UIButton()
        var underDueDate = UIButton()
        var underCreateIn = UIButton()
    
    var topBarColor = UIColor(red: 107.0/255.0, green: 137.0/255.0, blue: 179.0/255.0, alpha: 1.0)
    var myLightGray = UIColor(red: 229.0/255.0, green: 229.0/255.0, blue: 229.0/255.0, alpha: 1.0)
    var myCheckGray = UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    var myTextGray  = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    var myEdgeGray  = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
    var myDarkGray  = UIColor(red: 194.0/255.0, green: 194.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    var myWhite     = UIColor(red: 252.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1.0)
    var botWhite    = UIColor(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
    var myYellow    = UIColor(red: 255.0/255.0, green: 226.0/255.0, blue: 17.0/255.0,  alpha: 1.0)
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        imagePadding = screenWidth*1.5/16
        edgeWidth = 2.0/2208.0*screenHeight
        height = 135/2208*screenHeight
        topBarHeight = screenHeight*192/2208
        botBarHeight = screenHeight*192/2208*2/3
        setUpViews()
        
        // Do any additional setup after loading the view.
        // Draw Main Menu
    }
    func setUpViews()   // Trying out using views to make moving things together easier (moving a plateful of food rather than moving each individual item from one plate to another)
    {
        // Main view
        mainView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        mainView.backgroundColor = myLightGray
        mainView.layer.borderWidth = 2.0
        mainView.layer.borderColor = UIColor.blue.cgColor
        self.view.addSubview(mainView)
        mainView.layer.zPosition = -2
        
        addTopBar(myView: mainView, barText: "Lists", topLeftFunction: #selector(doNothing), topLeftName: "", topRightFunction: #selector(doNothing), topRightName: "")
        addBotBar(myView: self.view, images: ["bluePlus"], positions: [0], action: #selector(plusTodo))
        
        // Scrollview
        scrollViewButtons = UIScrollView(frame: CGRect(x: 0, y: topBarHeight, width: screenWidth, height: screenHeight - topBarHeight - botBarHeight))
        scrollViewButtons.backgroundColor = myLightGray
        scrollViewButtons.contentSize = CGSize(width: screenWidth, height: screenHeight)
        scrollViewButtons.contentOffset = CGPoint(x: 0, y: topBarHeight)
        mainView.addSubview(scrollViewButtons)
        
        // Add buttons
        var chunkPlace = 0
        var yPos = CGFloat(0)
        
        for k in 0...mainMenuChunks.count - 1
        {
            for i in 0...mainMenuChunks[k] - 1
            {
                if(chunkPlace == 0)
                {
                    yPos += screenHeight*108/2208*0.6   // Initial gap above inbox
                    yPos += topBarHeight
                }
                else
                {
                    yPos = mainMenuButtons.last!.frame.maxY
                    yPos -= 2.0/2208.0*screenHeight
                    if(i == 0 && k != 0)
                    {
                        yPos += screenHeight*108/2208  // Add Gap
                    }
                }
                let button = UIButton(frame: CGRect(x: 0, y: yPos, width: screenWidth, height: height))
                button.backgroundColor = myWhite
                button.layer.borderColor = myEdgeGray.cgColor
                button.layer.borderWidth = edgeWidth
                button.setImage(UIImage(named: mainMenuButtonIcons[chunkPlace]), for: .normal)
                button.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
                var rightArrow = UIImageView()
                rightArrow.layer.zPosition = 2
                var arrowHeight = button.frame.height/4*1.5
                rightArrow.frame = CGRect(x: button.frame.width*7/8, y: button.frame.height/2 - arrowHeight/2, width: button.frame.width/8, height: arrowHeight)
                rightArrow.image = UIImage(named: ">")
                rightArrow.contentMode = UIView.ContentMode.scaleAspectFit
                button.addSubview(rightArrow)
                
                button.setTitle(mainMenuButtonNames[chunkPlace], for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.contentHorizontalAlignment = .left
                
                button.tag = mainMenuFunctions[chunkPlace]
                button.addTarget(self, action: #selector(goToSwitch), for: .touchDown)
                button.adjustsImageWhenHighlighted = false
                button.moveImageLeftTextCenter()
                
                scrollViewButtons.addSubview(button)
                mainMenuButtons.append(button)
                chunkPlace += 1
            }
        }
        
        // Right View
        rightView = UIView(frame: CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight - botBarHeight))
        rightView.backgroundColor = myLightGray
        rightView.layer.zPosition = -1
        rightView.layer.borderWidth = 2.0
        rightView.layer.borderColor = UIColor.green.cgColor
        self.view.addSubview(rightView)
        
        // Today Scrollview
        scrollViewToday = UITableView(frame: CGRect(x: 0, y: topBarHeight, width: screenWidth, height: screenHeight - topBarHeight - botBarHeight))
        scrollViewToday.backgroundColor = myLightGray
        scrollViewToday.contentSize = CGSize(width: screenWidth, height: screenHeight - topBarHeight - botBarHeight)  // Add one to allow scrolling even if screen isn't filled with todos
        scrollViewToday.contentOffset = CGPoint(x: 0, y: 0)
        rightView.addSubview(scrollViewToday)
        scrollViewToday.dataSource = self
        scrollViewToday.delegate = self
        scrollViewToday.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        scrollViewToday.allowsMultipleSelection = true
        scrollViewToday.allowsSelectionDuringEditing = true
        scrollViewToday.clearsSelectionOnViewWillAppear = false

        scrollViewToday.layoutMargins = UIEdgeInsets(top: 0, left: screenWidth/8, bottom: 0, right: 0)
        
        yPos = 0//topBar.frame.height
        updateTodos()
        
        addTopBar(myView: rightView, barText: "Today", topLeftFunction: #selector(goToLists), topLeftName: "Lists", topRightFunction: #selector(editTodo), topRightName: "Edit")
        
        // New To-Do Screen at bottom
        underView = UIView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight))
        underView.backgroundColor = myLightGray
        underView.layer.zPosition = 0
        underView.layer.borderWidth = 2.0
        underView.layer.borderColor = UIColor.red.cgColor
        self.view.addSubview(underView)
        
        addTopBar(myView: underView, barText: "New To-Do", topLeftFunction: #selector(cancelTodo), topLeftName: "Cancel", topRightFunction: #selector(saveTodo), topRightName: "Save")
        
//        var underTitle = UIButton()
//        var underNotes = UIButton()
//        var underTags = UIButton()
//        var underDueDate = UIButton()
//        var underCreateIn = UIButton()
    }
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
//    }
    @objc func updateTodos()
    {
        if(todayTodoButtons.count > 0)
        {
            for i in 0...todayTodoButtons.count - 1
            {
                todayTodoButtons[i].removeFromSuperview()
            }
        }
        todayTodoButtons.removeAll()
        var yPos = CGFloat(0)
        for i in 0...todayTodos.count - 1
        {
            let button = UIButton(frame: CGRect(x: 0, y: yPos, width: screenWidth, height: height))
            button.backgroundColor = myWhite
            button.layer.borderColor = myEdgeGray.cgColor
            if (i != 0)
            {
                button.layer.borderWidth = edgeWidth
            }
//            button.setImage(UIImage(named: "yellowCheckBox"), for: .normal)
            button.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
           
            button.setTitle(todayTodos[i], for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.contentHorizontalAlignment = .left
            button.tag = 0
            button.addTarget(self, action: #selector(toggleTodo), for: .touchDown)
            button.adjustsImageWhenHighlighted = false
            button.moveImageLeftTextCenter()
            //scrollViewToday.addSubview(button)
            
            
            
            todayTodoButtons.append(button)
            yPos += button.frame.height
            yPos -= button.layer.borderWidth
            if(todayTodosChecked.count > 0)
            {
                print("greater than 0")
                if(todayTodosChecked[i] == 1)
                {
                    print("toggling")
                    toggleTodo(sender: button)
                    button.tag = 1
                }
            }
        }
    }
    @objc func doNothing()
    {
        // Does nothing
    }
    @objc func addBotBar(myView: UIView, images: [String], positions: [Int], action: Selector)
    {
        let botBar = UILabel(frame: CGRect(x: 0, y: screenHeight - botBarHeight, width: screenWidth, height: screenHeight*192/2208*2/3))
        botBar.backgroundColor = botWhite
        botBar.layer.zPosition = 1
        myView.addSubview(botBar)
        for i in 0...images.count - 1
        {
            let icon = UIButton()
            icon.frame = CGRect(x: screenWidth/4 * CGFloat(positions[i]), y: screenHeight - botBarHeight, width: screenWidth/5, height: botBarHeight)
            icon.setImage(UIImage(named: images[i]), for: .normal)
            icon.addTarget(self, action: action, for: .touchDown)
            icon.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
            icon.adjustsImageWhenHighlighted = false
            icon.isUserInteractionEnabled = true
            icon.moveImageLeftTextCenter()
            icon.layer.zPosition = botBar.layer.zPosition + 1
            icon.layer.borderColor = UIColor.black.cgColor
            icon.layer.borderWidth = 1.0
            self.view.addSubview(icon)
        }
    }
    @objc func addTopBar(myView: UIView, barText: String, topLeftFunction: Selector, topLeftName: String, topRightFunction: Selector, topRightName: String)
    {
        let topBar = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: topBarHeight))
        topBar.backgroundColor = topBarColor
        let border = CALayer()
        border.backgroundColor = myEdgeGray.cgColor
        border.frame = CGRect(x:0, y:topBar.frame.size.height - edgeWidth, width:topBar.frame.size.width, height:edgeWidth)
        topBar.layer.addSublayer(border)
        topBar.layer.zPosition = 1
        
        let topBarText = UILabel(frame: CGRect(x: 0, y: topBar.frame.height/2, width: screenWidth, height: topBar.frame.height*1/4))
        topBarText.backgroundColor = topBarColor
        topBarText.textColor = UIColor.white
        topBarText.textAlignment = .center
        topBarText.text = barText
        topBarText.font = UIFont.boldSystemFont(ofSize: topBarText.font.pointSize)
        topBar.addSubview(topBarText)
        
        myView.addSubview(topBar)
        
        let leftButton = UIButton(frame: CGRect(x: 0, y: topBarHeight/2, width: screenWidth/5, height: topBarHeight*5/16))
        leftButton.setTitleColor(myWhite, for: .normal)
        leftButton.setTitle(topLeftName, for: .normal)
        leftButton.addTarget(self, action: topLeftFunction, for: .touchDown)
        leftButton.contentVerticalAlignment = .center
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        leftButton.layer.zPosition = 2
        myView.addSubview(leftButton)

        let rightButton = UIButton(frame: CGRect(x: screenWidth*4/5, y: topBarHeight/2, width: screenWidth/5, height: topBarHeight*5/16))
        rightButton.setTitleColor(myWhite, for: .normal)
        rightButton.setTitle(topRightName, for: .normal)
        rightButton.addTarget(self, action: topRightFunction, for: .touchDown)
        rightButton.contentVerticalAlignment = .center
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButton.layer.zPosition = 2
        myView.addSubview(rightButton)
    }
    @objc func saveTodo()
    {
        print("save")
        todayTodos.append("oof")
        todayTodosChecked.append(0)
        updateTodos()
        let indexPath = IndexPath(row: todayTodos.count - 1, section: 0)
        scrollViewToday.beginUpdates()
        scrollViewToday.insertRows(at: [indexPath], with: .automatic)
        scrollViewToday.endUpdates()
        UIView.animate(withDuration: 0.25)
        {
            self.underView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    @objc func cancelTodo()
    {
       UIView.animate(withDuration: 0.25)
        {
            self.underView.transform = CGAffineTransform(translationX: 0, y: 0)
        }
    }
    @objc func plusTodo()
    {
        print("plustodo")
        UIView.animate(withDuration: 0.25)
        {
            self.underView.transform = CGAffineTransform(translationX: 0, y: -screenHeight)
        }
    }
    @objc func toggleTodo(sender: UIButton)
    {
        if(sender.tag == 0)
        {
            sender.tag = 1
            sender.setImage(UIImage(named: "grayCheckBox"), for: .normal)
            UIView.animate(withDuration: 0.1)
            {
                sender.imageView!.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            }
            sender.imageView!.transform = CGAffineTransform.identity
            sender.backgroundColor = myCheckGray
            sender.setTitleColor(myTextGray, for: .normal)
        }
        else
        {
            sender.tag = 0
//            sender.setImage(UIImage(named: "yellowCheckBox"), for: .normal)
            sender.backgroundColor = myWhite
            sender.setTitleColor(UIColor.black, for: .normal)
        }
        updateChecks()
    }
    @objc func updateChecks()
    {
        for i in 0...todayTodoButtons.count - 1
        {
            if(todayTodoButtons[i].tag == 0)
            {
                todayTodosChecked[i] = 0
            }
            else
            {
                todayTodosChecked[i] = 1
            }
        }
    }
    @objc func goToSwitch(sender: UIButton)
    {
        switch sender.tag
        {
            case 0:
                goToInbox()
            case 1:
                goToToday()
            case 2:
                goToNext()
            case 3:
                goToScheduled()
            case 4:
                goToSomeday()
            case 5:
                goToProjects()
            case 6, 7, 8:
                goToAreas()
            case 9:
                goToLogbook()
            default:
                print("none")
        }
    }
    @objc func goToLists()
    {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .allowUserInteraction, animations:
        {
          self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
          self.rightView.transform = CGAffineTransform(translationX: 0, y: 0)
          self.backToLists.alpha = 0.0
          self.editToday.alpha = 0.0
//          self.topBarText.alpha = 1.0
//          self.topRightBarText.alpha = 0.0
        }, completion: nil)
        
        backToLists.isUserInteractionEnabled = false
        editToday.isUserInteractionEnabled = false
        scrollViewButtons.contentOffset = CGPoint(x: 0, y: topBarHeight)
    }
    func goToInbox()
    {
        print("inbox")
    }
    func goToToday()
    {
        print("today")
        // Right Page slides left with list of checkable items
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .allowUserInteraction, animations:
        {
          self.mainView.transform = CGAffineTransform(translationX: -screenWidth/3, y: 0)
          self.rightView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
//          self.topBarText.alpha = 0.0
//          self.topRightBarText.alpha = 1.0
        }, completion: nil)
        backToLists.isUserInteractionEnabled = true
        backToLists.alpha = 1.0
        editToday.isUserInteractionEnabled = true
        editToday.alpha = 1.0
        setView(view: backToLists, hidden: false, duration: 0.25)
        
        // Top right edit fades in
        // Star appears bottom center left
        // Right arrow appears bottom center right
        // Gear changes to tag
    }
    func goToNext()
    {
        print("next")
    }
    func goToScheduled()
    {
        print("scheduled")
    }
    func goToSomeday()
    {
        print("someday")
    }
    func goToProjects()
    {
        print("projects")
    }
    func goToAreas()
    {
        print("areas")
    }
    func goToLogbook()
    {
        print("logbook")
    }
    func drawMainMenu()
    {
        // Top Blue Menu Label (Lists) ***
        
        // Inbox ***
        // Today ***
        // Next
        // Scheduled
        // Someday
        // Projects
        // Areas
        // Logbook ***
        // Bottom Bar
        // Bottom left plus
        // Bottom right gear
    }
    func drawToday()
    {
        // Back to Lists Button Top Left
        // Label Today
        // Top Right Edit Button
        // Scrollable list of checkable items/editable text
        // Bottom Bar
        // Bottom left plus
        // Bottom middle left star
        // Bottom middle right right arrow
        // Bottom right tag
    }
    func goToTodo()
    {
        // Back to Wherever
        // Label To-Do
        // Top right edit
        // Don't show in Today
        // Move
        // Share
    }
    @objc func editTodo()
    {
        print("EditTodo")
        // To-Do
        // Done
        // Notes
        // Tags
        // Due Date
    }
    func editTodoText()
    {
        // Cancel
        // Edit Title
        // Save
        // Done
    }
    func setView(view: UIView, hidden: Bool, duration: Float)
    {
        UIView.transition(with: view, duration: TimeInterval(duration), options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
            view.isHidden = hidden
        })
    }
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView)
    {

        //design the path
        var path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)

        //design path in layer
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 1.0

        view.layer.addSublayer(shapeLayer)
    }
}

extension UIButton
{
    func moveImageLeftTextCenter()
    {
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        if(self.imageView!.image == UIImage(named: "yellowCheckBox"))
        {
            imageEdgeInsets = UIEdgeInsets(top: imagePadding/4*1.5, left: 0, bottom: imagePadding/4*1.5, right: 0.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        else
        {
            imageEdgeInsets = UIEdgeInsets(top: imagePadding/4, left: imagePadding - imageViewWidth / 2, bottom: imagePadding/4, right: 0.0)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: imagePadding*2 - imageViewWidth, bottom: 0.0, right: 0.0)
        }
        self.contentHorizontalAlignment = .left
    }
}
