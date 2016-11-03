using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ChangePrice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
       Session["CatId"] = ddlCategory.SelectedItem.Value;
       Session["SubCatId"] = ddlSubCategory.SelectedItem.Value;
     
    }
}