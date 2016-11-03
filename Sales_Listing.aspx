<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true" CodeFile="Sales_Listing.aspx.cs" Inherits="Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="jumbotron"  style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Get Reports(MM/DD/YYYY)...</h3>
        </div>

        <div class="form-group">
            <br />
            <asp:Label ID="Label2" runat="server" CssClass="col-md-3 control-label" Text="From:"></asp:Label>
            <div class="col-md-offset-2">
                <asp:TextBox ID="txtFrom" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div>        
        <div class="form-group">
            <asp:Label ID="Label3" runat="server" CssClass="col-md-3 control-label" Text="To:"></asp:Label>
            <div class="col-md-offset-2">
                <asp:TextBox ID="txtTo" CssClass="form-control" runat="server"></asp:TextBox>
            </div>
        </div> 
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" CssClass="col-md-3 control-label" Text="Sub Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="Expr2" DataValueField="Expr1">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT CAST(nu_sub_category_id AS nvarchar) AS Expr1, vc_sub_category_desc AS Expr2 FROM mst_sub_category UNION SELECT '%' AS Expr1, 'ALL' AS Expr2 ORDER BY Expr1"></asp:SqlDataSource>
            </div>
        </div>
            <div class="col-md-offset-3">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Refresh"  />
                <asp:Button ID="BtnClear" runat="server" CssClass="btn btn-primary" Text="Generate PDF" OnClick="BtnClear_Click"  />
            </div>
         <div>
        </br>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="select right('0000000000'+ a.vc_order_no, 7) order_no, a.dt_order_date, a.nu_prod_id, b.vc_prod_desc, a.nu_sale_price, a.nu_qty
from dt_sales_order a, mst_item b 
where a.nu_prod_id = b.nu_prod_id
and dt_order_date &gt; cast(@fromdate as date) and 
dt_order_date &lt; cast(@todate as date)
and b.nu_sub_category_id like @sub_cat_id" >
            <SelectParameters>
                <asp:ControlParameter ControlID="txtFrom" Name="fromdate" PropertyName="Text" DefaultValue="01-JAN-2001" />
                <asp:ControlParameter ControlID="txtTo" DefaultValue="31-DEC-2020" Name="todate" PropertyName="Text" />
                <asp:ControlParameter ControlID="DropDownList1" DefaultValue="%" Name="sub_cat_id" PropertyName="SelectedValue" />
            </SelectParameters>
             </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%" AllowSorting="True">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="order_no" HeaderText="Order No" ReadOnly="True" SortExpression="order_no" />
                <asp:BoundField DataField="dt_order_date" HeaderText="Date" SortExpression="dt_order_date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="vc_prod_desc" HeaderText="Product" SortExpression="vc_prod_desc" />
                <asp:BoundField DataField="nu_sale_price" HeaderText="Price" SortExpression="nu_sale_price" />
                <asp:BoundField DataField="nu_qty" HeaderText="Qty" SortExpression="nu_qty" />
                <asp:BoundField DataField="nu_prod_id" HeaderText="nu_prod_id" SortExpression="nu_prod_id" Visible="False" />
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
         </div>
</asp:Content>

