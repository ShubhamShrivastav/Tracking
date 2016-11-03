<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true" CodeFile="SalesOrder.aspx.cs" Inherits="Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="jumbotron"  style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Select Items & Qty ...</h3>
        </div>
     <div class="form-group">
            <br />
            <asp:Label ID="lblCategory" runat="server" CssClass="col-md-3 control-label" Text="Product: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="vc_prod_desc" DataValueField="nu_prod_id" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT [nu_prod_id], [vc_prod_desc] FROM [mst_item] ORDER BY [vc_prod_desc]"></asp:SqlDataSource>
            </div>
     </div>
     <div class="form-group">
            <asp:Label ID="Label1" runat="server" CssClass="col-md-3 control-label" Text="Price: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:TextBox ID="TextBox2" CssClass="form-control" runat="server"></asp:TextBox> 
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="TextBox2" Display="Dynamic" 
                        ErrorMessage="Pleas enter price" ForeColor="red" 
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small">* Please enter price</asp:RequiredFieldValidator>
           <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
                        ControlToValidate="TextBox2" ErrorMessage="Enter Price in Numeric" Font-Size="Small" Font-Italic="True"
                        ForeColor="red" ValidationExpression="\d+[.]\d+">* Enter Price in Numeric</asp:RegularExpressionValidator>
                 </div>
     </div>
     <div class="form-group">
            <asp:Label ID="Label2" runat="server" CssClass="col-md-3 control-label" Text="Qty: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:TextBox ID="TextBox1" CssClass="form-control" runat="server"></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="TextBox1" Display="Dynamic" 
                        ErrorMessage="Please enter quantity" ForeColor="red" 
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small">* Please enter quantity</asp:RequiredFieldValidator>
              <asp:RegularExpressionValidator id="RegularExpressionValidator4"
                   ControlToValidate="TextBox1" Font-Size="Small"
                   ValidationExpression="\d+"
                   Display="Dynamic"
                   EnableClientScript="true"
                   ErrorMessage="Please enter numbers only"
                   runat="server" Font-Italic="True" ForeColor="red">* Please enter numbers only</asp:RegularExpressionValidator>
                    <asp:CompareValidator ID="CompareValidator4" runat="server" 
                        ErrorMessage="Enter a whole number" ControlToValidate="TextBox1"
                         Operator="GreaterThanEqual" ValueToCompare="0" Display="Dynamic"
                        SetFocusOnError="True" Font-Italic="True" Font-Size="Small" ForeColor="red" >* Enter a whole number</asp:CompareValidator>
            </div>
     </div>

            <div class="col-md-offset-3">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="ADD" OnClick="btnSubmit_Click"  />
                <asp:Button ID="BtnClear" runat="server" CssClass="btn btn-primary" Text="CANCEL"  />
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT [vc_prod_desc], [nu_sale_price], [nu_qty], [nu_prod_id] FROM [temp_Sales]"></asp:SqlDataSource>
            </div>
         <div>
             </br>
             <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="nu_prod_id" DataSourceID="SqlDataSource2" ForeColor="#333333" GridLines="None"  Width="100%" >
                 <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                 <Columns>
                     <asp:BoundField DataField="vc_prod_desc" HeaderText="Product" SortExpression="vc_prod_desc" />
                     <asp:BoundField DataField="nu_sale_price" HeaderText="Price" SortExpression="nu_sale_price" />
                     <asp:BoundField DataField="nu_qty" HeaderText="Qty" SortExpression="nu_qty" />
                     <asp:BoundField DataField="nu_prod_id" HeaderText="nu_prod_id" ReadOnly="True" SortExpression="nu_prod_id" Visible="False" />
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
        <div>
             <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Checkout" OnClick="Button1_Click" OnClientClick = "SetTarget();" CausesValidation="false"/>
            <script type = "text/javascript">
 function SetTarget() {
     document.forms[0].target = "_blank";
 }
</script>
        </div>
        </div>
         </div>
</asp:Content>

