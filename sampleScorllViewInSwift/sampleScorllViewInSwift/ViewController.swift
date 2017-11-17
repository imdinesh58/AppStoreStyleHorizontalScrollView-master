

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let kCellHeight:CGFloat = 100.0
    var sampleTableView:UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sampleTableView = UITableView(frame:CGRect(x: 0,y: 200,width: self.view.frame.size.width, height: self.view.frame.size.height), style:.grouped)
        sampleTableView.dataSource = self
        sampleTableView.delegate = self
        sampleTableView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        self.view.addSubview(sampleTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.sampleTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let CellIdentifierPortrait = "CellPortrait";
        let CellIdentifierLandscape = "CellLandscape";
        let indentifier = self.view.frame.width > self.view.frame.height ? CellIdentifierLandscape : CellIdentifierPortrait
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifier)

        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: indentifier)
            cell?.selectionStyle = .none
            let horizontalScrollView:ASHorizontalScrollView = ASHorizontalScrollView(frame:CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: kCellHeight))
            //for iPhone 5s and lower versions in portrait
            horizontalScrollView.marginSettings_320 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
            //for iPhone 4s and lower versions in landscape
            horizontalScrollView.marginSettings_480 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
            // for iPhone 6 plus and 6s plus in portrait
            horizontalScrollView.marginSettings_414 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 5, miniAppearWidthOfLastItem: 20)
            // for iPhone 6 plus and 6s plus in landscape
            horizontalScrollView.marginSettings_736 = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 10, miniAppearWidthOfLastItem: 30)
            //for all other screen sizes that doesn't set here, it would use defaultMarginSettings instead
            horizontalScrollView.defaultMarginSettings = MarginSettings(leftMargin: 10, miniMarginBetweenItems: 10, miniAppearWidthOfLastItem: 20)
            
            if indexPath.row == 0{
                //you can set margin for specific item size here
                horizontalScrollView.shouldCenterSubViews = true
                horizontalScrollView.marginSettings_414?.miniMarginBetweenItems = 20
                horizontalScrollView.uniformItemSize = CGSize(width: 100, height: 500)
                //this must be called after changing any size or margin property of this class to get acurrate margin
                horizontalScrollView.setItemsMarginOnce()
                for _ in 1...4{
                    let button = UIButton(frame: CGRect.zero)
                    button.backgroundColor = UIColor.blue
                    horizontalScrollView.addItem(button)
                }
                _ = horizontalScrollView.centerSubviews()
            }

            cell?.contentView.addSubview(horizontalScrollView)
            horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: kCellHeight))
            cell?.contentView.addConstraint(NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: cell!.contentView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        }
        else if let horizontalScrollView = cell?.contentView.subviews.first(where: { (view) -> Bool in
            return view is ASHorizontalScrollView
        }) as? ASHorizontalScrollView {
            horizontalScrollView.refreshSubView() //refresh view incase orientation changes
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return kCellHeight
    }
    
}

