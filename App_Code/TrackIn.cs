using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

/// <summary>
/// Summary description for TrackIn
/// </summary>
public class TrackIn
{
     SqlConnection con = null;
    SqlCommand cmd = null;
   string connectionString = WebConfigurationManager.ConnectionStrings["TrackInConnectionString"].ConnectionString;


	public TrackIn()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public byte[] GetItemImage(int productId)
    {
  
        string sqlSelect = "SELECT * FROM mst_item WHERE nu_prod_id =" + productId;

        SqlConnection con = new SqlConnection(connectionString);
        SqlCommand cmd = new SqlCommand(sqlSelect, con);
        SqlDataReader reader;

        byte[] array = null;
        try
        {
            con.Open();
            reader = cmd.ExecuteReader();

            reader.Read();


            int ProductId = Convert.ToInt16(reader["nu_prod_id"]);
            array = (byte[])(reader["im_prod_image"]);
            reader.Close();

        }
        catch (Exception er)
        {
            throw er;

        }
        finally
        {
            con.Close();
        }
        return array;

    }

    public bool UpdateItem(int ProductId,int SubCategoryId,int UnitId, string ProductName,decimal BuyPrice,int InStock,decimal SalePrice, byte[] Image)
    {
        try
        {
            bool flag = false;
            con = new SqlConnection(connectionString);
            cmd = new SqlCommand();
            cmd.CommandText = "sp_UpdateProduct";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            SqlParameter param = cmd.CreateParameter();
            param.ParameterName = "@ProductID";
            param.Value = ProductId;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@SubCategoryID";
            param.Value = SubCategoryId;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@ProductName";
            param.Value = ProductName;
            param.DbType = DbType.String;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@UnitId";
            param.Value = UnitId;
            param.DbType = DbType.Int16;
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
            param.ParameterName = "@Instock";
            param.Value = InStock;
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

            return flag;

        }
        catch (Exception er)
        {

            throw er;
        }

    }

    public bool DeleteItem(int id)
    {
        try
        {

            bool flag = false;
            con = new SqlConnection(connectionString); ;
            cmd = new SqlCommand();
            cmd.CommandText = "sp_DeleteItem";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;

            SqlParameter param = cmd.CreateParameter();
            param.ParameterName = "@ProductID";
            param.Value = id;
            param.DbType = DbType.Int16;
            cmd.Parameters.Add(param);

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

            return flag;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public bool AddNewCategory(string category)
    {
        try
        {
            bool flag = false;
            con = new SqlConnection(connectionString); ;
            cmd = new SqlCommand();
            cmd.CommandText = "sp_AddNewCategory";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            SqlParameter CategoryName = cmd.CreateParameter();
            CategoryName.ParameterName = "@CategoryName";
            CategoryName.Value = category;
            cmd.Parameters.Add(CategoryName);
            //  CatagoryInfo.CategoryId = Convert.ToInt32(cmd.ExecuteScalar());
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

            return flag;

        }
        catch(SqlException)
        {
            throw new Exception("Category already Exists.");
        }
        catch (Exception er)
        {

            throw er;
        }
    }

    public bool AddNewSubCategory(int categoryId,string subCategoryName)
    {
        try
        {
            bool flag = false;
            con = new SqlConnection(connectionString); ;
            cmd = new SqlCommand();
            cmd.CommandText = "sp_AddSubCategory";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            SqlParameter param = cmd.CreateParameter();
            param.ParameterName = "@CategoryId";
            param.Value = categoryId;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "@SubCategoryName";
            param.Value = subCategoryName;
            cmd.Parameters.Add(param);
            //  CatagoryInfo.CategoryId = Convert.ToInt32(cmd.ExecuteScalar());
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

            return flag;

        }
        catch(SqlException)
        {
            throw new Exception("Sub Category already Exists.");
        }
        catch (Exception er)
        {
            throw er;
        }
    }


   



}