<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true" CodeFile="InStockItems.aspx.cs" Inherits="InStockItems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="jumbotron"  style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Low Stock Items</h3>
        </div>

 
     <div class="form-group">
            <%--<asp:Label ID="lblPrducts" runat="server" CssClass="col-md-3 control-label" Text="Products: "></asp:Label>--%>
            <div >
                </br>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nu_prod_id" DataSourceID="SqlDataSource1" Width="100%" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" >
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="vc_prod_desc" HeaderText="Product" SortExpression="vc_prod_desc" />
                        <asp:BoundField DataField="nu_current_stock" HeaderText="InStock" SortExpression="nu_current_stock" />
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
                <br />
            </div>
        </div>
        </div>
         </div>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT [nu_prod_id], [vc_prod_desc], [nu_current_stock] FROM [mst_item] WHERE ([nu_current_stock] &lt;= @nu_current_stock) ORDER BY [nu_current_stock], [vc_prod_desc]">
    <SelectParameters>
        <asp:Parameter DefaultValue="20" Name="nu_current_stock" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
</asp:Content>

