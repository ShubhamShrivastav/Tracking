using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMasterUser : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (HttpContext.Current.User.Identity.IsAuthenticated)
        //    WelcomeLabel.Text = "Welcome, " + Page.User.Identity.Name; 
    }
    protected void LoginStatus1_LoggedOut(object sender, EventArgs e)
    {
       // Session.Abandon();
        //Response.Redirect("~/Login.aspx");
        //Session.Clear();
        //Session.Abandon();
        //Session.RemoveAll();
        //FormsAuthentication.SignOut();
        //FormsAuthentication.RedirectToLoginPage();
        //Roles.DeleteCookie();
    }

}
