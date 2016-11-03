using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UCMP_User_Add_Item_Item : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    SqlConnection con = null;
    SqlCommand cmd = null;
    string connectionString = WebConfigurationManager.ConnectionStrings["TrackInConnectionString"].ConnectionString;

    public bool AddNewProduct(string ProductName, decimal BuyPrice, decimal SalePrice, int CategoryId, int SubCatId,int UnitId, int Quantity, byte[] Image)
    {
        bool flag = false;
        try
        {

           
            con = new SqlConnection(connectionString); ;
            cmd = new SqlCommand();
            cmd.CommandText = "sp_AddProduct";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            SqlParameter param = cmd.CreateParameter();
            //param.ParameterName = "@CategoryId";
            //param.Value = CategoryId;
            //param.DbType = DbType.Int16;
            //cmd.Parameters.Add(param);

            param.ParameterName = "@SubCatId";
            param.Value = SubCatId;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@UnitId";
            param.Value = UnitId;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@ProductName";
            param.Value = ProductName;
            param.DbType = DbType.String;
            cmd.Parameters.Add(param);



            param = cmd.CreateParameter();
            param.ParameterName = "@Image";
            param.Value = Image;
            param.DbType = DbType.Binary;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@BuyPrice";
            param.Value = BuyPrice;
            param.DbType = DbType.Decimal;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@SalePrice";
            param.Value = SalePrice;
            param.DbType = DbType.Decimal;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@Quantity";
            param.Value = Quantity;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);
           // CatagoryInfo.CategoryId = Convert.ToInt32(cmd.ExecuteScalar());
            cmd.Connection.Open();
            int noOfRows = cmd.ExecuteNonQuery();
            cmd.Connection.Close();
            if (noOfRows == 1)
            {
                flag = true;
            }
            else
            {
                flag = false;
            }
        }
        catch(SqlException)
        {
            lblMessage.Text = "Product already Exisits.";
        }
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.Message;
           
        }

        return flag;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        bool flag = false;
        if (UploadImage.PostedFile != null &&
               UploadImage.PostedFile.FileName != "")
        {
            byte[] imageSize = new byte
                          [UploadImage.PostedFile.ContentLength];
            HttpPostedFile uploadedImage = UploadImage.PostedFile;
            uploadedImage.InputStream.Read
               (imageSize, 0, (int)UploadImage.PostedFile.ContentLength);
            var data = UploadImage.FileBytes;

            
            flag = AddNewProduct(txtPoduct.Text, Decimal.Parse(txtBuyPrice.Text), Decimal.Parse(txtSalePrice.Text), Convert.ToInt16(ddlCategory.SelectedItem.Value),
                Convert.ToInt16(ddlSubCategory.SelectedItem.Value),Convert.ToInt16(DdlUnit.SelectedItem.Value), Convert.ToInt16(txtQuantity.Text), data);
        }
        else
        {
            flag = false;
            lblMessage.Text = "Add an image.";
        }
        if (flag == true)
        {
            lblMessage.Visible = true;
            lblMessage.Text = "Product added successfully";
            txtPoduct.Text = "";
            //  txtDescription.Text = "";
            txtBuyPrice.Text = "";
            txtSalePrice.Text = "";
            txtQuantity.Text = "";
            UploadImage.Attributes.Clear();
            ddlCategory.SelectedIndex = 0;
        }
        else
        {
            lblMessage.Visible = true;
            lblMessage.Text += "Product cannot added.";
          
        }
    }

    protected void BtnClear_Click(object sender, EventArgs e)
    {
        txtBuyPrice.Text = "";
        txtPoduct.Text = "";
        txtQuantity.Text = "";
        txtSalePrice.Text = "";
        lblError.Text = "";
        lblMessage.Text = "";
        UploadImage.Attributes.Clear();
      
        
            
    }
}