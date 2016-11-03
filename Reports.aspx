<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true" CodeFile="Reports.aspx.cs" Inherits="Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="jumbotron"  style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Get Reports...</h3>
        </div>
     <div class="form-group">
            <br />
            <asp:Label ID="lblCategory" runat="server" CssClass="col-md-3 control-label" Text="Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="vc_category_desc" DataValueField="nu_category_id" AutoPostBack="True"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_category]"></asp:SqlDataSource>
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" CssClass="col-md-3 control-label" Text="Sub Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="vc_sub_category_desc" DataValueField="nu_sub_category_id"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT [nu_sub_category_id], [vc_sub_category_desc] FROM [mst_sub_category] WHERE ([nu_category_id] = @nu_category_id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCategory" Name="nu_category_id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
            <div class="col-md-offset-3">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-primary" Text="Refresh"  />
            </div>
         <div>
        </br>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT [nu_prod_id], [vc_prod_desc], nu_buy_price*nu_current_stock AS Cost,nu_sale_price*nu_current_stock AS Value, [nu_current_stock] FROM [mst_item] WHERE ([nu_sub_category_id] = @nu_sub_category_id)">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="nu_sub_category_id" PropertyName="SelectedValue" />
            </SelectParameters>
             </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nu_prod_id" DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333" GridLines="None" Width="100%">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="nu_prod_id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="nu_prod_id" />
                <asp:BoundField DataField="vc_prod_desc" HeaderText="Name" SortExpression="vc_prod_desc" />
                <asp:BoundField DataField="Cost" HeaderText="Cost" ReadOnly="True" SortExpression="Cost" />
                <asp:BoundField DataField="Value" HeaderText="Value" ReadOnly="True" SortExpression="Value" />
                <asp:BoundField DataField="nu_current_stock" HeaderText="Stock" SortExpression="nu_current_stock" />
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

