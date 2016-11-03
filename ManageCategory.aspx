<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true" CodeFile="ManageCategory.aspx.cs" Inherits="ManageCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

     <div class="jumbotron" id="divUpdateInfo" style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Manage Category/Sub Category</h3>
        </div>
        <div class="row">

            <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged1" AutoPostBack="True" Height="16px" Width="485px" RepeatColumns="2">
                 <asp:ListItem Text="Add Category"  Selected="True" Value="1"  Enabled="true"></asp:ListItem>
                <asp:ListItem Text="Edit Category" Value="2" Enabled="true" ></asp:ListItem>
                <asp:ListItem Text="Add SubCategory"  Value="3"  Enabled="true"></asp:ListItem>
                <asp:ListItem Text="Edit SubCategory" Value="4" Enabled="true" ></asp:ListItem>
            </asp:RadioButtonList>

            
<asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_category]"></asp:SqlDataSource>
        <div class="form-group">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
            </div>
            <div class="form-group">
            <asp:Panel ID="Panel1" runat="server" Visible="True">
            <asp:Label ID="Label1" runat="server" CssClass="col-md-3 control-label" Text="Category: "></asp:Label>
                          <div class="col-md-offset-2">
                  
                <asp:TextBox ID="txtAddCat" runat="server" CssClass="form-control" PlaceHolder="Add Category"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Font-Italic="True" Font-Size="Small" ForeColor="red" ControlToValidate="txtAddCat" ErrorMessage="This field is compulsory">* This field is compulsory</asp:RequiredFieldValidator>
            &nbsp;&nbsp;
                <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="btnAdd_Click"   />
                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btnClear_Click"   />
                <br />
            </div>
          </asp:Panel>
        </div>
            <div class="form-group">
            <asp:Panel ID="Panel2" runat="server" Visible="False">
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_category]" UpdateCommand="Update mst_category
   SET [vc_category_desc]=@vc_category_desc 
   Where nu_category_id= @nu_category_id" DeleteCommand="Delete From mst_category
   Where nu_category_id= @nu_category_id">
    <DeleteParameters>
        <asp:Parameter Name="nu_category_id" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="vc_category_desc" />
        <asp:Parameter Name="nu_category_id" />
    </UpdateParameters>
                </asp:SqlDataSource>
        <div class="form-group">
            <asp:Label ID="LblCategory" runat="server" CssClass="col-md-2 control-label" Text="Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nu_category_id" DataSourceID="SqlDataSource1" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None">
                   <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                     <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="nu_category_id" HeaderText="Category Id" InsertVisible="False" ReadOnly="True" SortExpression="nu_category_id" />
                        <asp:BoundField DataField="vc_category_desc" HeaderText="Category Name" SortExpression="vc_category_desc" />
                    </Columns>
                     <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>
            </div>
        </div>
            
      
          </asp:Panel>
            <br />
            </div>
          
            <div class="form-group">
        <asp:Panel ID="Panel3" runat="server" Visible="False">
               <asp:Label ID="Label2" runat="server" CssClass="col-md-4 control-label" Text="Select a Category: "></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_category]"></asp:SqlDataSource>
            <div class="col-md-offset-2">
           
                <asp:DropDownList ID="ddlCategory"  CssClass="form-control" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource3" DataTextField="vc_category_desc" DataValueField="nu_category_id"></asp:DropDownList>

                </div>
                    <br />
            <asp:Label ID="Label4" runat="server" CssClass="col-md-4 control-label" Text="Add New Sub Category:"></asp:Label>
                <div class="col-md-offset-2">
                     
                  
                    <asp:TextBox ID="txtSubCat"  CssClass="form-control" PlaceHolder="Add Sub Category" runat="server"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtSubCat" Font-Italic="True" Font-Size="Small" ForeColor="red"  ErrorMessage="This field is compulsory">* This field is compulsory</asp:RequiredFieldValidator>    
                <asp:Button ID="AddSubCategory" runat="server" CssClass="btn btn-primary" Text="Add" OnClick="AddSubCategory_Click"   />
                <asp:Button ID="ClearSubCategory" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="ClearSubCategory_Click" CausesValidation="False" />
                <br />
            </div>
          </asp:Panel>
</div>
            <div class="form-group">
                  <asp:Panel ID="Panel4" runat="server" Visible="False">
                        <asp:Label ID="Label5" runat="server" CssClass="col-md-4 control-label" Text="Select a Category: "></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_category]"></asp:SqlDataSource>
            <div class="col-md-offset-2">
           
                <asp:DropDownList ID="DropDownList1" CssClass="form-control"   runat="server" AutoPostBack="True" DataSourceID="SqlDataSource5" DataTextField="vc_category_desc" DataValueField="nu_category_id"></asp:DropDownList>

                </div>
                      <br />
            <asp:Label ID="Label3" runat="server" CssClass="col-md-3 control-label" Text="Edit Sub Category: "></asp:Label>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_sub_category] WHERE ([nu_category_id] = @nu_category_id)" DeleteCommand="Delete From mst_sub_category
   Where nu_sub_category_id= @nu_sub_category_id" UpdateCommand="Update mst_sub_category
   SET [vc_sub_category_desc]=@vc_sub_category_desc 
   Where nu_sub_category_id= @nu_sub_category_id">
                <DeleteParameters>
                    <asp:Parameter Name="nu_sub_category_id" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1"  Name="nu_category_id" PropertyName="SelectedValue" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="vc_sub_category_desc" />
                    <asp:Parameter Name="nu_sub_category_id" />
                </UpdateParameters>
                      </asp:SqlDataSource>
            <div class="col-md-offset-3">
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nu_sub_category_id" DataSourceID="SqlDataSource4" Width="90%" CellPadding="4" ForeColor="#333333" GridLines="None" >
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />

                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="nu_sub_category_id" HeaderText="Sub Category Id" InsertVisible="False" ReadOnly="True" SortExpression="nu_sub_category_id" />
                        <asp:BoundField DataField="vc_sub_category_desc" HeaderText="Sub Category Name" SortExpression="vc_sub_category_desc" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    <AlternatingRowStyle />
                </asp:GridView>
            &nbsp;&nbsp
                </div>
                <div class="col-md-offset-2">
                <br />
            </div>
          </asp:Panel>
        </div>
   
        </div>
        <div class="form-group">
            <div class="col-md-4">
               <%-- <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-primary" Text="Edit" OnClick="btnEdit_Click" />
                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Clear" OnClick="btnClear_Click"  />
                <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-primary" Text="Delete" OnClick="btnDelete_Click" />
                <asp:Button ID="btnHome" runat="server" CssClass="btn btn-primary" Text="Go Back" OnClick="btnHome_Click" />--%>
            </div>
            <div class="col-md-10">
                <asp:Label ID="lblMessage" runat="server" class="control-label small text-danger"></asp:Label>
            </div> 
        </div>



     </div> 
    </div>
       
</asp:Content>

