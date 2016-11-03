using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test_report : System.Web.UI.Page
{
    string reportname;
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie cookie = Request.Cookies["report"];
        if (cookie != null)
        {
            reportname = cookie["name"];

        }


        string FilePath = Server.MapPath("reports/"+reportname);
        WebClient User = new WebClient();
        Byte[] FileBuffer = User.DownloadData(FilePath);
        if (FileBuffer != null)
        {
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-length", FileBuffer.Length.ToString());
            Response.BinaryWrite(FileBuffer);
        }
    }

}