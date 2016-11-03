using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Data.SqlClient;
using System.Web.Configuration;

public partial class Reports : System.Web.UI.Page
{
    string netValue;
    string netTax;
    string grandValue;
    string reportName;

    SqlConnection con = null;
    SqlCommand cmd = null;
    string connectionString = WebConfigurationManager.ConnectionStrings["TrackInConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void getValues()
    {
        //This method retrieves all of the attributes of the selected author from the database and
        //populates the controls with these values
        //See page 455

        //Define AdO dot net objects
        //string selectSQL = "SELECT cast(cast(sum(nu_net_value) as decimal(15,2))as nvarchar) nu_net_value,cast(cast(sum(nu_tax_values) as decimal(15,2))as nvarchar) as nu_tax_value, cast(cast(sum(nu_grand_value) as decimal(15,2))as nvarchar) as nu_grand_value FROM hd_sales_order WHERE vc_order_no = '" + orderId.ToString() + "';";
        string selectSQL = "select cast(cast(sum(a.nu_sale_price*nu_qty) as decimal(15,2)) as nvarchar) as netValue,cast(cast(sum(((a.nu_tax_value/100.00)*a.nu_sale_price)*a.nu_qty)as decimal(15,2)) as nvarchar)  as netTax,cast(cast(sum((((a.nu_tax_value/100.00)*a.nu_sale_price)+a.nu_Sale_price)*a.nu_qty)as decimal(15,2)) as nvarchar) as grandValue from dt_sales_order a, mst_item b where a.nu_prod_id = b.nu_prod_id and dt_order_date > '"+txtFrom.Text+"' and dt_order_date <'"+ txtTo.Text +"' and b.nu_sub_category_id like '"+DropDownList1.SelectedItem.Value+"';";
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(selectSQL, con);
        SqlDataReader reader;

        try
        {
            con.Open();
            reader = cmd.ExecuteReader();

            reader.Read();

            //Fill up the text boxes from the reader
            netValue = reader["netValue"].ToString();
            netTax = reader["netTax"].ToString();
            grandValue = reader["grandValue"].ToString();
            reader.Close();


        }
        catch (Exception er)
        {

        }
        finally
        {
            con.Close();
        }


    }


    protected void BtnClear_Click(object sender, EventArgs e)
    {

        getValues();

        string f = DateTime.Now.ToString("dd-MM-yyyy-HH-MM-ss");
        reportName = "Report_" + f + ".pdf";
        Document doc = new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
        PdfWriter wri = PdfWriter.GetInstance(doc, new FileStream("D://Academics//IS Dev//TrackIn//reports//Report_" + f + ".pdf", FileMode.Create));
        doc.Open();


        PdfPTable table = new PdfPTable(GridView1.Columns.Count-1);
        for (int j=0; j < GridView1.Columns.Count-1; j++)
        {
            table.AddCell(new Phrase(GridView1.Columns[j].HeaderText));
        }

        table.HeaderRows = 1;

        for(int i=0; i < GridView1.Rows.Count; i++)
        {
            for(int K=0; K < GridView1.Columns.Count-1; K++ )
            {
                table.AddCell(new Phrase(GridView1.Rows[i].Cells[K].Text));   
            }
        }

        Paragraph paragraph = new Paragraph("                ****************Report*******************");
        doc.Add(paragraph);
        Paragraph paragraph_gap = new Paragraph("                " );
        doc.Add(paragraph_gap);
        Paragraph paragraph1 = new Paragraph("                From:  "+txtFrom.Text );
        doc.Add(paragraph1);
        Paragraph paragraph2 = new Paragraph("                To:  "+txtTo.Text);
        doc.Add(paragraph2);
        Paragraph paragraph_gap2 = new Paragraph("                ");
        doc.Add(paragraph_gap2);
        doc.Add(table);
        Paragraph paragraph_gap1 = new Paragraph("                ");
        doc.Add(paragraph_gap1);
        Paragraph paragraph3 = new Paragraph("                Net Value:  " + netValue);
        doc.Add(paragraph3);
        Paragraph paragraph4 = new Paragraph("                Net Tax  " + netTax);
        doc.Add(paragraph4);
        Paragraph paragraph5 = new Paragraph("                Grand Total  " + grandValue);
        doc.Add(paragraph5);
        doc.Close();

        HttpCookie cookie = new HttpCookie("report");
        cookie["name"] = reportName;
        Response.Cookies.Add(cookie);
        Response.Redirect("test_report.aspx", false);

    }
 
}



























