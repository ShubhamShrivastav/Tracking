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
using System.Data;

using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;

public partial class Reports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            Button1.Visible = false;
        }
    }
    SqlConnection con = null;
    SqlCommand cmd = null;
    string connectionString = WebConfigurationManager.ConnectionStrings["TrackInConnectionString"].ConnectionString;
    string netValue;
    string netTax;
    string grandValue;
    string orderId;
    string report_name;


    public decimal getPrice(int Product_Id)
    {
        decimal var1=0;
        try
        {

            con = new SqlConnection(connectionString); ;
            cmd = new SqlCommand();
            cmd.CommandText = "sp_getPrice";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            SqlParameter param = cmd.CreateParameter();
            //SqlParameter param1 = cmd.CreateParameter();

            param.ParameterName = "@ProductId";
            param.Value = Product_Id;
            param.DbType = DbType.Int16;
            

            cmd.Parameters.Add(param);
            cmd.Parameters.Add("@Price", SqlDbType.Decimal).Direction = ParameterDirection.ReturnValue;
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();
            var1 =  decimal.Parse(cmd.Parameters["@Price"].Value.ToString());
            
        }
        catch (Exception ex)
        {

        }
        return var1;
    }

    //public string getNetValue(string orderNo)
    //{
    //    string var1 = "";
    //    try
    //    {

    //        con = new SqlConnection(connectionString); ;
    //        cmd = new SqlCommand();
    //        cmd.CommandText = "sp_getNetValue";
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Connection = con;

    //        SqlParameter param = cmd.CreateParameter();
    //        //SqlParameter param1 = cmd.CreateParameter();

    //        param.ParameterName = "@vc_order_no1";
    //        param.Value = orderNo;
    //        param.DbType = DbType.String;
    //        cmd.Parameters.Add(param);

    //        param = cmd.CreateParameter();
    //        param.ParameterName = "@netValue";
    //        param.DbType = DbType.String;
    //        cmd.Parameters.Add(param);

    //        //cmd.Parameters.Add("@value", SqlDbType.NVarChar).Direction = ParameterDirection.ReturnValue;

    //        cmd.Connection.Open();
    //        cmd.ExecuteNonQuery();
    //        cmd.Connection.Close();
    //        var1 = cmd.Parameters["@netValue"].Value.ToString();

    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //    return var1;
    //}

    protected void getValues()
    {
        //This method retrieves all of the attributes of the selected author from the database and
        //populates the controls with these values
        //See page 455

        //Define AdO dot net objects
        string selectSQL = "SELECT cast(cast(nu_net_value as decimal(15,2))as nvarchar) nu_net_value,cast(cast(nu_tax_values as decimal(15,2))as nvarchar) as nu_tax_value, cast(cast(nu_grand_value as decimal(15,2))as nvarchar) as nu_grand_value FROM hd_sales_order WHERE vc_order_no = '" + orderId.ToString() + "';";
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(selectSQL, con);
        SqlDataReader reader;

        try
        {
            con.Open();
            reader = cmd.ExecuteReader();

            reader.Read();

            //Fill up the text boxes from the reader
            netValue = reader["nu_net_value"].ToString();
            netTax = reader["nu_tax_value"].ToString();
            grandValue = reader["nu_grand_value"].ToString();
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

    public void addInOrder(int Product_Id, string Product_desc, decimal Product_Price, int Product_Qty)
    {
        try
        {

            con = new SqlConnection(connectionString); ;
            cmd = new SqlCommand();
            cmd.CommandText = "sp_addInOrder";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            SqlParameter param = cmd.CreateParameter();

            param.ParameterName = "@ProductId";
            param.Value = Product_Id;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@ProductDesc";
            param.Value = Product_desc;
            param.DbType = DbType.String;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@ProductPrice";
            param.Value = Product_Price;
            param.DbType = DbType.Decimal;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@ProductQty";
            param.Value = Product_Qty;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();

        }
        catch (Exception ex)
        {

        }
     
    }

    public string addSalesOrder()
    {
        string var1 = " ";
         try
        {

            con = new SqlConnection(connectionString);
            cmd = new SqlCommand();
            cmd.CommandText = "sp_addSalesOrder";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            cmd.Parameters.Add("@orderId", SqlDbType.NVarChar).Direction = ParameterDirection.ReturnValue;

            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Connection.Close();

            var1 = cmd.Parameters["@orderId"].Value.ToString();

        }
        catch (Exception ex)
        {

        }

         return var1;
    }

    public void writeReport(string orderId,string orderDate)
    {
        string f = DateTime.Now.ToString("dd-MM-yyyy-HH-MM-ss");
        report_name = "Report_" + f +"sales_bill" + ".pdf";
        Document doc = new Document(iTextSharp.text.PageSize.LETTER, 10, 10, 42, 35);
        PdfWriter wri = PdfWriter.GetInstance(doc, new FileStream("D://Academics//IS Dev//TrackIn//reports//Report_" + f +"sales_bill" + ".pdf", FileMode.Create));
        doc.Open();

        PdfPTable table = new PdfPTable(GridView1.Columns.Count-1);
        for (int j = 0; j < GridView1.Columns.Count-1; j++)
        {
            table.AddCell(new Phrase(GridView1.Columns[j].HeaderText));
        }

        table.HeaderRows = 1;

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            for (int K = 0; K < GridView1.Columns.Count-1; K++)
            {
                table.AddCell(new Phrase(GridView1.Rows[i].Cells[K].Text));
            }
        }

        Paragraph paragraph = new Paragraph("                ****************Bill*******************");
        Paragraph paragraph7 = new Paragraph("  ");
        Paragraph paragraph1 = new Paragraph("                Order No :    " + orderId);
        Paragraph paragraph2 = new Paragraph("                Order Date :    " + orderDate);
        Paragraph paragraph3 = new Paragraph("  ");
        doc.Add(paragraph);
        doc.Add(paragraph7);
        doc.Add(paragraph1);
        doc.Add(paragraph2);
        doc.Add(paragraph3);
        doc.Add(table);
        Paragraph paragraph8 = new Paragraph(" ");
        doc.Add(paragraph8);
        Paragraph paragraph4 = new Paragraph("                Net Value :    " + netValue);
        doc.Add(paragraph4);
        Paragraph paragraph5 = new Paragraph("                Tax Value :    " + netTax);
        doc.Add(paragraph5);
        Paragraph paragraph6 = new Paragraph("                Grant Total :    " + grandValue);
        doc.Add(paragraph6);
        doc.Close();
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
       TextBox2.Text= getPrice(Convert.ToInt16(ddlCategory.SelectedValue)).ToString();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        addInOrder(Convert.ToInt16(ddlCategory.SelectedItem.Value), ddlCategory.SelectedItem.Text, decimal.Parse(TextBox2.Text), Convert.ToInt16(TextBox1.Text));
        TextBox2.Text = "";
        TextBox1.Text = "";
        GridView1.DataBind();
        Button1.Visible = true;
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        
        orderId=addSalesOrder();
        string orderDate = DateTime.Now.ToString("dd-MM-yyyy");
        getValues();
        writeReport(orderId,orderDate);
        GridView1.DataBind();
        Button1.Visible = false;

        //calling the report
        HttpCookie cookie = new HttpCookie("report");
        cookie["name"] = report_name;
        Response.Cookies.Add(cookie);

        for (int i = 0; GridView1.Columns.Count > i; )
        {
            GridView1.Columns.RemoveAt(i);
        }
        Response.Redirect("test_report.aspx",false);
       
    }

}



























