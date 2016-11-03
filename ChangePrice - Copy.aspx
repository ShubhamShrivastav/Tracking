<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterUser.master" AutoEventWireup="true" CodeFile="ChangePrice - Copy.aspx.cs" Inherits="ChangePrice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
     <div class="jumbotron"  style="width:960px;margin-left:0px;margin-top:0px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title">Change Prices...</h3>
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
            <asp:Label ID="lblSubCategory" runat="server" CssClass="col-md-3 control-label" Text="Sub Category: "></asp:Label>
            <div class="col-md-offset-2">
                <asp:DropDownList ID="ddlSubCategory" runat="server" CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="vc_sub_category_desc" DataValueField="nu_sub_category_id" AutoPostBack="True" OnSelectedIndexChanged="ddlSubCategory_SelectedIndexChanged"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_sub_category] WHERE ([nu_category_id] = @nu_category_id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCategory" Name="nu_category_id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </div>
     <div class="form-group">
            <%--<asp:Label ID="lblPrducts" runat="server" CssClass="col-md-3 control-label" Text="Products: "></asp:Label>--%>
            <div class="col-md-offset-1">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="nu_prod_id" DataSourceID="SqlDataSource3" Width="444px" EditIndex="0" CellPadding="4" ForeColor="#333333" GridLines="None" >
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:BoundField DataField="nu_prod_id" HeaderText="nu_prod_id" InsertVisible="False" ReadOnly="True" SortExpression="nu_prod_id" Visible="False" />
                        <asp:TemplateField HeaderText="Name" SortExpression="vc_prod_desc">
                            <EditItemTemplate>
                                <asp:Label ID="lblProduct" runat="server" Text='<%# Bind("vc_prod_desc") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblProducts" runat="server" Text='<%# Bind("vc_prod_desc") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="nu_buy_price" HeaderText="Cost Price" SortExpression="nu_buy_price" />
                        <asp:BoundField DataField="nu_sale_price" HeaderText="Sale Price" SortExpression="nu_sale_price" />
                        <asp:BoundField DataField="nu_sub_category_id" HeaderText="nu_sub_category_id" SortExpression="nu_sub_category_id" Visible="False" />
                        <asp:BoundField DataField="nu_unit_id" HeaderText="nu_unit_id" SortExpression="nu_unit_id" Visible="False" />
                        <asp:BoundField DataField="nu_current_stock" HeaderText="Stock" SortExpression="nu_current_stock" />
                    </Columns>
                    <EditRowStyle BackColor="#999999" />
                    <FooterStyle BackColor="#6D8798" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#F0F3F4" Font-Bold="True" ForeColor="#484849" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#E9E7E2" />
                    <SortedAscendingHeaderStyle BackColor="#506C8C" />
                    <SortedDescendingCellStyle BackColor="#FFFDF8" />
                    <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                </asp:GridView>  
                <br />
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TrackInConnectionString %>" SelectCommand="SELECT * FROM [mst_item] WHERE ([nu_sub_category_id] = @nu_sub_category_id)" UpdateCommand="UPDATE mst_item SET nu_buy_price = @nu_buy_price, nu_sale_price = @nu_sale_price, nu_current_stock = @nu_current_stock WHERE (nu_prod_id = @nu_prod_id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlSubCategory" Name="nu_sub_category_id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="nu_buy_price" />
                        <asp:Parameter Name="nu_sale_price" />
                        <asp:Parameter Name="nu_current_stock" />
                        <asp:Parameter Name="nu_prod_id" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
        </div>
        </div>
         </div>
</asp:Content>

