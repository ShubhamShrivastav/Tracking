using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ManageCategory : System.Web.UI.Page
{
    TrackIn tr = new TrackIn();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
           
            bool flag = false;
            //if (tr.IsCategoryPresent(txtAddCategory.Text))
            //{
            //    lblMessage.Visible = true;
            //    lblMessage.Text = "Category already present.Add another category";
            //}
            //else
            //{
                flag = tr.AddNewCategory(txtAddCat.Text);
                if (flag == true)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Category added successfully";
                    txtAddCat.Text = "";
                }
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Category cannot added.";
                    txtAddCat.Text = "";
                }

            }
        
        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.Message;
        }
    }

    
    protected void AddSubCategory_Click(object sender, EventArgs e)
    {
        try
        {

            bool flag = false;
            //if (tr.IsCategoryPresent(txtAddCategory.Text))
            //{
            //    lblMessage.Visible = true;
            //    lblMessage.Text = "Category already present.Add another category";
            //}
            //else
            //{
            flag = tr.AddNewSubCategory(Convert.ToInt16(ddlCategory.SelectedItem.Value), txtSubCat.Text);
            if (flag == true)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Sub Category added successfully";
                txtSubCat.Text = "";
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Sub Category cannot added.";
                txtSubCat.Text = "";
            }

        }

        catch (Exception ex)
        {
            lblMessage.Visible = true;
            lblMessage.Text = ex.Message;
        }
    }
    protected void RadioButtonList1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedValue == "1")
        {

            lblMessage.Text = "";
            Panel1.Visible = true;
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel4.Visible = false;
        }
        else if (RadioButtonList1.SelectedValue == "2")
        {
            lblMessage.Text = "";
            Panel1.Visible = false;
            Panel2.Visible = true;
            Panel3.Visible = false;
            Panel4.Visible = false;
            GridView1.DataBind();
        }
        if (RadioButtonList1.SelectedValue == "3")
        {
            lblMessage.Text = "";
            Panel1.Visible = false;
            Panel2.Visible = false;
            Panel3.Visible = true;
            Panel4.Visible = false;
        }
        else if (RadioButtonList1.SelectedValue == "4")
        {
            lblMessage.Text = "";
            Panel1.Visible = false;
            Panel2.Visible = false;
            Panel3.Visible = false;
            Panel4.Visible = true;
            GridView1.DataBind();
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtAddCat.Text = "";
        lblMessage.Text = "";
    }
  
    protected void ClearSubCategory_Click(object sender, EventArgs e)
    {
        txtSubCat.Text = "";
        ddlCategory.SelectedIndex = 1;
        lblMessage.Text = "";
    }
} 