using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

public partial class Edit_Item : System.Web.UI.Page
{
    string connectionString = WebConfigurationManager.ConnectionStrings["TrackInConnectionString"].ConnectionString;
    TrackIn tr = new TrackIn();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            int id = int.Parse(Request.QueryString["Id"]);
           List<string[]> listDetails = new List<string[]>();
            List<string[]> listCat = new List<string[]>();
            List<string[]> listSubCat = new List<string[]>();
            List<string[]> listUnit = new List<string[]>();
            listDetails = GetProductsDetailsByProductId(id);
          //  lblId.Text = id.ToString();
           foreach (var item in listDetails)
           {
               txtPoduct.Text = item[0];
               txtBuyPrice.Text = item[1];
               txtSalePrice.Text = item[2];
               txtQuantity.Text = item[3];
               Image1.ImageUrl = item[4];

           }
            int catid = Convert.ToInt16(Session["CatId"]);
            int subcatid = Convert.ToInt16(Session["SubCatId"]);
            if (catid == 0)
            {
                catid = 1;
            }
           
            ddlCategory.SelectedValue = catid.ToString();
            ddlSubCategory.SelectedValue = subcatid.ToString();
            //listSubCat = GetSubCategoryByCategoryId(subcatid);
            //foreach (var item in listSubCat)
            //{
            //    ddlSubCategory.SelectedValue = item[0];
            //}

            listUnit = GetUnitByProductId(id);
            foreach (var item in listUnit)
            {
                ddlUnit.SelectedValue = item[0];
            }
        }
    }
   
    public List<string[]> GetProductsDetailsByProductId(int productId)
    {

        string sqlSelect = "SELECT * FROM mst_item WHERE nu_prod_id =" + productId;
        List<string[]> list = new List<string[]>();
        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(sqlSelect, con);
        SqlDataReader reader;
       // Product product = new Product();
        try
        {
            con.Open();
            reader = cmd.ExecuteReader();

            reader.Read();

           // string ProductId = Convert.ToInt16(reader["nu_prod_id"]);
            byte[] array = (byte[])(reader["im_prod_image"]);
            string ProductImage = "data:image/jpeg;base64," + Convert.ToBase64String(array);
            string ProductName = reader["vc_prod_desc"].ToString();
          

            decimal ProductBuyPrice = Convert.ToDecimal(reader["nu_buy_price"]);
            decimal ProductSalePrice = Convert.ToDecimal(reader["nu_sale_price"]);
            int InStock = Convert.ToInt16(reader["nu_current_stock"]);
            reader.Close();

      
            list.Add(new string[] { ProductName , ProductBuyPrice.ToString(),ProductSalePrice.ToString(),InStock.ToString(),ProductImage });

        }
        catch (Exception er)
        {
            throw er;

        }
        finally
        {
            con.Close();
        }

        return list;
    }

    //public List<string[]> GetCategoryByCategoryId(int id)
    //{ 
    //    try
    //    {
    //        string sqlSelect = "SELECT * FROM mst_category WHERE nu_category_id=" + id;

    //        List<string[]> list = new List<string[]>();
    //        SqlConnection con = new SqlConnection(connectionString);
    //        SqlCommand cmd = new SqlCommand(sqlSelect, con);
    //        SqlDataReader reader;

    //        con.Open();
    //        reader = cmd.ExecuteReader();
          
    //        if (reader.Read())
    //        {
    //            int CategoryId = id;
    //            string CategoryName = reader["vc_category_desc"].ToString();
    //            list.Add(new string[] { CategoryId.ToString(),CategoryName });
    //        }
    //        reader.Close();
            
    //        return list;
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}

    //public List<string[]> GetSubCategoryByCategoryId(int id)
    //{
    //    try
    //    {
    //        string sqlSelect = "SELECT * FROM mst_sub_category WHERE nu_sub_category_id=" + id;

    //        List<string[]> list = new List<string[]>();
    //        SqlConnection con = new SqlConnection(connectionString);
    //        SqlCommand cmd = new SqlCommand(sqlSelect, con);
    //        SqlDataReader reader;

    //        con.Open();
    //        reader = cmd.ExecuteReader();

    //        if (reader.Read())
    //        {
    //            int SubCategoryId = id;
    //            string SubCategoryName = reader["vc_sub_category_desc"].ToString();
    //            list.Add(new string[] { SubCategoryId.ToString(), SubCategoryName });
    //        }
    //        reader.Close();

    //        return list;
    //    }
    //    catch (Exception ex)
    //    {

    //        throw ex;
    //    }
    //}

    public List<string[]> GetUnitByProductId(int id)
    {
        try
        {
            string sqlSelect = "SELECT u.[nu_unit_id],[vc_unit_desc] FROM [mst_unit] as u join mst_item as i on u.nu_unit_id = i.nu_unit_id where i.nu_prod_id = " + id;

            List<string[]> list = new List<string[]>();
            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand(sqlSelect, con);
            SqlDataReader reader;

            con.Open();
            reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                string UnitId = reader["nu_unit_id"].ToString();
                string UnitName = reader["vc_unit_desc"].ToString();
                list.Add(new string[] { UnitId, UnitName });
            }
            reader.Close();

            return list;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        int id = int.Parse(Request.QueryString["Id"]);
        
        bool flag = false;
        try
        {

            if ((UploadImage.PostedFile != null &&
                UploadImage.PostedFile.FileName != "") || Image1.ImageUrl != null)
            {
                byte[] imageSize = new byte
                              [UploadImage.PostedFile.ContentLength];
                byte[] imageArray = null;
                HttpPostedFile uploadedImage = UploadImage.PostedFile;
                uploadedImage.InputStream.Read
                   (imageSize, 0, (int)UploadImage.PostedFile.ContentLength);

                if (UploadImage.PostedFile != null &&
                UploadImage.PostedFile.FileName != "")
                {
                    imageArray = UploadImage.FileBytes;
                }
                else
                {
                    imageArray = tr.GetItemImage(id);
                }

                int catid = int.Parse(ddlCategory.SelectedItem.Value);
                int subcatid = int.Parse(ddlSubCategory.SelectedItem.Value);
                int unitid = int.Parse(ddlUnit.SelectedItem.Value);


                flag = tr.UpdateItem(Convert.ToInt16(id),Convert.ToInt16(subcatid), Convert.ToInt16(unitid), txtPoduct.Text, Convert.ToDecimal(txtBuyPrice.Text), Convert.ToInt16(txtQuantity.Text), Convert.ToDecimal(txtSalePrice.Text), imageArray);
                if (flag == true)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Product updated successfully";
                    txtPoduct.Text = "";
                    //  txtDescription.Text = "";
                    txtBuyPrice.Text = "";
                    txtSalePrice.Text = "";
                    txtQuantity.Text = "";

                    ddlCategory.SelectedIndex = 0;
                    Image1.Visible = false;
                    //lblMsg.Visible = false;
                   
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Product cannot be updated.";

                }
            }
        }
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.Message;
        }

    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtPoduct.Text = "";
        //  txtDescription.Text = "";
        txtBuyPrice.Text = "";
        txtSalePrice.Text = "";
        txtQuantity.Text = "";
        Image1.Visible = false;
        ddlCategory.SelectedIndex = 0;
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        Response.Redirect("ChangePrice.aspx");
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        int id = int.Parse(Request.QueryString["Id"]);
          bool flag = false;
        try
        {
            MessageBoxButtons buttons = MessageBoxButtons.YesNo;
            DialogResult result;

            // Displays the MessageBox.

            result = MessageBox.Show("Are you sure you want to delete", "Product will be deleted", buttons);

            if (result == DialogResult.Yes)
            {

                flag = tr.DeleteItem(id);
                if (flag == true)
                {
                    Response.Redirect("ChangePrice.aspx");
                }
                else
                {
                    lblMessage.Text = "Product cannot be deleted.";
                }
            }
           
        }
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.Message;
        }
    }
}