<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true"  CodeFile="Edit_Item.aspx.cs" Inherits="Edit_Item" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="jumbotron" id="divUpdateInfo" style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Update&nbsp; Items...</h3>
        </div>
        <div class="row">

        <div class="form-group" style="margin-top:10px">
            <asp:Label ID="lblMobile" runat="server" CssClass="col-md-3 control-label" Text="Product: "></asp:Label>
            <div class="col-md-offset-2">

                <asp:TextBox ID="txtPoduct" runat="server" CssClass="form-control" placeholder="Product"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtPoduct" Display="Dynamic" 
                        ErrorMessage="ProductName should not be empty" ForeColor="red" 
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small">* ProductName should not be empty</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtPoduct" Display="Dynamic" 
                        ErrorMessage="Cannot contain special characters" ForeColor="red" 
                        SetFocusOnError="True"
                        ValidationExpression="[a-z A-Z]+[\w\s(@|-|#|$|\.)*]*" 
                        Font-Italic="True" Font-Size="Small">* Cannot contain special characters</asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="lblPrice" runat="server" CssClass="col-md-3 control-label" Text=" Buy Price:"></asp:Label>
            <div class="col-md-offset-2">


                <asp:TextBox ID="txtBuyPrice" runat="server" CssClass="form-control" placeholder="Buy Price"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtBuyPrice" Display="Dynamic" 
                        ErrorMessage="Price should not be empty" ForeColor="red" 
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small">* Price should not be empty</asp:RequiredFieldValidator>
                    
                    
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="txtBuyPrice" Font-Italic="True" Font-Size="Small" ErrorMessage="Enter Price in Numeric" 
                        ForeColor="red" ValidationExpression="\d+[.]\d+">* Enter Price in Numeric</asp:RegularExpressionValidator>
            </div>
        </div>
        
        <div class="form-group">
            <asp:Label ID="lblSalePrice" runat="server" CssClass="col-md-3 control-label" Text="Sale Price:"></asp:Label>
            <div class="col-md-offset-2">

                <asp:TextBox ID="txtSalePrice" runat="server" CssClass="form-control" placeholder="Sale Price"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                        ControlToValidate="txtSalePrice" Display="Dynamic" 
                        ErrorMessage="Price should not be empty" ForeColor="red" 
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small">* Price should not be empty</asp:RequiredFieldValidator>
                    
                    
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ControlToValidate="txtSalePrice" ErrorMessage="Enter Price in Numeric" Font-Italic="True" Font-Size="Small"
                        ForeColor="red" ValidationExpression="\d+[.]\d+">* Enter Price in Numeric</asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="lblQuantity" runat="server"  CssClass="col-md-3 control-label" Text="Available Quantity:"></asp:Label>
            <div class="col-md-offset-2">



                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" placeholder="Available Quantity"></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="txtQuantity" Display="Dynamic" 
                        ErrorMessage="Price should not be empty" ForeColor="red" 
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small">* Price should not be empty</asp:RequiredFieldValidator>
                     <asp:RegularExpressionValidator id="RegularExpressionValidator4"
                   ControlToValidate="txtQuantity"
                   ValidationExpression="\d+"
                   Display="Static" Font-Italic="True" Font-Size="Small"
                   EnableClientScript="true"
                   ErrorMessage="Please enter numbers only"
                   runat="server" ForeColor="red">* Please enter numbers only</asp:RegularExpressionValidator>
                    
                    <asp:CompareValidator ID="CompareValidator4" runat="server" 
                        ErrorMessage="Enter a whole number" ControlToValidate="txtQuantity"
                         Operator="GreaterThanEqual" ValueToCompare="0" Display="Dynamic"
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small" ForeColor="red" >* Enter a whole number</asp:CompareValidator>
                 </div>
        </div>

       <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_category]"></asp:SqlDataSource>
        <div class="form-group">
            <asp:Label ID="LblCategory" runat="server" CssClass="col-md-3 control-label" Text="Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="vc_category_desc" DataValueField="nu_category_id" AutoPostBack="True"></asp:DropDownList>
            </div>
        </div>
         <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_sub_category] WHERE ([nu_category_id] = @nu_category_id)">
             <SelectParameters>
                 <asp:ControlParameter ControlID="ddlCategory" Name="nu_category_id" PropertyName="SelectedValue" Type="Int32" />
             </SelectParameters>
            </asp:SqlDataSource>
        <div class="form-group">
            <asp:Label ID="lblSubCategory" runat="server" CssClass="col-md-3 control-label" Text="Sub Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="vc_sub_category_desc" DataValueField="nu_sub_category_id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_unit]"></asp:SqlDataSource>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="lblUnit" runat="server" CssClass="col-md-3 control-label" Text="Unit: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="ddlUnit" runat="server" CssClass="form-control" DataSourceID="SqlDataSource3" DataTextField="vc_unit_desc" DataValueField="nu_unit_id"></asp:DropDownList>
            </div>
        </div>
       <div class="form-group">
              <asp:Label ID="lblImage" runat="server" CssClass="col-md-3 control-label" Text="Image: "></asp:Label>
             <div class="col-md-offset-3">

                 <asp:Image ID="Image1" runat="server" style="height:212px"/>
                &nbsp;<asp:FileUpload ID="UploadImage" runat="server" CssClass="form-control" />
                                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="UploadImage" ErrorMessage="Select An Image" Font-Italic="True" 
                        Font-Size="Small" ForeColor="Red">* Select An Image</asp:RequiredFieldValidator>--%>
                <asp:Label ID="lblError" runat="server" CssClass="control-label small text-warning"></asp:Label>
         </div>
        </div>
        <div class="form-group">
            <div class="col-md-5">
                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary" Text="Edit" OnClick="btnEdit_Click" />
                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btnClear_Click" CausesValidation="False"  />
                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClick="btnDelete_Click" CausesValidation="False" />
            </div>
            <div class="col-md-10">
                <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                        Font-Size="Medium" ForeColor="red" />--%>

                <asp:Label ID="lblMessage" runat="server" class="control-label small text-danger"></asp:Label>
            </div> 
        </div>
     </div> 
    </div>
        </div>
</asp:Content>

