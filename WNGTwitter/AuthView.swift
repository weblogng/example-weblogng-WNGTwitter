import UIKit
import Accounts
import Social
import SwifteriOS

// our AuthView is assigned to the first UIViewController in the Main.storyboard
class AuthView: UIViewController
{
    
    @IBAction func doTwitterLogin(sender : AnyObject) {
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil,
            completion: { (granted, error) in
                if (granted) {
                    let arrayOfAccount: NSArray = account.accountsWithAccountType(accountType)
                    if (arrayOfAccount.count > 0) {
                        let twitterAccount = arrayOfAccount.lastObject as ACAccount
                        let swifter = Swifter(account: twitterAccount)
                        self.fetchTwitterHomeStream(swifter)
                    }
                } else {
                    self.alert("Unable to login")
                }
            }
        )
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // Keeping things DRY by creating a simple alert method that we can reuse for generic errors
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
    
    
    // More DRY code, fetch the users home timeline if all went well
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
    
}
