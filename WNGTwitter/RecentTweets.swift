//
//  Based on SwifterDemoiOS
//
//
import UIKit
import SwifteriOS
import Accounts
import Social


class RecentTweets: UITableViewController {

    var tweets : [JSONValue] = []

    
    @IBAction func refresh(sender: AnyObject) {
        loginAndGetTweets()
    }

    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tweets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
        
        cell.textLabel!.text = tweets[indexPath.row]["text"].string
        
        return cell
    }
    
    
    
    
    func loginAndGetTweets() {
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil,
            completion: { (granted, error) in
                if (granted) {
                    
                    let arrayOfAccount: NSArray = account.accountsWithAccountType(accountType)
                    if (arrayOfAccount.count > 0) {
                        let twitterAccount = arrayOfAccount.lastObject as ACAccount
                        var swifter : Swifter
                        swifter = Swifter(account: twitterAccount)
                        
                        self.fetchTwitterHomeStream(swifter)
                    }
                } else {
                    self.alert("Unable to login")
                }
            }
        )
 
   }

    

    
    
    func fetchTwitterHomeStream(swifter: Swifter)
    {
        let failureHandler: ((NSError) -> Void) = {
            error in
            self.alert(error.localizedDescription)
        }
        
        swifter.getStatusesHomeTimelineWithCount(20, sinceID: nil, maxID: nil, trimUser: true, contributorDetails: false, includeEntities: true, success: {
            (statuses: [JSONValue]?) in
            // Successfully fetched timeline, so lets create and push the table view
            let tweetsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("RecentTweets") as RecentTweets
            
            if statuses != nil {
                tweetsViewController.tweets = statuses!
                self.presentViewController(tweetsViewController, animated: true, completion: nil)
            }
            
            }, failure: failureHandler)
        
    }
    
    
    func alert(message: String)
    {
        // This is the iOS8 way of doing alerts. For older versions, look into UIAlertView
        var alert = UIAlertController(
            title: nil,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}